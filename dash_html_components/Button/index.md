---
url: /dash-html-components/button
name: Button
description: "html.Button is a component for rendering a user-selectable button."
languages:
    - python
---
# ![](/assets/images/language_icons/r-lang_50px.svg) Button Examples and Reference

`html.Button` is a component for rendering a user-selectable button.

## Examples

Find a few usage examples below.



### Button Basic Example

An example of a default button without any extra properties
and `n_clicks` in the callback. `n_clicks` is an integer that represents
that number of times the button has been clicked. Note that the original
value is `None`.

{{example button_basic}}

{{oss {{dash-club}} }}

### Determining which Button Changed with `dash.ctx`

This example uses the `dash.ctx` property
to determine which input changed.

Note: `dash.ctx` is available in Dash 2.4 and later. `dash.callback_context` provides similar functionality in earlier
versions of Dash.

{{example button_ctx}}

***

{{reference html.Button}}
