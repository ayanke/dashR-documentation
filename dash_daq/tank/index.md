---
url: /dash-daq/tank
name: Tank
description:
    "Tank"
languages:
    - python
    - julia
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Tank Examples and Reference

------------------------

### Default Tank

An example of a default tank without any extra properties.

{{example tank}}

------------------------

### Current value with units

Display the current value, along with optional units with the `units`
and `showCurrentValue` properties.

{{example tank_value}}

------------------------

### Height and width

Control the size of the tank by setting `height` and `width`.

{{example tank_height_width}}

------------------------

### Label

Display a label alongside your tank in the specified position
with `label` and `labelPosition`.

{{example tank_label}}

------------------------

### Custom scales

Control the intervals at which labels are displayed,
as well as the labels themselves with the `scale` property.

{{example tank_custom_scales}}

------------------------

### Logarithmic

Use a logarithmic scale for the tank with the specified
base by setting `logarithmic=TRUE`.

{{example tank_log}}

------------------------

{{reference dash_daq.Tank}}