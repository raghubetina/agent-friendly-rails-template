---
name: daisyui-stimulus-ui
description: Build or refine server-rendered UI in this repo with daisyUI, Stimulus, and Playwright verification.
---

# daisyUI + Stimulus UI

Use this skill when the task is primarily frontend behavior or HTML rendering in
this Rails app.

## Workflow

1. Start with daisyUI components before composing bespoke Tailwind class soups.
2. Prefer server-rendered ERB plus progressive enhancement.
3. Use container queries when a component should respond to its container
   instead of the viewport. Tailwind v4 supports them directly, and reusable
   partials often need them.
4. Prefer Stimulus, and then Stimulus Components, for common interaction
   patterns.
5. Use Playwright MCP after meaningful UI changes.

## Repo Defaults

- Use DaisyUI Blueprint MCP to explore component and layout patterns.
- Keep custom CSS small and purposeful.
- Do not add low-value specs that only prove class names exist.
