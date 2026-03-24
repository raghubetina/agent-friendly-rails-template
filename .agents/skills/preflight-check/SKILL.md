---
name: preflight-check
description: Run the repo's expected verification steps before wrapping up or committing.
---

# Preflight Check

Use this skill before finalizing work in this repo.

## Verification Order

1. Run the smallest relevant spec file or directory.
2. Run `bundle exec standardrb` for Ruby changes.
3. Run `bundle exec herb analyze .` when ERB changed.
4. Run `corepack yarn build` and `corepack yarn build:css` when JS or CSS changed.
5. Use Playwright MCP when browser behavior or real DOM state matters.

## Notes

- Prefer narrow verification over slow blanket reruns when the task is small.
- If a required credential-dependent MCP is unavailable, say so explicitly.
