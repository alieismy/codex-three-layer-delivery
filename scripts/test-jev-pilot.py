"""Offline checks for the optional Jev pilot; no API key or network is used."""

import copy
import importlib.util
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
from urllib.error import HTTPError


spec = importlib.util.spec_from_file_location("jev_pilot", Path(__file__).with_name("run-jev-pilot.py"))
pilot = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pilot)


class PilotTests(unittest.TestCase):
    def test_preparation_preserves_inputs_and_excludes_grades(self):
        _, runs = pilot.prepare()
        self.assertEqual(len(runs), 22)
        self.assertEqual(sum(len(r["payload"]["questions"]) for r in runs), 78)
        for run in runs:
            self.assertEqual(set(run["payload"]["state"]), {"material", "response"})
            self.assertNotIn(run["response_key"], pilot.encoded(run["payload"]).decode("utf-8"))
            self.assertEqual(run["request_sha256"], pilot.digest(pilot.encoded(run["payload"])))

    def test_mechanical_regressions_remain_visible(self):
        _, runs = pilot.prepare()
        by_id = {run["sample_id"]: run for run in runs}
        self.assertFalse(by_id["S01"]["mechanical"]["policy_markdown_link"])
        self.assertFalse(by_id["S01"]["mechanical"]["verbatim_clause_present"])
        self.assertTrue(by_id["S17"]["mechanical"]["verbatim_clause_present"])
        self.assertFalse(by_id["S19"]["mechanical"]["exact_revision"])
        self.assertTrue(by_id["S20"]["mechanical"]["exact_revision"])
        self.assertEqual(by_id["S16"]["mechanical"]["length"], 239)
        self.assertFalse(by_id["S16"]["mechanical"]["length_pass"])

    def test_invalid_service_results_are_rejected(self):
        good = {"model": pilot.MODEL, "answers": {"q": {"type": "choice", "choice": "satisfied",
                "confidence": 0.9, "probabilities": {"satisfied": 0.95, "violated": 0.03, "uncertain": 0.02}}},
                "usage": {"input_tokens": 100, "output_tokens": 20}}
        pilot.validate_response(good, {"q": {}})
        variants = []
        wrong_model = copy.deepcopy(good)
        wrong_model["model"] = "unexpected"
        variants.append(wrong_model)
        missing = copy.deepcopy(good)
        missing["answers"] = {}
        variants.append(missing)
        invalid_number = copy.deepcopy(good)
        invalid_number["answers"]["q"]["confidence"] = float("nan")
        variants.append(invalid_number)
        wrong_choice = copy.deepcopy(good)
        wrong_choice["answers"]["q"]["choice"] = "violated"
        variants.append(wrong_choice)
        bad_usage = copy.deepcopy(good)
        bad_usage["usage"]["input_tokens"] = -1
        variants.append(bad_usage)
        for value in variants:
            with self.subTest(value=value), self.assertRaises(ValueError):
                pilot.validate_response(value, {"q": {}})

    def test_auth_error_stops_without_retry_or_sensitive_error_text(self):
        with patch.object(pilot, "build_opener") as factory:
            factory.return_value.open.side_effect = HTTPError(pilot.ENDPOINT, 401, "SENSITIVE_SENTINEL", {}, None)
            result = pilot.call({"questions": {}}, "SENSITIVE_SENTINEL")
        self.assertEqual(result["status"], "error")
        self.assertEqual(result["attempts"], [{"status": 401}])
        self.assertNotIn("SENSITIVE_SENTINEL", str(result))
        self.assertEqual(factory.return_value.open.call_count, 1)

    def test_malformed_response_shapes_return_sanitized_errors(self):
        good = {"model": pilot.MODEL, "answers": {"q": {"type": "choice", "choice": "satisfied",
                "confidence": 0.9, "probabilities": {"satisfied": 0.95, "violated": 0.03, "uncertain": 0.02}}},
                "usage": {"input_tokens": 100, "output_tokens": 20}}
        variants = [None, [], "SENSITIVE_SENTINEL"]
        for field, value in (("answers", None), ("answers", []), ("usage", None), ("usage", [])):
            variant = copy.deepcopy(good)
            variant[field] = value
            variants.append(variant)
        for value in (None, [], "SENSITIVE_SENTINEL"):
            variant = copy.deepcopy(good)
            variant["answers"]["q"] = value
            variants.append(variant)
            variant = copy.deepcopy(good)
            variant["answers"]["q"]["probabilities"] = value
            variants.append(variant)
        for value in ([], {}):
            variant = copy.deepcopy(good)
            variant["answers"]["q"]["choice"] = value
            variants.append(variant)
        for value in variants:
            with self.subTest(value=value), patch.object(pilot, "build_opener") as factory, \
                    patch.object(pilot.json, "load", return_value=value):
                result = pilot.call({"questions": {"q": {}}}, "SENSITIVE_SENTINEL")
            self.assertEqual(result["status"], "error")
            self.assertEqual(result["attempts"], [{"error_type": "ValueError"}])
            self.assertNotIn("SENSITIVE_SENTINEL", str(result))
            self.assertEqual(factory.return_value.open.call_count, 1)

    def test_malformed_response_persists_partial_evidence(self):
        runs = [{"sample_id": sample, "payload": {"questions": {"q": {}}}} for sample in ("S01", "S02")]
        good = {"model": pilot.MODEL, "answers": {"q": {"type": "choice", "choice": "satisfied",
                "confidence": 0.9, "probabilities": {"satisfied": 0.95, "violated": 0.03, "uncertain": 0.02}}},
                "usage": {"input_tokens": 100, "output_tokens": 20}}
        with tempfile.TemporaryDirectory(prefix="jev-pilot-test-") as directory:
            output = Path(directory) / "partial.json"
            with patch.object(pilot, "prepare", return_value=("source-hash", runs)), \
                    patch.object(pilot, "build_opener"), patch.object(pilot.json, "load", side_effect=[good, []]), \
                    patch.dict(pilot.os.environ, {"TYPESAFE_API_KEY": "SENSITIVE_SENTINEL"}), \
                    patch.object(pilot.sys, "argv", ["pilot", "run", "--output", str(output)]), \
                    patch("sys.stdout", new_callable=io.StringIO):
                self.assertEqual(pilot.main(), 1)
            text = output.read_text(encoding="utf-8")
            record = json.loads(text)
            self.assertEqual(record["status"], "partial")
            self.assertEqual(len(record["runs"]), 2)
            self.assertEqual(record["runs"][0]["status"], "completed")
            self.assertEqual(record["runs"][0]["api_response"], good)
            self.assertEqual(record["runs"][1]["status"], "error")
            self.assertNotIn("SENSITIVE_SENTINEL", text)

    def test_redirects_are_not_followed(self):
        self.assertIsNone(pilot.NoRedirect().redirect_request(None, None, 302, "redirect", {}, "https://example.invalid"))


if __name__ == "__main__":
    unittest.main()
