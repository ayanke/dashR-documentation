---
url: /dash-bio/circos
name: Circos
description:
    "Dash Bio is a component library
    dedicated to visualizing bioinformatics data."
icon_path: images/icons_v2/www (1).svg
languages:
  - python
  - r
  - matlab
thumbnail: 'circos.png'
---
# ![](/assets/images/language_icons/r-lang_50px.svg) dash_bio.Circos Examples and Reference
see [Circos in action](https://dash-gallery.plotly.host/dash-circos).

## Circos
An example of a default Circos layout with heatmap or chords tracks.

{{example defaultCircos}}

## Customization

### Layout
Configure layout's inner, outer and corner radii, labels and ticks.

{{example customCircos}}

### Chords

{{example chordsCircos}}

**Data format:**
```python
data = [
  {
    "source": {
      "id": "chr19",
      "start": 22186054,
      "end": 36186054
    },
    "target": {
      "id": "chr17",
      "start": 21478117,
      "end": 85478117
    },
  },
  ...
]
```
Optionally each datum can define a `value` attribute to draw colored ribbons with color palettes.

**Configuration options:**

[color](#color), [logScale](#logscale), [logScaleBase](#logscalebase), [max](#max-and-min), [min](#max-and-min), [opacity](#opacity), [radius](#radius), [tooltipContent](#tooltipcontent), [zIndex](#zindex)

### Heatmap

{{example heatmapCircos}}

**Data format:**
```python
data = [
  {
    "block_id": "chr1",
    "start": 0,
    "end": 9999999,
    "value": 234
  },
  ...
]
```

**Configuration options:**

[color](#color), [innerRadius](#innerradius-and-outerradius), [logScale](#logscale), [logScaleBase](#logscalebase), [max](#max-and-min), [min](#max-and-min), [outerRadius](#innerradius-and-outerradius), [tooltipContent](#tooltipcontent)

### Highlight

{{example highlightCircos}}

**Data format:**
```python
data = [
  {
    "block_id": "chr1",
    "start": 0,
    "end": 9999999,
    "gieStain": "rgb(200,200,200)" # custom key with CSS color code
    # use it in 'color' configuration option like this: { 'color': { 'name': 'gieStain' } } to highlight different parts of the track
  },
  ...
]
```

**Configuration options:**

[color](#color), [innerRadius](#innerradius-and-outerradius), [logScale](#logscale), [logScaleBase](#logscalebase), [max](#max-and-min), [min](#max-and-min), [outerRadius](#innerradius-and-outerradius), [strokeColor](#strokecolor), [strokeWidth](#strokewidth), [opacity](#opacity), [tooltipContent](#tooltipcontent)

### Histogram

{{example histogramCircos}}

**Data format:**
```python
data = [
  {
    "block_id": "chr1",
    "start": 0,
    "end": 9999999,
    "value": 234
  },
  ...
]
```

**Configuration options:**

[axes](#axes), [color](#color), [innerRadius](#innerradius-and-outerradius), [logScale](#logscale), [logScaleBase](#logscalebase), [max](#max-and-min), [min](#max-and-min), [opacity](#opacity), [outerRadius](#innerradius-and-outerradius), [tooltipContent](#tooltipcontent), [zIndex](#zindex)

### Line

{{example lineCircos}}

**Data format:**
```python
data = [
  {
      "block_id": "chr1"
      "position": 499999.5,
      "value": 0.006405,
  },
  ...
]
```

**Configuration options:**

[axes](#axes), [backgrounds](#backgrounds), [color](#color), [direction](#direction), [fill](#fill), [fillColor](#fillcolor), [innerRadius](#innerradius-and-outerradius), [logScale](#logscale), [logScaleBase](#logscalebase), [max](#max), [min](#min), [opacity](#opacity), [outerRadius](#innerradius-and-outerradius), [strokeColor](#strokecolor), [strokeWidth](#strokewidth), [zIndex](#zindex)

### Scatter

{{example scatterCircos}}

**Data format:**
```python
data = [
  {
      "block_id": "chr1"
      "position": 499999.5,
      "value": 0.006405,
  },
  ...
]
```

**Configuration options:**

[axes](#axes), [backgrounds](#backgrounds), [color](#color), [direction](#direction), [fill](#fill), [innerRadius](#innerradius-and-outerradius), [logScale](#logscale), [logScaleBase](#logscalebase), [max](#max-and-min), [min](#max-and-min), [opacity](#opacity), [outerRadius](#innerradius-and-outerradius), [shape](#shape), [size](#size), [strokeColor](#strokecolor), [strokeWidth](#strokewidth), [zIndex](#zindex)

### Stack

{{example stackCircos}}

**Data format:**
```python
data = [
  {
    "block_id": "chr1",
    "start": 0,
    "end": 9999999,
  },
  ...
]
```

**Configuration options:**

[axes](#axes), [backgrounds](#backgrounds), [color](#color), [direction](#direction), [fill](#fill), [innerRadius](#innerradius-and-outerradius), [logScale](#logscale), [logScaleBase](#logscalebase), margin, [max](#max-and-min), [min](#max-and-min), [opacity](#opacity), [outerRadius](#innerradius-and-outerradius), radialMargin, [strokeColor](#strokecolor), [strokeWidth](#strokewidth), [thickness](#thickness), [tooltipContent](#tooltipcontent)

### Text

{{example textCircos}}

**Data format:**
```python
data = [
  {
    "block_id": "chr1",
    "position": 1150000,
    "value": "p36.33",
  },
  ...
]
```

**Configuration options:**

[innerRadius](#innerradius-and-outerradius), [outerRadius](#innerradius-and-outerradius), [style](#style)

### Tracks configuration options reference

#### `axes`

A `list` of `dict`s with axes configurations.

Styling options:
- `color` (default: `#d3d3d3`)
- `thickness` (in pixel, default: `1`)
- `opacity` (value between `0` and `1`, default: track opacity)

Positioning options:
- `position` (generate a single axis at a given position; value between the `min` and `max` values of the track)
- `spacing` (generate a range of evenly spaced axes)
- `start` (optional property used when `spacing` is defined; value between the `min` and `max` values of the track; default: `max` value of the track)
- `end` (optional property used when `spacing` is defined; value between the `min` and `max` values of the track; default: `max` value of the track)

Example:
```python
{
  'axes': [
    {
      'color': 'red',
      'position': 4,
      'opacity': 0.3
    },
    {
      'color': 'red',
      'spacing': 2,
      'end': 4
    },
    {
      'color': 'green',
      'spacing': 1,
      'start': 4,
      'end': 16,
      'thickness': 1
    }
  ]
}
```

#### `backgrounds`
A `list` of `dict`s with background configurations.

Styling options:
- `color` (default: `#d3d3d3`)
- `opacity` (between `0` and `1`, default: track's opacity)

Positioning options:
- `start` (value between the `min` and `max` values of the track; default: `min` value of the track)
- `end` (value between the `min` and `max` values of the track; default: `max` value of the track)

Example:
```python
{
  backgrounds: [
    {
      start: 0.006,
      color: '#4caf50',
      opacity: 0.1
    },
    {
      start: 0.002,
      end: 0.006,
      color: '#d3d3d3',
      opacity: 0.1
    },
    {
      end: 0.002,
      color: '#f44336',
      opacity: 0.1
    }
  ]
}
```

#### `color`

The color attribute can be either:

* CSS color code, e.g: `#d3d3d3`, `blue`, `rgb(0, 0, 0)`
* Palette name, e.g. `'BrBG'`

Available palette names: BrBG, PRGn, PiYG, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral, Blues, Greens, Greys, Oranges, Purples, Reds, BuGn, BuPu, GnBu, OrRd, PuBuGn, PuBu, PuRd, RdPu, YlGnBu, YlGn, YlOrBr, YlOrRd (from [d3-scale-chromatic](https://github.com/d3/d3-scale-chromatic))

When using pallete name, the color will be computed dynamically according to the track data `value` field.

If you prefix the palette name with a `-` (e.g `-BrBG`), the palette will be reversed.

* `dict` with `name` key:
```python
{
  'color': {
    'name': 'property_of_track_data_element'
    # value of `name` should be the property name of track's data elements, holding CSS color value
  }
}
```
See example usage in [highlight](#highlight) track configuration.

#### `direction`

`in` or `out`. Default: `out`. For stack you can also use `center`.

#### `fill`

`bool`

#### `fillColor`

CSS color code, e.g: `#d3d3d3`, `blue`, `rgb(0, 0, 0)`

#### `innerRadius` and `outerRadius`

For layout configuration `innerRadius` and `outerRadius` values are always interpreted as a number of pixels.

For track configuration:

If `innerRadius` and `outerRadius` are between `0` and `1`, the value is interpreted as a fraction of the `innerRadius` of the layout.

If `innerRadius` and `outerRadius` are between `1` and `10`, the value is interpreted as a fraction of the `outerRadius` of the layout.

Otherwise it is interpreted as a number of pixels.

#### `logScale`

`bool`. Default is `False`.

#### `logScaleBase`

The log base if `logScale` is `True`. Default is `Math.E`.

#### `max` and `min`

The default `min` and `max` values are computed automatically based on the dataset. You can override these values by specifying a `min` or `max` attribute in the configuration.

#### `opacity`

`float` between `0` and `1`. Default is `1`.

#### `radius`

In the chords configuration you can specify a radius parameter.

If the value is between `0` and `1`, it is interpreted as a fraction of the `innerRadius` of the layout.

If the value is greater than `1`, it is interpreted as a number of pixels.

Default value is the `innerRadius` of the layout.

#### `shape`

One of:
- `circle`
- `cross`
- `diamond`
- `square`
- `triangle`
- `star`
- `wye`

#### `strokeColor`

CSS color code, e.g: `#d3d3d3`, `blue`, `rgb(0, 0, 0)`

#### `strokeWidth`
`int`

#### `style`
`dict` with CSS styles.

#### `thickness`
`int`

#### `tooltipContent`

Available options:

```python
#  display all key-value pairs of track's data elements
{
  'tooltipContent': {
      'name': 'all',
  }
}
# display value of any property specified on track's data elements
{
  'tooltipContent': {
      'name': 'property_name',
  }
}
# display tooltip content in form: d[source] + ' > ' + d[target] + ': ' + d[targetEnd]
# (e.g. d["block_id"] + ' > ' + d["position"] + ': ' + d["value"])
{
  'tooltipContent': {
    "source": "block_id",
    "target": "position",
    "targetEnd": "value"
  }
}
```

For [chords](#chords) track with nested `dict`s:

```python
# display tooltip content in form: d[source][sourceID] + ' > ' + d[target][targetID] + ': ' d[target][targetEnd]
# (e.g. d["source"]["id"] + ' > ' + d["target"]["id"] + ': ' + d["target"]["end"])
{
  'tooltipContent': {
      'source': 'source',
      'sourceID': 'id',
      'target': 'target',
      'targetID': 'id',
      'targetEnd': 'end'
  }
}
```

#### `zIndex`
`int`. Positions tracks along the z-axis. The higher the number, the more on top a given track will appear.

{{reference dash_bio.Circos}}

## Example Data

- https://git.io/circos_graph_data.json,
- [UCSC Table Browser](https://genome.ucsc.edu/cgi-bin/hgTables)
