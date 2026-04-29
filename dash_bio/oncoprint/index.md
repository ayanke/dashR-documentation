---
url: /dash-bio/oncoprint
name: OncoPrint
description:
    "Dash Bio is a component library
    dedicated to visualizing bioinformatics data."
icon_path: images/icons_v2/www (1).svg
languages:
  - python
  - julia
  - r
  - matlab
thumbnail: 'oncoprint.png'
---
# ![](/assets/images/language_icons/r-lang_50px.svg) dash_bio.OncoPrint Examples and Reference
see [OncoPrint in action](https://dash-gallery.plotly.host/dash-onco-print).

## OncoPrint

An example of a default OncoPrint component without any extra properties.

{{example defaultOnco}}

## Customization

### Colors
Change the color of specific mutations, as well as the background color.

{{example oncoColor}}

### Size And Spacing
Change the height and width of the component, and adjust the spacing between adjacent tracks.

{{example oncoSize}}

### Legend And Overview
Show or hide the legend and/or overview heatmap.

{{example oncoLegend}}

{{reference dash_bio.OncoPrint}}

## Example Data

- https://github.com/plotly/datasets/blob/master/Dash_Bio/Chromosomal/oncoprint_dataset3.json
