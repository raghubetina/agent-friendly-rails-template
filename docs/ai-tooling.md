# AI Tooling

This repo is configured to work well with both Codex CLI and Claude Code.

## Shared Approach

- `AGENTS.md` is the canonical instruction file.
- `CLAUDE.md` imports `AGENTS.md` and adds only Claude-specific notes.
- Shared MCP wrapper scripts live in `bin/mcp/`.
- Shared repo skills live in both `.agents/skills/` and `.claude/skills/`.

## MCP Sets

### Core MCPs

- `daisyui-blueprint`
- `playwright`
- `tidewave`

These are the default MCPs for day-to-day implementation work in this repo.

### Ops MCPs

- `render`
- `rollbar`

These are useful when debugging deploys, logs, incidents, and production
behavior. They are enabled by default in Claude Code and opt-in for Codex.

## Environment Variables

Keep app env and MCP env separate:

- Put application/runtime variables in `.env`.
- Put MCP-only credentials in `.env.mcp`.
- Start from `.env.mcp.example`:

```bash
cp .env.mcp.example .env.mcp
```

Then add the MCP variables you actually use:

```bash
DAISYUI_BLUEPRINT_EMAIL=you@example.com
DAISYUI_BLUEPRINT_LICENSE=your_daisyui_blueprint_license
RENDER_API_KEY=your_render_api_key
ROLLBAR_ACCESS_TOKEN=your_rollbar_access_token
TIDEWAVE_MCP_URL=http://localhost:3000/tidewave/mcp
```

Notes:

- `ROLLBAR_ACCESS_TOKEN` should usually be a read-scoped project token while
  you are experimenting with the MCP.
- `RENDER_API_KEY` is broadly scoped. Treat it as sensitive.
- `TIDEWAVE_MCP_URL` defaults to `http://localhost:3000/tidewave/mcp`.
- MCP wrappers load `.env` first and `.env.mcp` second. Explicit shell
  variables still win, so `.env.mcp` is the preferred place for MCP-only
  secrets while keeping one-off overrides easy.
- After changing `.env.mcp`, restart Codex CLI or reopen Claude Code so the
  MCP subprocesses pick up the new environment.

## Claude Code

- Claude Code reads the full project MCP set from `.mcp.json`.
- Open the repo in Claude Code, then use `/mcp` to approve and authenticate
  servers.
- Claude supports project-scoped MCP config and MCP Tool Search, so the full
  core plus ops set lives in the checked-in project config.
- Claude users in editor-backed workflows should use Ruby LSP. The generated
  `.ruby-lsp/` bundle is gitignored.

## Codex CLI

- Codex reads the core MCP set from `.codex/config.toml`.
- The default Codex footprint is intentionally smaller than Claude's.
- To add the ops MCPs to your user/global Codex config, run:

  ```bash
  bin/setup-codex-ops-mcp
  ```

- To remove them later:

  ```bash
  codex mcp remove render
  codex mcp remove rollbar
  ```

## Tidewave

- Tidewave is the Rails runtime MCP for this repo.
- Start the Rails app locally before using the Tidewave MCP.
- `bin/dev` is the normal entrypoint.
- If Tidewave fails because the app is not reachable, verify the local app URL
  and `TIDEWAVE_MCP_URL`.
- If `./bin/mcp/tidewave` reports `404`, restart the Rails server. That means
  the MCP endpoint is not mounted in the currently running process.
- Tidewave is mounted as Rack middleware, so it will not necessarily appear in
  `rails routes`.

## Repo Skills

### `rails-feature-slice`

Use for end-to-end Rails feature work with the repo's preferred spec and
verification shape.

### `daisyui-stimulus-ui`

Use for server-rendered UI work with daisyUI, Stimulus, and browser
verification.

### `preflight-check`

Use before wrapping up or committing to run the repo's expected checks.
