#import "lib/theme.typ": *
#import "lib/helpers.typ": *
#import "lib/components.typ": *
#import "lib/sections.typ": *

#let data = json("resume.json")

#set page(
  margin: (
    left: body-pad-x,
    right: body-pad-x,
    top: page-top,
    bottom: page-bottom,
  ),
  fill: bg,
)

#set text(
  font: font-stack,
  size: fs-body,
  fill: ink,
)

// Full-bleed hero, but only visually.
// The document itself still has real margins for every page.
#place(
  top + left,
  dx: -body-pad-x,
  dy: -page-top,
)[
  #box(width: 100% + body-pad-x * 2)[
    #hero(data)
  ]
]

// Push normal flow content below the hero.
#v(hero-height + proof-gap-top)

#proof-row(data)

#v(section-gap)

#summary-section(data)

#v(section-gap)

#grid(
  columns: (1.45fr, 0.90fr),
  gutter: column-gap,
  [
    #if get-list(data, "experience") != () [
      #experience-section(data)
    ]

    #if has(data, "activity") [
      #v(section-gap)
      #activity-section(data)
    ]
  ],
  [
    #side-column(data)
  ],
)

#if get-list(data, "projects") != () [
  #v(section-gap)
  #projects-section(data)
]
