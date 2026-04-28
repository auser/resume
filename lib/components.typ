#import "theme.typ": *
#import "helpers.typ": *


#let section-kicker(label) = [
  #text(size: fs-section, weight: "bold", tracking: tracking, fill: accent)[#label]
  #v(s-xs)
  #line(length: 100%, stroke: line-thin + rule)
]

#let bullet-line(content) = [
  #text(fill: accent)[•] #h(s-sm) #content
]

#let contact-row(data) = {
  let location = get(data.contact, "location", default: "")
  let website = get(data.contact, "website", default: "")
  let github = get(data.contact, "github", default: "")
  let linkedin = get(data.contact, "linkedin", default: "")

  text(size: fs-meta, fill: white-soft)[
    #inline-list((
      get(data.contact, "location", default: ""),
      link-item(get(data.contact, "website", default: none)),
      link-item(get(data.contact, "github", default: none)),
      link-item(get(data.contact, "linkedin", default: none)),

    ))
  ]
  // grid(
  //   columns: (auto, auto, auto, auto, auto, auto, auto),
  //   column-gutter: s-sm,
  //   align: horizon,
  //   text(size: fs-meta, fill: white-soft)[#location],
  //   text(size: fs-meta, fill: white-soft)[•],
  //   text(size: fs-meta, fill: white-soft)[#icon-link("globe.svg", website)],
  //   text(size: fs-meta, fill: white-soft)[•],
  //   text(size: fs-meta, fill: white-soft)[#icon-link("github.svg", github)],
  //   text(size: fs-meta, fill: white-soft)[•],
  //   text(size: fs-meta, fill: white-soft)[#icon-link("linkedin.svg", linkedin)],
  // )
}

#let stat-tile(item) = rect(
  fill: surface,
  stroke: line-thin + rule,
  radius: r-md,
  inset: 11pt,
)[
  #text(
    size: fs-stat,
    weight: "bold",
    fill: color-token(get(item, "color", default: "accent")),
  )[#get(item, "value", default: "")]
  #v(s-2xs)
  #text(size: fs-kicker, weight: "bold", tracking: tracking, fill: muted)[#get(item, "label", default: "")]
  #if has(item, "note") [
    #v(s-xs)
    #text(size: fs-small, fill: muted)[#item.note]
  ]
]

#let chip(label) = box(
  fill: chip-fill,
  stroke: line-thin + chip-stroke,
  radius: r-pill,
  inset: (x: 8pt, y: 3pt),
)[
  #text(size: fs-small, weight: "bold", fill: accent)[#label]
]

#let project-card(project) = rect(
  fill: surface-2,
  stroke: line-thin + rule,
  radius: r-md,
  inset: 12pt,
)[
  #text(size: fs-card-title, weight: "bold", fill: ink)[#get(project, "name", default: "")]
  #v(s-xs)
  #text(size: fs-body, fill: ink)[#get(project, "desc", default: "")]
  #if has(project, "stack") [
    #v(s-sm)
    #text(size: fs-small, fill: muted)[#project.stack]
  ]
]

#let experience-item(job) = [
  #grid(
    columns: (1fr, auto),
    gutter: 12pt,
    [
      #text(size: fs-h2, weight: "bold", fill: ink)[#get(job, "title", default: "")]
      #if has(job, "company") [
        #h(s-xs)
        #text(size: fs-h2, fill: muted)[/]
        #h(s-xs)
        #text(size: fs-h2, weight: "semibold", fill: muted)[#job.company]
      ]
    ],
    [
      #if has(job, "period") [
        #text(size: fs-small, weight: "bold", fill: muted)[#job.period]
      ]
    ],
  )
  #v(s-xs)
  #for item in get-list(job, "highlights") [
    #bullet-line(item)
    #v(s-xs)
  ]
]

#let side-card(card) = rect(
  fill: surface,
  stroke: line-thin + rule,
  radius: r-lg,
  inset: 13pt,
)[
  #section-kicker(get(card, "title", default: ""))
  #v(s-sm)

  #let style = get(card, "style", default: "bullets")
  #let items = get-list(card, "items")

  #if style == "bullets" [
    #for item in items [
      #bullet-line(item)
      #v(s-xs)
    ]
  ] else [
    #for item in items [
      #text(size: fs-body, fill: ink)[#item]
      #if item != items.last() [
        #v(s-sm)
        #line(length: 100%, stroke: line-thin + rule)
        #v(s-sm)
      ]
    ]
  ]
]

#let github-heatmap(card) = rect(
  fill: surface,
  stroke: line-thin + rule,
  radius: r-lg,
  inset: 13pt,
)[
  #section-kicker(get(card, "title", default: "ACTIVITY"))
  #v(s-sm)

  #if has(card, "headline") [
    #text(size: fs-h2, weight: "bold", fill: ink)[#card.headline]
    #v(s-sm)
  ]

  #let months = get-list(card, "months")
  #let rows = get-list(card, "rows")
  #let labels = ("", "Mon", "", "Wed", "", "Fri", "")

  #text(size: fs-small, fill: muted)[
    #box(width: heat-label-w)[]
    #for month in months [
      #box(width: heat-month-w)[#month]
      #h(heat-gap)
    ]
  ]
  #v(s-xs)

  #for row in rows.enumerate() [
    #let idx = row.at(0)
    #let cells = row.at(1)

    #box(width: heat-label-w)[
      #text(size: fs-small, fill: muted)[#labels.at(idx)]
    ]

    #for level in cells [
      #box(
        width: heat-cell,
        height: heat-cell,
        fill: heat-color(level),
        stroke: 0.2pt + rule,
        radius: r-sm,
      )[]
      #h(heat-gap)
    ]
    #linebreak()
    #v(1pt)
  ]

  #v(s-sm)
  #align(right)[
    #text(size: fs-small, fill: muted)[Less]
    #h(s-xs)
    #for level in (0, 1, 2, 3, 4) [
      #box(
        width: heat-cell,
        height: heat-cell,
        fill: heat-color(level),
        stroke: 0.2pt + rule,
        radius: r-sm,
      )[]
      #h(heat-gap)
    ]
    #text(size: fs-small, fill: muted)[More]
  ]
]

#let impact-card(item) = [
  #stack(
    spacing: 4pt,
    [
      #text(weight: "bold")[#item.title]
      #text(size: 9pt, fill: gray)[#item]
      #text(size: 10pt)[#item.desc]
    ]
  )
]

#let system-card(item) = [
  #stack(
    spacing: 4pt,
    [
      #text(weight: "bold")[#item.name]
      #text(size: 10pt)[#item.desc]
      #text(size: 8pt, fill: gray)[#join(item.tags, " • ")]
    ]
  )
]