---
url: /dash-daq/knob
name: Knob
description:
    "Knob"
languages:
    - python
    - julia
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Knob Examples and Reference

------------------------

### Default Knob

An example of a default Knob without any extra properties.

{{example knob}}

------------------------

### Size

Set the size(diameter) of the knob in pixels with `size`.

{{example knob_size}}

------------------------

### Max

Set the maximum value of the knob using `max`.

{{example knob_max}}

------------------------

### Color Ranges

Control color ranges with:
```r
color = list(
    'ranges' = list(
        '<color>' = list(<value>, <value>),
        '<color>' = list(<value>, <value>),
        '<color>' = list(<value>, <value>)
        )
    )
```

{{example knob_color_range}}

------------------------

### Color Gradient

Set up a color gradient with:
```r
color = list(
    'gradient' =  TRUE,
    'ranges' = list(
        '<color>' = list(<value>, <value>),
        '<color>' = list(<value>, <value>),
        '<color>' = list(<value>, <value>)
        )
    )
```

{{example knob_color_gradient}}

------------------------

### Scale

Adjust the scale interval, label interval, and start of the scale with `scale`.

{{example knob_scale}}

------------------------

{{reference dash_daq.Knob}}