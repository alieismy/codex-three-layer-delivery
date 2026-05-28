# MCP Routing

MCP servers should be enabled for specific evidence or workflow needs, not as a broad default.

## Routing Table

| Need | Preferred route | Notes |
|---|---|---|
| Library, framework, or SDK documentation | Context7 | Enable when official docs or examples are needed. |
| Current web research | Codex built-in web search or Tavily | Use current sources for time-sensitive facts. |
| Complex multi-option reasoning | Native model reasoning first; Sequential Thinking on demand | Enable only when an explicit reasoning trace tool is useful. |
| Open-source project architecture | DeepWiki on demand | Use for public GitHub projects. |
| Independent search index | Brave Search on demand | Requires API key and account setup. |
| Browser automation and E2E testing | Playwright CLI or built-in browser tooling first | Enable Playwright MCP only when it improves the workflow. |
| Frontend network/performance debugging | Chrome DevTools MCP on demand | Disabled by default. |
| Cross-repository code analysis | Augment Context Engine on demand | Do not ship personal relay URLs. |

## Public Template Rules

- Do not use `@latest` in npm MCP commands.
- Do not enable API-key MCP servers until credentials are configured.
- Do not hardcode private relay URLs.
- Keep external services disabled by default unless the repository clearly documents their data flow.
- Record verified package versions in `docs/compatibility.md`.
