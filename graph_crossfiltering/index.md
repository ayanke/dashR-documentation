---
url: /interactive-graphing
name: Part 3. Interactive Graphing and Crossfiltering
description: "Graphs can be inputs as well as outputs: bind interactivity to the Dash `Graph` component whenever you hover, click, or select points on your chart."
icon: bar-chart.svg
languages:
    - python
    - julia
    - r
    - fsharp
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Interactive Visualizations

> This is the 3rd chapter of the <dccLink href="/" children="Dash Fundamentals"/>.
The <dccLink href="/basic-callbacks" children="previous chapter"/> covered basic callback usage. The <dccLink href="/sharing-data-between-callbacks" children="next chapter"/> describes how to share data between callbacks. Just getting started? Make sure to [install the necessary dependencies](/installation).


The `dashCoreComponents` package includes a Graph component called `dcc.Graph`.

`dcc.Graph` renders interactive data visualizations using the open source [plotly.js](https://github.com/plotly/plotly.js) JavaScript graphing library. Plotly.js supports over 35 chart types and renders charts in both vector-quality SVG and high-performance WebGL.

The `figure` argument in the `dcc.Graph` component is the same `figure` argument that is used by `plotly`. Check out the [plotly.py documentation and gallery](https://plotly.com/python) to learn more.

As we already saw, Dash components are described by a set of attributes.
Any of these attributes can be updated by callback functions, but only
a subset of these attributes are updated through user interaction, such as
typing inside a `dcc.Input` component or clicking an option
in a `dcc.Dropdown` component.

The `dcc.Graph` component has four attributes that can change
through user-interaction: `hoverData`, `clickData`, `selectedData`,
`relayoutData`. These properties update when you hover over points, click on points, or
select regions of points in a graph.

Here's an example that prints these attributes to the screen.

{{example graph_callbacks_simple Show code}}

> For optimal user interaction and chart loading performance, Dash apps
in production should consider the [Job Queue](https://plotly.com/dash/job-queue/),
[HPC](https://plotly.com/dash/big-data-for-python/), [Datashader](https://plotly.com/dash/big-data-for-python/),
and horizontal scaling capabilities of Dash Enterprise.

## Update Graphs on Hover

Let's update our world indicators example from the previous chapter by updating the time series when we hover over points in our scatter plot.

{{example getting_started_crossfilter Show code}}

Try moving the mouse over the points in the scatter plot on the left. Notice how the line graphs on the right update based on the point that you are hovering over.

{{oss {{dash-club}} }}

## Generic Crossfilter Recipe

Here's an example of crossfiltering across a six-column data set. Each scatter plot's selection filters the underlying dataset.

{{example generic_crossfilter Show code}}

![Dash Data Selection Example](/assets/images/interactive-graphing/select.gif)

On every selection, the three graph callbacks are fired with the latest
selected regions of each plot. A {{python pandas dataframe is filtered based on the selected points and the graphs are replotted with the selected points highlighted and the selected region drawn as a dashed rectangle.
}}

> As an aside, if you find yourself filtering and visualizing highly-dimensional datasets, you should consider checking out the [parallel coordinates](https://plotly.com/python/parallel-coordinates-plot/) chart type.

***

## Current Limitations
There are a few limitations in graph interactions right now.
- It is not currently possible to customize the style of the hover interactions or the select box. This issue is being worked on in [https://github.com/plotly/plotly.js/issues/1847](https://github.com/plotly/plotly.js/issues/1847).

There's a lot that you can do with these interactive plotting features. If you need help exploring your use case, open up a thread in the [Dash Community Forum](https://community.plotly.com/c/dash-r-matlab-julia/28).

***

The next chapter of the Dash Fundamentals explains how to share data between callbacks. <dccLink href="sharing-data-between-callbacks" children="Dash Fundamentals Part 4. Sharing Data Between Callbacks"/>
