# Editorial Founder Resume (Typst)

This is a complete rewrite of the resume system with:

- JSON-driven content
- modular Typst libraries
- editorial rather than dashboard styling
- a full-width hero that does not fight the page layout
- a serious two-column body with one proof row

## Structure

- `resume.typ` — main page file
- `resume.json` — content and metrics
- `lib/theme.typ` — design tokens
- `lib/helpers.typ` — safe data access
- `lib/components.typ` — reusable UI building blocks
- `lib/sections.typ` — page sections

## Commands

```bash
just
just doctor
just build
just watch
just watch-open
```
