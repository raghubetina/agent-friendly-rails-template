---
name: rails-feature-slice
description: Implement a small Rails feature end to end using this repo's preferred slice of controller, view, model, request specs, and browser verification.
---

# Rails Feature Slice

Use this skill when you need to add or change a focused product feature in this
Rails app.

## Workflow

1. Start from the narrowest user-visible behavior.
2. Prefer a request spec for HTTP behavior and a system spec only when Turbo,
   Stimulus, or multi-step UI behavior is central.
3. Keep the implementation server-rendered unless the existing stack clearly
   requires more JavaScript.
4. Verify the smallest relevant specs first, then run the repo quality checks.

## Repo Defaults

- Prefer Rails conventions over custom architecture.
- Prefer request specs over controller specs.
- Prefer Hotwire and Stimulus over bespoke frontend layers.
- Use Playwright MCP for meaningful browser verification when UI behavior
  changes.
