# tok for AI agents

This repository gives AI agents the [tok](https://github.com/tok-lang-bpm/tok) process language: the skill **tok-modelling**, which teaches an agent to turn a process description into a checked tok model and to export it to BPMN 2.0, SVG, DMN and Camunda forms, the skill **bpmn-modelling**, which teaches an agent to write BPMN 2.0 XML directly and to check, lay out and draw it with the tok engine, and the configuration of the **tok MCP server**, whose tools check tok models and BPMN XML files, format, export, import, simulate and evaluate models. The agent writes a short text; the tok engine checks it and produces the XML, so the agent never writes BPMN XML or diagram coordinates.

The guide to the language and the tools: https://tok-lang-bpm.github.io/ (chapter *Working with AI agents*).

## 1. Install tok

The MCP server is part of the Python package `tok-lang` (Python 3.8 or newer):

```
pip install tok-lang
tok mcp --version
```

With [uv](https://docs.astral.sh/uv/), `uvx tok-lang mcp` runs the server without installing anything. The server is also the program `tok-mcp` (`cargo install tok-mcp`, or the archives of https://github.com/tok-lang-bpm/tok/releases).

## 2. Add the plugin (skill and MCP server together)

In Claude Code:

```
/plugin marketplace add tok-lang-bpm/tok-agent
/plugin install tok@tok-lang-bpm
```

or from a shell: `claude plugin marketplace add tok-lang-bpm/tok-agent` and `claude plugin install tok@tok-lang-bpm`. The plugin starts the server with the command `tok mcp`; the skills are available as `tok:tok-modelling` (used whenever a task involves `.tok` files, process descriptions or BPMN and DMN models in tok) and `tok:bpmn-modelling` (when the task asks for BPMN 2.0 XML itself).

## 3. Other agents and editors

The MCP server works with every client of the Model Context Protocol. Its configuration is the command `tok` with the argument `mcp` (or `uvx` with the arguments `tok-lang mcp`):

| Client | Configuration |
|---|---|
| Claude Code without the plugin | `claude mcp add tok -- tok mcp` |
| Claude Desktop, Cursor (`.cursor/mcp.json`), Gemini CLI (`settings.json`), other clients with an `mcpServers` object | `{"mcpServers": {"tok": {"command": "tok", "args": ["mcp"]}}}` |
| VS Code (`.vscode/mcp.json`) | `{"servers": {"tok": {"type": "stdio", "command": "tok", "args": ["mcp"]}}}` |
| Codex CLI (`~/.codex/config.toml`) | `[mcp_servers.tok]` with `command = "tok"` and `args = ["mcp"]` |

The skill is the folder [`plugins/tok/skills/tok-modelling`](plugins/tok/skills/tok-modelling): `SKILL.md` with the workflow and the rules models most often break, and `references/` with the language on one page, the specification, FEEL and every diagnostic code. Agents that read skills take the folder as it is (copy it into the skills folder of the agent). For agents that read an `AGENTS.md` file, [`templates/AGENTS.md`](templates/AGENTS.md) is a short section to add to the `AGENTS.md` of a project with tok models.

Without the MCP server the skill uses the `tok` command (`tok check FILE --json`, `tok fmt -w`, `tok export`), and `tok cheatsheet` prints the language on one page as context for any agent.

## What the server offers

| Tool | What it does |
|---|---|
| `check` | diagnostics of a model, with code, line and message (English or Polish) |
| `fmt` | the canonical form of a model |
| `export` | BPMN 2.0 XML with the diagram layout, SVG, DMN 1.5, Camunda forms |
| `import` | a BPMN or DMN file as a tok model |
| `sim` | simulation indicators, event logs as CSV or XES |
| `eval` | the value of a decision for given inputs |
| `reference` | the language on one page, the specification, FEEL, the diagnostics, the command line |

Details: [docs/mcp.md](https://github.com/tok-lang-bpm/tok/blob/main/docs/mcp.md) of the tok repository.

## Good practice

A clean check means the model follows the rules of BPMN and of tok; it does not mean the model matches the real process. When the description is a numbered table of steps, or when you ask for a review of the choices, the skill has the agent write a mapping table (step of the description → element of the model) next to the model, so a person can review the decisions the agent took. Review the model and the diagram before you use them.

The skill tells the agent to read the one-page cheat sheet once and nothing else before the first check, and to open the specification only for the section a diagnostic needs: every page an agent reads comes back with every later turn, and in the evidence study of tok the agents that read the whole reference first used 4.4 to 6.5 times the tokens of a run from the one-page reference, without a significant gain in validity.

## Versions and issues

The plugin follows the version of tok (`plugins/tok/.claude-plugin/plugin.json`); when only the skills change between releases of tok, the plugin adds a fourth number (1.0.3.1 carries the skills revised after the third evidence study, with the programs of 1.0.3). The skills are maintained in the tok repository (`skills/tok-modelling`, `skills/bpmn-modelling`) and copied here with `tools/sync.sh`. Report problems in https://github.com/tok-lang-bpm/tok/issues.

## Licence

GNU General Public License v3.0 or later, as tok.
