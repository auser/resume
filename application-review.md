# Resume review and application strategy

Prepared September 14, 2026. Source: `resume.json` in `auser/resume` at commit `d5a677ba9628b59742b92462d3ccb23481304e20` (blob `6f8c59317d6b2cab4e0b8b0a90da47209be0f2a9`). Career claims and dates are source-reported, not independently audited.

**Working target: Principal Software Engineer — Platform Infrastructure & AI Security.** This target is an explicit assumption, not a job title Ari is represented as having held. No employer, job posting, or confirmed target title was supplied. Exact posting-language matching and employer-specific problem framing remain pending that input.

## 1. First impression

The proof is stronger than the positioning. The original opening reads like a founder's technical manifesto: secure execution, deterministic runtimes, semantic identity, applied mathematics, and formal proofs compete for attention before the reader reaches recognizable delivery outcomes.

The strongest hiring story is already present: a bank platform serving 100K+ customers, a seven-person core replacement maintaining 99.9% uptime, production AI/ML work at AWS, and a founder-built education business reaching $2M+ annual revenue. Those belong near the top for the assumed role.

The main credibility risk is not insufficient ambition. It is that narrow or under-specified claims can be read too broadly: a bf16 GELU lookup benchmark is not an end-to-end model benchmark; a model-artifact compression ratio does not establish output quality; potential loss avoidance is not realized savings. Rewriting should narrow those claims rather than amplify them.

## 2. Number- and outcome-led bullets

All **45 original experience bullets** have outcome-led replacements in `application-profile.json`, each mapped by role and `source_bullet`. The exported `complete-bullet-rewrite.md` contains every rewrite plus its selection and verification notes. **20 bullets** are selected for the two-page application resume. The other 25 remain in the review bank; they are not all submission-ready.

No estimates were invented. Numbers in the selected resume come from the source. One optional bank bullet counts the three AT&T locations explicitly named in the source; it is a count, not an estimate. Where there is no defensible measurement, a concrete engineering or business outcome leads instead.

Representative rewrites:

- **100K+ customers** supported by architecting a cloud-native, multi-tenant core banking platform.
- **99.9% uptime** maintained while leading a **7-person team** replacing an end-of-life core banking platform.
- **$2M+ annual revenue and 50K+ students** reached by founding and scaling newline.io, formerly Fullstack.io.
- **18 security claims** tied to executable CI checks, covering signed execution plans, tamper-evident audit logs, verified boot, and sealed production images.
- Kept raw credentials outside guest workloads through vsock secret substitution and PII redaction, including detection across frame boundaries.

For future estimates, record the evidence, timeframe, baseline, calculation, and uncertainty before using a range. Do not estimate a flattering number and work backward. A range belongs in a draft only until Ari can defend it.

## 3. What to emphasize, compress, and cut

| Material | Treatment for this target | Reason |
|---|---|---|
| MVM isolation, explicit authority, secret handling, CI security checks | Lead current experience | Direct evidence of platform and AI-security engineering. |
| Banking customer scale, migration leadership, uptime | Prominent in summary and experience | Connects architecture to service reliability and users. |
| AWS distributed ML and delivery automation | Keep three bullets | Shows production systems experience and recognizable scope. |
| newline revenue, developer reach, publishing | Keep three bullets | Demonstrates execution, communication, and business ownership. |
| Hologram interoperability and CPU model compilation | Keep two concise bullets; mark inference experimental | Preserves technical differentiation without asserting demonstrated general inference performance. |
| Earlier roles | One outcome each | Preserves chronology and relevance without overwhelming recent work. |
| Detailed prime/resonance algebra, F1 geometry, RH discussion | Omit from this application; retain original portfolio | Requires substantial explanation unrelated to the assumed hiring decision. |
| Repeated projects, full book list, old talks, crate-download counters | Omit | Avoids duplicating experience and unsupported live popularity claims. |
| RoboRef, farming details, policy advising | Keep in the bank | Better suited to robotics, agriculture, government, or policy roles. |

### Claims requiring stronger context

The selected resume still needs owner confirmation of the dates, customer/student counts, revenue period, uptime window, team scope, SOC 2 attestation scope, and MVM claim coverage. Being in the source does not make a claim independently verified.

The application omits the source's **85% fraud reduction**, **300K transactions/second**, **$10M+ potential losses prevented**, **100% audit coverage**, **50% development-time improvement**, **90% accuracy improvement**, and **40% productivity improvement** because their definitions or measurement conditions are not provided. Their original context is preserved in the bank's review notes, not silently converted into new claims.

The reported **~28x** result is specifically a **bf16 GELU** comparison in the source; it must not become “28x faster AI inference.” The **28.1x compression** claim needs artifact-size definitions, quality results, and the meaning of the residual certificate. The source's provisional patent details should be checked before making any current patent-pending statement.

Several roles overlap. Preserve those dates unless corrected by Ari; do not invent full-time, part-time, consulting, or concurrent-employment explanations. The source gives years, not months. No months have been manufactured. Historical employment titles remain unchanged.

## 4. Summary and job-posting alignment

The resume headline uses the assumed target title as positioning, not as a replacement for any employer-issued title. The current summary is:

> Systems engineering leader building secure execution infrastructure, distributed systems, and AI platforms in Rust and AWS. Architected banking infrastructure serving 100K+ customers and led a 7-person platform replacement while maintaining 99.9% uptime. Founder of MVM, focused on hardware-isolated execution of AI agents and untrusted code; previously built production AI/ML systems at AWS and scaled newline.io to $2M+ annual revenue.

This is a role-oriented baseline, **not an exact match to an unseen job posting**. Once a posting is supplied, map each important requirement to a source-supported example. Adopt exact terminology only where truthful. Do not add missing skills, degrees, clearances, management scope, production adoption, or requirements merely for keyword matching.

## 5. Cover letter

`cover-letter-120-words.txt` contains exactly **120 whitespace-delimited words**, excluding any future salutation or signature. Its opening assumes a platform/AI-security team's problem; it is not a researched claim about an unidentified employer. Company-specific tailoring remains pending.

The letter is generated from `cover_letter_paragraphs` in the profile so the version in the package cannot drift from the word-count check. Substituting an employer or job title should be followed by another count.

## 6. Single-column application layout

The application PDF and DOCX use two US Letter pages, Arial body text, a single reading column, conventional section headings, contact details in the main document body, unchanged employment titles, and consistent year ranges. There are no photos, tables, text boxes, sidebars, graphs, or contact details hidden in headers or footers. Literal hyphen markers avoid Symbol-font private-use characters in extracted PDF text.

Greenhouse's own parsing guidance identifies columned layouts, graphics, tables, header/footer contact details, and unclear sections as potential parsing failures: https://support.greenhouse.io/hc/en-us/articles/200989175-Unsuccessful-resume-parse (reviewed September 14, 2026).

**Validation performed:** DOCX rendered and both pages visually inspected; the exported PDF has two pages; all 20 selected bullets survive text extraction in order; the cover-letter body has 120 words. No commercial ATS was invoked, so this is a structurally conservative, text-checked resume, not a promise that every ATS will parse every field correctly.

The existing founder `resume.json`, `resume.typ`, and `resume-ats.typ` remain unchanged. The application is a separate profile and build command, so both versions remain available.

## 7. Recruiter-search simulation

This is a transparent, qualitative simulation using the provisional title, not a real employer ranking, an ATS score, a LinkedIn search execution, or a percentile among unknown applicants.

Example full-text query:

```text
("principal software engineer" OR "staff software engineer")
AND (Rust OR AWS)
AND ("distributed systems" OR "platform infrastructure")
AND (security OR isolation)
```

| Screening method | Simulated assessment |
|---|---|
| Literal full-text search over the rewritten resume | Matches the example query: the target title, relevant technologies, systems terms, and security language are present. |
| Strict historical/current employment-title filter | Does not establish a match for Principal Software Engineer: the actual titles remain Founder, Chief Innovation Officer, Chief Technical Officer, Senior Technology Lead, and the other original titles. |
| Human review for a hands-on platform/security principal role | **Shortlist for an initial technical screen**, conditional on the actual posting. Relevant system-building evidence is strong. |
| Human review for an inference-research role | **Potential fit, technical verification required.** The application intentionally does not claim validated end-to-end inference performance or quality. |
| Human review for a role requiring large engineering organizations | **Scope not established.** A seven-person project team does not substantiate leading dozens of teams or managers. |

My simulated before/after judgment is **“interesting founder; role fit unclear” → “credible platform/security candidate worth an initial screen.”** The rewrite changes visibility and clarity, not the underlying qualifications.

For a real screen, remaining questions are cross-team technical influence, production-scale ownership, on-call and incident responsibility, measurement baselines, and the relationship between current founder work and a prospective employment role. Do not claim these answers before Ari supplies them.

LinkedIn distinguishes job-title filters, which use Experience titles, from keyword searches over profile content: https://www.linkedin.com/help/recruiter/answer/a414428 (reviewed September 14, 2026). Editing a resume file does **not** edit the LinkedIn profile or automatically change its recruiter-search ranking.
