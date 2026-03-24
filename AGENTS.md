# Agent Instructions

This file defines the shared, project-local guidance for Codex, Claude Code,
and other coding agents working in this repository.

## Start Here

- Read `README.md` for setup, tooling, and development commands.
- Read `docs/ai-tooling.md` for the repo's MCP layout, shared skills, and
  Codex versus Claude Code setup.
- This is a Rails 8 starter with server-rendered ERB, Hotwire, esbuild,
  Tailwind CSS v4, daisyUI, Stimulus, RSpec, and Tidewave.
- Prefer working with the existing stack over introducing parallel frontend or
  backend patterns.

## General Working Style

- If you are in doubt about a library, API, or framework behavior, search the
  web before proceeding.
- Before writing custom code, first look for a good library, gem, or package.
  Discuss the tradeoffs when that choice materially affects the implementation.
- If you decide to use a library, verify the actual latest version rather than
  relying on memory.
- Make sure every file you create or edit ends with a trailing newline.
- Do not add low-value comments. Comments should help future maintainers, not
  narrate obvious code.
- Do not add defensive exception handling unless exceptions are expected as part
  of normal control flow.

## Git And Commits

- Do not mention Claude or Codex in commit messages.
- Use good commit-message style:
  - subject line under 50 characters
  - wrap body lines around 70 characters
  - explain the reasoning when it will help future maintainers
- Prefer small, coherent commits over bundling unrelated work together.
- Do not revert unrelated user changes.

## Linting And Verification

- Lint before committing whenever practical.
- Ruby:
  - `bundle exec standardrb`
  - `bundle exec standardrb --fix`
- ERB and HTML:
  - `bundle exec herb analyze .`
- Tests:
  - `bundle exec rspec`
- Frontend assets:
  - `corepack yarn build`
  - `corepack yarn build:css`
- Browser verification:
  - Use Playwright MCP when UI behavior, DOM state, or real browser interaction
    matters.

## Testing Expectations

- Behavior changes should usually include an automated test.
- Pure copy changes and low-risk visual polish can rely on Playwright MCP
  verification instead of low-value specs.
- Bug fixes should include a regression spec when practical.
- Prefer the narrowest spec type that proves the behavior:
  - model or PORO specs for business logic
  - request specs for HTTP behavior, redirects, and rendered responses
  - system specs for Turbo, Stimulus, dialog behavior, and multi-step user
    flows
- Do not write specs that only prove daisyUI class names exist. Test user-
  visible behavior, content, state, and outcomes.
- When frontend behavior changes meaningfully, run the relevant system spec or
  verify it with Playwright MCP before wrapping up.
- Before committing, run the smallest relevant spec file or directory, then run
  the appropriate linters for touched files.

## Rails And Hotwire

- Prefer Hotwire over custom frontend architecture.
- Prefer Stimulus over ad hoc vanilla JavaScript.
- Prefer Turbo Streams over Turbo Frames unless Frames are clearly the better
  fit for the rendering problem.

## Front-End Guidance

- Prefer server-rendered HTML and progressive enhancement.
- Use daisyUI for component styling before writing bespoke Tailwind utility
  compositions from scratch.
- Use DaisyUI Blueprint MCP when exploring daisyUI component patterns,
  snippets, or layout ideas.
- Prefer daisyUI semantic classes such as `btn`, `card`, `alert`, `modal-box`,
  and `badge` over one-off class soups when the component already exists in
  daisyUI.
- Keep custom CSS small and purposeful. Reach for it only when daisyUI and
  regular Tailwind utilities are not enough.
- Use container queries when a component's layout depends on its parent width
  rather than the viewport. Tailwind v4 supports them directly, and they are
  often the right choice for reusable cards, toolbars, panels, and partials
  that render in different shells.
- Prefer Stimulus Components before writing custom Stimulus controllers from
  scratch for common UI behavior.
- For modal behavior, prefer native `<dialog>` plus
  `@stimulus-components/dialog`.
- Use Playwright MCP to verify frontend behavior after meaningful UI changes.
- Avoid bringing in heavy JS UI libraries unless the existing Rails +
  Hotwire + Stimulus stack is clearly insufficient.

## MCP And Local Tooling

- This repo supports both Codex CLI and Claude Code.
- Shared MCP wrapper scripts live in `bin/mcp/`.
- Core MCPs:
  - DaisyUI Blueprint for daisyUI snippets and Figma-to-daisyUI workflows
  - Playwright for browser automation and UI validation
  - Tidewave for Rails runtime introspection on the local app
- Ops MCPs:
  - Render for deployment, logs, and service inspection
  - Rollbar for application errors and deploy context
- Claude Code reads the full project MCP set from `.mcp.json`.
- Codex reads the core MCPs from `.codex/config.toml`.
- To add the ops MCPs to your user/global Codex config, run
  `bin/setup-codex-ops-mcp`.
- Keep secrets and credentials out of git. Wrapper scripts read environment
  variables from your shell, `.env`, and `.env.mcp`.
- Prefer `.env.mcp` for MCP-only secrets so the app's `.env` can stay focused
  on runtime configuration.

## Repo Skills

- This repo ships three shared skills for both Codex and Claude Code:
  - `rails-feature-slice`
  - `daisyui-stimulus-ui`
  - `preflight-check`
- Codex skills live in `.agents/skills/`.
- Claude skills live in `.claude/skills/`.
- Prefer using the repo skills for repeated workflows before writing one-off
  ad hoc instructions.

## Project Commands

- Setup:
  - `bundle install`
  - `corepack yarn install`
  - `bin/rails db:prepare`
- Development:
  - `bin/dev`
- Tests:
  - `bundle exec rspec`
- Quality:
  - `bundle exec standardrb`
  - `bundle exec herb analyze .`
  - `bin/bundler-audit check --update`
  - `bin/brakeman --no-pager`
