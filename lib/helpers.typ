#import "theme.typ": *

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
