// Cover letter template
//
// Personal details come from resume.json. Customize the job-specific values in
// cover-letter.json, then run:
//   typst compile cover-letter-template.typ build/cover-letter.pdf
//
// To use a different letter configuration:
//   typst compile --input config=letters/acme.json \
//     cover-letter-template.typ build/acme-cover-letter.pdf

// Keep the finished letter to one page. Concrete examples and measured outcomes
// are usually more persuasive than a list of responsibilities.

#let config-path = sys.inputs.at("config", default: "cover-letter.json")
#let resume = json("resume.json")
#let config = json(config-path)
#let document = config.document
#let sender = config.sender
#let recipient = config.recipient
#let letter = config.letter
#let typography = document.typography
#let spacing = document.spacing_pt

// Letter strings in the JSON file may use these tokens. Add replacements here
// if you introduce more reusable fields.
#let resolve(value) = (
  value
    .replace("{{role}}", letter.role)
    .replace("{{company}}", recipient.company)
    .replace("{{recipient_name}}", recipient.name)
    .replace("{{sender_name}}", resume.name)
)

// ---------------------------------------------------------------------------
// Rendering logic. Visual settings live under `document` in cover-letter.json.

#let ink = rgb(document.colors.ink)
#let muted = rgb(document.colors.muted)
#let accent = rgb(document.colors.accent)
#let rule = rgb(document.colors.rule)

#set page(
  paper: document.paper,
  margin: (
    x: document.margins_in.x * 1in,
    top: document.margins_in.top * 1in,
    bottom: document.margins_in.bottom * 1in,
  ),
)

#set text(
  font: document.font_stack,
  size: typography.body_size_pt * 1pt,
  fill: ink,
)

#set par(
  leading: typography.body_leading_em * 1em,
  justify: typography.body_justify,
)

#show link: set text(fill: ink)

#let contact-item(value, destination: none) = {
  if destination == none {
    value
  } else {
    link(destination)[#value]
  }
}

// Contact keys resolve to resume.json unless they are cover-letter-specific.
#let sender-contact(key) = {
  if key == "location" {
    resume.contact.location
  } else if key == "phone" {
    contact-item(sender.phone.label, destination: sender.phone.url)
  } else {
    let item = resume.contact.at(key)
    contact-item(item.label, destination: item.url)
  }
}

#let separator = [
  #h(document.contact_separator_gap_em * 1em)
  #text(fill: muted)[#document.contact_separator]
  #h(document.contact_separator_gap_em * 1em)
]

#align(center)[
  #text(
    size: typography.name_size_pt * 1pt,
    weight: typography.name_weight,
    tracking: typography.name_tracking_em * 1em,
  )[#resume.name]
  #v(spacing.name_to_title * 1pt)
  #text(
    size: typography.title_size_pt * 1pt,
    weight: typography.title_weight,
    fill: accent,
  )[#sender.title]
  #v(spacing.title_to_contacts * 1pt)
  #text(size: typography.contact_size_pt * 1pt, fill: muted)[
    #for (row-index, row) in document.contact_rows.enumerate() {
      for (item-index, key) in row.enumerate() {
        if item-index > 0 { separator }
        sender-contact(key)
      }
      if row-index < document.contact_rows.len() - 1 { linebreak() }
    }
  ]
]

#v(spacing.header_to_rule * 1pt)
#line(length: 100%, stroke: document.rule_weight_pt * 1pt + rule)
#v(spacing.rule_to_date * 1pt)

#letter.date

#v(spacing.date_to_recipient * 1pt)

#recipient.name \
#recipient.title \
#recipient.company \
#recipient.address \
#recipient.location

#v(spacing.recipient_to_subject * 1pt)

#text(weight: typography.subject_weight)[#resolve(letter.subject)]

#v(spacing.subject_to_salutation * 1pt)

#resolve(letter.salutation)

#v(spacing.salutation_to_body * 1pt)

#for paragraph in letter.paragraphs [
  #resolve(paragraph)
  #v(spacing.between_paragraphs * 1pt)
]

#v(spacing.body_to_signoff * 1pt)

#letter.signoff

#v(spacing.signoff_to_signature * 1pt)

#text(weight: typography.signature_weight)[#resume.name]
