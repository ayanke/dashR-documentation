---
url: /live-updates
name: Live Updates
description:
    "Update your apps on page load or on a predefined interval (e.g. every 5 seconds)"
icon: loop-arrow.svg
languages:
  - python
  - julia
  - r
  - fsharp
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Live Updating Components

## The `dcc.Interval` Component

Components in Dash usually update through user interaction like
selecting a dropdown, dragging a slider, or hovering over points.

If you're building an application for monitoring, you may want to update
components in your application every few seconds or minutes.

The `dcc.Interval` element allows you to update components
on a predefined interval. The `n_intervals` property is an integer that is
automatically incremented every time `interval` milliseconds pass.
You can listen to this variable inside your app's `callback` to fire
the callback on a predefined interval.

This example pulls data from live satellite feeds and updates the graph
and the text every second.



{{oss {{dash-club}} }}

## Updates on Page Load

By default, Dash apps store the `app.layout` in memory. This ensures that the
`layout` is only computed once, when the app starts.

If you set `app.layout` to a function, then you can serve a dynamic layout
on every page load.

For example, if your `app.layout` looked like this:


then your app would display the time when the app was started.

If you change this to a function, then a new `datetime` will get computed
everytime you refresh the page. Give it a try:



> **Heads up! You need to write** `app.layout = serve_layout` **_not_** `app.layout = serve_layout()`.
> **That is, define** `app.layout` **to the actual function instance.**

You can combine this with <dccLink children="time-expiring caching" href="/performance"/>
and serve a unique `layout` every hour or every day and serve the computed `layout`
from memory in between.
