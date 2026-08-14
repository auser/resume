// Single-column, parser-safe rendering of the SAME resume.json.
// No columns, no letter-spacing, no boxes, no images -- everything that
// mangled the designed layout when run through a PDF text extractor.

#let data = json("resume.json")

#let get(obj, key, default: none) = if key in obj { obj.at(key) } else { default }
#let get-list(obj, key) = if key in obj { obj.at(key) } else { () }
#let has(obj, key) = key in obj and obj.at(key) != none and obj.at(key) != ""

#set page(paper: "us-letter", margin: 0.7in)
#set text(font: ("Helvetica", "Arial", "Liberation Sans"), size: 10pt, fill: black)
#set par(justify: false, leading: 0.55em, spacing: 0.75em)

// Standard, unstyled headers so a parser can find real section names.
#let section(label) = {
  v(9pt)
  text(size: 11.5pt, weight: "bold")[#label]
  v(2pt)
  line(length: 100%, stroke: 0.6pt + black)
  v(5pt)
}

#let card-items(prefix) = {
  let out = ()
  for c in get-list(data, "side_cards") {
    if get(c, "title", default: "").starts-with(prefix) { out = get-list(c, "items") }
  }
  out
}

// ---- Header -------------------------------------------------------------
#text(size: 19pt, weight: "bold")[#get(data, "name", default: "")]

#text(size: 10.5pt)[#get(data, "headline", default: "")]

#let c = data.contact
#let bits = (
  get(c, "location", default: ""),
  if has(c, "email") { c.email.label } else { "" },
  if has(c, "website") { c.website.url } else { "" },
  if has(c, "github") { c.github.url } else { "" },
  if has(c, "linkedin") { c.linkedin.url } else { "" },
).filter(x => x != "" and x != none)
#text(size: 9.5pt)[#bits.join(" | ")]

// ---- Summary ------------------------------------------------------------
#section("SUMMARY")
#get(data.narrative, "body", default: "")

// ---- Skills -------------------------------------------------------------
#section("SKILLS")
#get-list(data, "tags").join(", ")

#for item in card-items("CORE COMPETENCIES") [
  #v(3pt)
  #item
]

// ---- Experience ---------------------------------------------------------
#section("EXPERIENCE")
#for job in get-list(data, "experience") [
  #text(weight: "bold")[#get(job, "title", default: "")], #get(job, "company", default: "") \u{2014} #get(job, "period", default: "")
  #list(
    marker: [-],
    indent: 8pt,
    ..get-list(job, "highlights").map(h => [#h]),
  )
  #v(4pt)
]

// ---- Projects -----------------------------------------------------------
#section("SELECTED PROJECTS")
#list(
  marker: [-],
  indent: 8pt,
  ..get-list(data, "projects").map(proj => [
    #text(weight: "bold")[#get(proj, "name", default: "")] \u{2014} #get(proj, "desc", default: "")#if has(proj, "stack") [ (#proj.stack)]
  ]),
)

// ---- Education ----------------------------------------------------------
#section("EDUCATION")
#list(
  marker: [-],
  indent: 8pt,
  ..card-items("EDUCATION").map(i => [#i]),
)

// ---- Talks --------------------------------------------------------------
#section("SELECTED TALKS")
#list(
  marker: [-],
  indent: 8pt,
  ..card-items("SELECTED TALKS").map(i => [#i]),
)

// ---- Publications -------------------------------------------------------
#section("PUBLICATIONS")
#card-items("PUBLICATIONS").join(", ")

// ---- Open source --------------------------------------------------------
#section("OPEN SOURCE")
#list(
  marker: [-],
  indent: 8pt,
  ..card-items("NOTABLE OPEN SOURCE").map(i => [#i]),
)
