# Rails Starter App

An opinionated Rails 8 starter for server-rendered apps with Hotwire,
Tailwind CSS v4, daisyUI, Stimulus, and shared agent tooling for Codex CLI and
Claude Code.

## Stack

- Rails 8
- PostgreSQL
- Hotwire + Stimulus
- Tailwind CSS v4 + daisyUI
- RSpec, FactoryBot, Shoulda Matchers, Capybara
- StandardRB and Herb
- Tidewave, Playwright MCP, DaisyUI Blueprint MCP

## Setup

1. Install dependencies:

   ```bash
   bundle install
   corepack yarn install
   ```

2. Copy the example env files you need:

   ```bash
   cp .env.example .env
   cp .env.mcp.example .env.mcp
   ```

3. Prepare the database:

   ```bash
   bin/rails db:prepare
   ```

4. Run the app:

   ```bash
   bin/dev
   ```

## Quality Checks

```bash
bundle exec rspec
bundle exec standardrb
bundle exec herb analyze .
corepack yarn build
corepack yarn build:css
```

## Agent Tooling

This repo is configured for both Codex CLI and Claude Code.

- Shared instructions live in `AGENTS.md`
- Claude-specific entrypoint lives in `CLAUDE.md`
- Core MCPs:
  - DaisyUI Blueprint
  - Playwright
  - Tidewave
- Ops MCPs:
  - Render
  - Rollbar

Codex loads the core MCPs from `.codex/config.toml`. To add the ops MCPs to
your user/global Codex config, run:

```bash
bin/setup-codex-ops-mcp
```

Claude Code loads the full project MCP set from `.mcp.json`. Open the repo in
Claude Code, then use `/mcp` to approve or authenticate servers as needed.

Put MCP-only credentials in `.env.mcp` rather than your main `.env`. Start
from `.env.mcp.example`, then restart Codex CLI or reopen Claude Code after
changing it so the MCP subprocesses pick up the new environment.

Claude users who run inside an editor should also use Ruby LSP. The generated
`.ruby-lsp/` bundle is ignored by git.

See `docs/ai-tooling.md` for setup details, troubleshooting, environment
variables, and the repo skills shipped for both agents.
