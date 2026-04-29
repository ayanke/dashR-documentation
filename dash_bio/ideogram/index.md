---
url: /dash-bio/ideogram
name: Ideogram
description:
    "Dash Bio is a component library
    dedicated to visualizing bioinformatics data."
icon_path: images/icons_v2/www (1).svg
languages:
  - python
  - julia
  - r
  - matlab
thumbnail: 'ideogram.png'
---
# ![](/assets/images/language_icons/r-lang_50px.svg) dash_bio.Ideogram Examples and Reference
see [Ideogram in action](https://dash-gallery.plotly.host/dash-ideogram).

## Ideogram

An example of a default Ideogram component without any extra properties.

{{example defaultIdeogram}}

## Customization

### Height/Width
Change the size of the chromosomes in your ideogram.

{{example ideogramHeightWidth}}

### Annotations
Display annotations that are loaded from a JSON file.

{{example ideogramAnnotations}}

### Rotatability
Disable rotation of the chromosome upon clicking on it.

{{example ideogramRotatability}}

### Orientation
Display chromosomes horizontally or vertically.

{{example ideogramOrientation}}

### Brush
Highlight a region of the chromosome by adding a brush.

{{example ideogramBrush}}

{{reference dash_bio.Ideogram}}

## Example Data

- [UCSC Table Browser](https://genome.ucsc.edu/cgi-bin/hgTables)
