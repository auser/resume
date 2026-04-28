#import "theme.typ": *
#import "helpers.typ": *
#import "components.typ": *

#let hero(data) = rect(
  width: 100%,
  fill: navy,
  inset: (
    left: hero-pad-x,
    right: hero-pad-x,
    top: hero-pad-y-top,
    bottom: hero-pad-y-bottom,
  ),
)[
  #grid(
    columns: (1.6fr, 1fr),
    gutter: hero-gap,
    [
      #text(size: fs-name, weight: "bold", fill: white)[#get(data, "name", default: "")]
      #v(s-sm)
      #text(size: fs-role, weight: "semibold", fill: accent-soft)[#get(data, "headline", default: "")]
      #v(s-md)
      #text(size: fs-meta, fill: white-soft)[
        #get(data.contact, "location", default: "")
        #h(s-sm)•#h(s-sm)
        #get(data.contact, "website", default: "")
        #h(s-sm)•#h(s-sm)
        #get(data.contact, "github", default: "")
        #h(s-sm)•#h(s-sm)
        #get(data.contact, "linkedin", default: "")
      ]
    ],
    [
      #rect(
        fill: hero-panel-fill,
        stroke: line-thin + hero-panel-stroke,
        radius: r-lg,
        inset: 14pt,
      )[
        #text(size: fs-kicker, weight: "bold", tracking: tracking, fill: accent-soft)[FOUNDER THESIS]
        #v(s-sm)
        #text(size: fs-body, weight: "bold", fill: white)[#get(data.narrative, "hook", default: "")]
      ]
    ],
  )
]

#let proof-row(data) = [
  #let stats = get-list(data, "stats")
  #let cols = calc.min(stats.len(), 4)

  #if stats.len() > 0 [
    #grid(
      columns: (..array.range(0, cols).map(_ => 1fr)),
      gutter: column-gap,
      row-gutter: column-gap,
      ..stats.map(item => stat-tile(item)),
    )
  ]
]

#let summary-section(data) = [
  #section-kicker("NARRATIVE")
  #v(s-sm)
  #text(size: fs-body, fill: ink)[#get(data.narrative, "body", default: "")]
  #let tags = get-list(data, "tags")
  #if tags != () [
    #v(s-md)
    #for tag in tags [
      #chip(tag)
      #h(s-xs)
    ]
  ]
]

#let experience-section(data) = [
  #section-kicker("EXPERIENCE")
  #v(s-sm)
  #for job in get-list(data, "experience") [
    #experience-item(job)
    #if job != get-list(data, "experience").last() [
      #v(s-sm)
      #line(length: 100%, stroke: line-thin + rule)
      #v(s-sm)
    ]
  ]
]

#let projects-section(data) = [
  #section-kicker("SELECTED PROJECTS")
  #v(s-sm)
  #let projects = get-list(data, "projects")

  #for i in range(0, projects.len(), step: 2) [
    #grid(
      columns: (1fr, 1fr),
      gutter: column-gap,
      [#project-card(projects.at(i))],
      [
        #if i + 1 < projects.len() [
          #project-card(projects.at(i + 1))
        ]
      ],
    )

    #if i + 2 < projects.len() [
      #v(column-gap)
    ]
  ]
]

#let activity-section(data) = [
  #section-kicker(get(data.activity, "title", default: "CONTRIBUTION ACTIVITY"))
  #v(s-sm)
  #github-heatmap(data.activity)
]

#let side-column(data) = [
  #for card in get-list(data, "side_cards") [
    #side-card(card)
    #if card != get-list(data, "side_cards").last() [
      #v(section-gap)
    ]
  ]
]


#let selected-impact(data) = [
  #if "selected_impact" in data {
    stack(
      spacing: 12pt,
      [
        #text(weight: "bold", size: 14pt)[Selected Impact]

        #grid(
          columns: 4,
          gutter: 12pt,
          ..data.selected_impact.map(item => impact-card(item))
        )
      ]
    )
  }
]

#let systems-i-build(data) = [
  #if "systems_i_build" in data {
    stack(
      spacing: 12pt,
      [
        #text(weight: "bold", size: 14pt)[Systems I Build]

        #grid(
          columns: 2,
          gutter: 16pt,
          ..data.systems_i_build.map(item => system-card(item))
        )
      ]
    )
  }
]