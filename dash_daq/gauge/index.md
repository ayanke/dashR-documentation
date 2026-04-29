---
url: /dash-daq/gauge
name: Gauge
description:
    "Gauge"
languages:
    - python
    - julia
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Gauge Examples and Reference

------------------------

### Default Gauge

An example of a default Gauge without any extra properties.

{{example gauge}}

------------------------

### Minimum and Maximum

Specify the minimum and maximum values of the gauge, using the `min` and `max` properties. 
If the scale is logarithmic the minimum and maximum will represent an exponent.

{{example gauge_min_max}}

------------------------

### Current Value and Units

Show the current value of the gauge and the units with `showCurrentValue=TRUE` 
and `units=<units>`.

{{example gauge_value_unit}}

------------------------

### Logarithmic Gauge

To set the scale of the gauge to logarithmic use the property `logarithmic=TRUE`.

{{example gauge_log}}

------------------------

### Color

Set the color of the gauge by using the property `color=<hex_color>`.

{{example gauge_color}}

------------------------

### Color Gradient

Apply a color gradient to the gauge with the property: 
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

{{example gauge_color_gradient}}

------------------------

### Size

Adjust the size of the gauge in pixels `size=200`.

{{example gauge_size}}

------------------------

### Scale

Modify where the scale starts, the label interval, and actual interval 
with the `scale` property.

{{example gauge_scale}}

------------------------

{{reference dash_daq.Gauge}}