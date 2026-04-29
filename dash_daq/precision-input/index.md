---
url: /dash-daq/precisioninput
name: PrecisionInput
description:
    "PrecisionInput"
languages:
    - python
    - julia
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Precision Input Examples and Reference

------------------------

### Default Precision Input

An example of a default precision input without any extra properties.

{{example prec_input}}

------------------------

### Label

Set the label and label position with `label` and `labelPosition`.

{{example prec_input_label}}

------------------------

### Precision

The `precision` property is mandatory for this component. The `precision` property
 indicates the accuracy of the specified number.

{{example prec_input_precision}}

------------------------

### Max and Min

Set the maximum and minimum value of the numeric input with `max` and `min`.

{{example prec_input_min_max}}

------------------------

### Size

Set the length (in pixels) of the numeric input `size`.

{{example prec_input_size}}

------------------------

### Disabled

Disable the precision input by setting `disabled=TRUE`.

{{example prec_input_disabled}}

------------------------

{{reference dash_daq.PrecisionInput}}