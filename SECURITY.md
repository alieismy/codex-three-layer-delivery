# Security Policy

## Supported Versions

The latest released version is supported.

## Reporting a Vulnerability

Open a private security advisory if the issue involves:

- leaked credentials or tokens;
- unsafe default permissions;
- prompt-injection trust-boundary mistakes;
- commands that may cause data loss;
- MCP configuration that routes data to unexpected third parties.

If private advisories are not enabled, contact the maintainer privately before publishing exploit details.

## Secret Handling

Never commit:

- `.env` files with real values;
- API keys;
- access tokens;
- private keys;
- certificates;
- personal relay URLs that imply account ownership.

Only placeholder examples belong in this repository.
