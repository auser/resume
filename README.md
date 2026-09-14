# Ari Lerner: founder and application resumes

Two deliberately separate versions are maintained:

- **Founder / portfolio resume:** the original `resume.json`, modular Typst templates, and designed two-column layout.
- **Application resume:** `application-profile.json`, a focused two-page, single-column PDF/DOCX with outcome-led bullets and a 120-word cover letter.

The application currently assumes **Principal Software Engineer — Platform Infrastructure & AI Security**. No job posting was supplied; the title is positioning, not a changed historical job title. Edit `target`, `summary`, selection flags, and letter only after confirming the actual role. `application-review.md` explains the full review and remaining evidence checks.

## Founder version

`resume.typ` and `resume-ats.typ` use the unchanged original `resume.json`. Modular styling remains in `lib/theme.typ`, `lib/helpers.typ`, `lib/components.typ`, and `lib/sections.typ`.

```bash
just
just doctor
just build
just watch
just watch-open
```

## Application version

Python 3.10+ and python-docx are required. PDF export additionally requires LibreOffice. The PDF validation command uses Poppler (`pdftotext` and `pdfinfo`). The builder performs no network requests.

```bash
python3 -m venv .venv-application
source .venv-application/bin/activate
python -m pip install -r requirements-application.txt

# DOCX, Markdown, plain text, all 45 rewrites, and the cover letter:
just build-application

# Also export the two-page PDF using LibreOffice:
just build-application-pdf

# Check generated structure, content, reading order, and word count:
just check-application
```

Equivalent commands without Just:

```bash
python scripts/build_application.py --pdf
python scripts/check_application.py --pdf
```

Output: `build/application/`. Open and visually inspect both pages after any content changes. The explicit page break is tuned to this profile; changing the target or selection can change pagination.

## Application source and review

`application-profile.json` contains all **45** rewritten experience bullets. `include: true` selects the **20** used in this version. `source_bullet` maps each rewrite to its original bullet within the same employer entry. Review notes are never printed in the submitted resume. `complete-bullet-rewrite.md` is generated for editorial review, not submission.

The profile records the source commit, the provisional target, and the fact that numerical claims are source-reported rather than independently audited. No fabricated metrics or estimated ranges have been introduced. Conditional, benchmark-specific, and unsupported-scope claims are excluded or qualified; see the review notes before reusing them.

The cover letter must contain exactly 120 whitespace-delimited words in its body. Salutations and signatures are not generated or counted. The builder rejects other lengths so editing a title cannot silently break the requested length.

These checks establish document structure and text preservation, **not** a universal ATS score or an employer ranking. Nothing edits LinkedIn, submits an application, changes the original founder content, or publishes an application release automatically.
