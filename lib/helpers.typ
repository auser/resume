#import "theme.typ": *

#let ICON_DIR = "../assets/icons/"

// Safe access helpers

#let get(obj, key, default: none) = if key in obj { obj.at(key) } else { default }
#let get-list(obj, key) = if key in obj { obj.at(key) } else { () }
#let has(obj, key) = key in obj and obj.at(key) != none and obj.at(key) != ""

#let color-token(name) = {
  if name == "accent" { accent } else if name == "orange" { orange } else if name == "cyan" { cyan } else if (
    name == "green"
  ) { green } else { accent }
}

#let heat-color(level) = {
  if level <= 0 { heat-0 } else if level == 1 { heat-1 } else if level == 2 { heat-2 } else if level == 3 {
    heat-3
  } else { heat-4 }
}


#let safe-link(value) = {
  if value == "" {
    []
  } else {
    link("https://" + value)[#value]
  }
}


#let link-item(item) = {
  if item == none { return [] }

  let url = item.url
  let label = item.label

  link(url)[#label]
}


#let icon(name, size: 9pt, color: white-soft) = box(width: size, height: size)[
  #image(ICON_DIR + name, width: size, format: "svg")
]

#let icon-link(icon-name, url, color: white-soft) = {
  if url == "" {
    []
  } else {
    link("https://" + url)[
      #icon(icon-name, color: color)
      #h(3pt)
      #url
    ]
  }
}

#let inline-list(items) = {
  let filtered = items
    .filter(item => item != none and item != "")

  [
    #for pair in filtered.enumerate() {
      let i = pair.first()
      let item = pair.last()

      item

      if i < filtered.len() - 1 {
        h(s-sm)
        [•]
        h(s-sm)
      }
    }
  ]
}