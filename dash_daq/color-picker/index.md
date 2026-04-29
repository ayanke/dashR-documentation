---
url: /dash-daq/colorpicker
name: ColorPicker
description:
    "ColorPicker"
languages:
    - python
    - julia
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Color Picker Examples and Reference

------------------------

### Default Color Picker

An example of a default Color Picker without any extra properties.

{{example color_picker}}

------------------------

### Size

Set the size (width) of the color picker in pixels using the `size` property.

{{example color_picker_size}}

------------------------

### Label

Define the label and label position using the `label` and `labelPosition` properties.

{{example color_picker_label}}

------------------------

### Disabled

To disable the Color Picker set `disabled` to `TRUE`.

{{example color_picker_disabled}}

------------------------

### Hex Colors

Use hex values with the Color Picker by setting `value=list(hex='#<hex_color>')`

{{example color_picker_color}}

------------------------

### RGB Colors
Use RGB color values with the Color Picker by setting: 
`value = list(rgb = list(r = <r_value>, g = <g_value>, b = <b_value>, a = <a_value>))` 

{{example color_picker_rgb}}

------------------------

{{reference dash_daq.ColorPicker}}
