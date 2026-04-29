---
url: /dash-daq/thermometer
name: Thermometer
description:
    "Thermometer"
languages:
    - python
    - julia
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Thermometer Examples and Reference

------------------------

### Default Thermometer

An example of a default Thermometer without any extra properties.

{{example thermometer}}

------------------------

### Current value with units

Display the value of the thermometer along with
optional units with `showCurrentValue` and `units`.

{{example thermometer_value}}

------------------------

### Height and width

Control the size of the thermometer by setting `height` and `width`.

{{example thermometer_height_width}}

------------------------

### Label

Display a label alongside the thermometer in
the specified position by setting `label` and `labelPosition`.

{{example thermometer_label}}

------------------------

### Custom scales

Control the intervals at which labels are displayed,
as well as the labels themselves with the `scale` property.

{{example thermometer_scale}}

------------------------

{{reference dash_daq.Thermometer}}