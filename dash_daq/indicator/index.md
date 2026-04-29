---
url: /dash-daq/indicator
name: Indicator
description:
    "Indicator"
languages:
    - python
    - julia
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Indicator Examples and Reference

------------------------

## Default Indicator

An example of a default Indicator without any extra properties.

{{example indicator}}

------------------------

### Label

Define the label and label orientation with `label` and `labelPosition`.

{{example indicator_label}}

------------------------

### Boolean Indicator Off

A boolean indicator set to off `value=FALSE `.

{{example indicator_off}}

------------------------

### Square

Create a square boolean indicator by setting the `width` and `height` to the same value.

{{example indicator_square}}

------------------------

### Color

Define the color of the boolean indicator with `color='#<color>'`

{{example indicator_color}}

------------------------

{{reference dash_daq.Indicator}}