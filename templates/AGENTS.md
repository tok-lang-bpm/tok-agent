## Process models (tok)

The process models of this project are written in tok (`*.tok` files): plain text that the tok engine turns into BPMN 2.0, SVG, DMN and Camunda forms. Never edit the exported `.bpmn`, `.dmn` or `.svg` files; change the `.tok` file and export again.

- Language on one page: run `tok cheatsheet` (install with `pip install tok-lang`), or read https://github.com/tok-lang-bpm/tok/blob/main/docs/cheatsheet.md.
- After every change: `tok check FILE --json` until there are no errors, then `tok fmt FILE -w`, then `tok export FILE -o OUT/` (or `tok bpmn FILE` and `tok svg FILE`).
- When the tok MCP server is available (`tok mcp`), use its tools `check`, `fmt`, `export`, `import`, `sim`, `eval` and `reference` instead of the command.
- Diagnostics have a code and a line; their meaning is in https://github.com/tok-lang-bpm/tok/blob/main/docs/diagnostics.md.
- A clean check is not a proof that the model matches the process: keep a table that maps each step of the description to an element of the model, and report the decisions you were unsure about.
