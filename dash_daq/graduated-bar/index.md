---
url: /dash-daq/graduatedbar
name: GraduatedBar
description:
    "GraduatedBar"
languages:
    - python
    - julia
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Graduated bar Examples and Reference

------------------------

### Default Graduated bar

An example of a default Graduated bar without any extra properties.

{{example gradbar}}

------------------------

### Orientation

Change the orientation of the bar to vertical `vertical=TRUE`.

{{example gradbar_orientation}}

------------------------

### Size

Manually adjust the size of the bar in pixels with `size`.

{{example gradbar_size}}

------------------------

### Max

Manually set a maximum value with `max`.

{{example gradbar_max}}

------------------------

### Step

Manually set the step size of each bar with `step`.

{{example gradbar_step}}

------------------------

### Show Current Value

Display the current value of the graduated bar with `showCurrentValue=TRUE `.

{{example gradbar_value}}

------------------------

### Color Range

Set a color range with:
```r
color = list(
    'ranges' = list(
        '<color>' = list(<value>, <value>),
        '<color>' = list(<value>, <value>),
        '<color>' = list(<value>, <value>)
    )
)
```

{{example gradbar_color_range}}

------------------------

### Color Gradient

Set a color gradient with:
```r
color = list(
    'gradient' = TRUE,
    'ranges' = list(
        '<color>' = list(<value>, <value>),
        '<color>' = list(<value>, <value>),
        '<color>' = list(<value>, <value>)
    )
)
```

{{example gradbar_color_gradient}}

------------------------

{{reference dash_daq.GraduatedBar}}