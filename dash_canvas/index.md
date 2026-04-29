---
url: /canvas
name: Overview & Reference
breadcrumb: Dash Canvas
description: "Image rendering, drawing, annotations for image processing applications (legacy tool)"
icon: web-page.svg
languages:
    - python
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Introduction to dash-canvas

>**Note**: dash-canvas is a legacy package. The recommended way to annotate images is to use the [drawing tools of plotly figures](/annotations).

`dash-canvas` is a module for image annotation and image processing using Dash. It provides both the `DashCanvas` object for drawing and annotations on images, and a set of utility functions to process images using the annotations.

`dash-canvas` can be used in various fields in which user interaction with images is required, such as quality control in industry, identification and segmentation of cells or organs in life and medical sciences, quantification of phases in materials and geosciences, construction of training sets for machine learning, etc.

Install `dash-canvas` with

```
remotes::install_github('plotly/dash-canvas')
```


The source is on GitHub at [plotly/dash-canvas](https://github.com/plotly/dash-canvas).

### DashCanvas: a canvas object for annotations

Let's get started with a simple canvas object.

{{example canvas_101}}

You can draw inside the object with the freehand tool, and use the tool buttons to draw lines, zoom in and out, pan, select objects and move them inside the canvas.

`DashCanvas` comes with a set of properties which can be adjusted to control the geometry of the canvas, the default tool and its properties. You can pass a background image either as a filename (`filename` property) or as a data string (`image_content` property); more examples below.

{{example canvas_image}}

The height of the canvas is adjusted automatically by keeping the aspect ratio of the background image.

### Basic callbacks to modify DashCanvas properties

Like any Dash component, the properties of a `DashCanvas` can be modified by other components, via callbacks. Please be sure to have read about <dccLink href="/basic-callbacks" children="Basic Callbacks"/> in the Dash Fundamentals.

{{example canvas_color}}

In the example above, a slider `dcc.Slider` and a color picker `daq.ColorPicker` are used to adjust the width and color of the drawing brush. We just created an image coloring tool in a few lines of code! You can learn more about available components in the
<dccLink children="component libraries" href="/"/>
section of the Dash documentation. Also note that the set of available buttons has been restricted through the`hide_buttons` properties, in order to keep the app design simple.

### Retrieving the geometry of annotations and using utility functions

The geometry of annotations can be retrieved by pressing the bottom-right button of the `DashCanvas`. This button is called "Save" by default; the name can be customized through the `goButtonTitle` property. This button updates the `json_data` property of `DashCanvas`, which is a JSON string with information about the background image and the geometry of annotations.

{{example canvas_annotations}}

More Examples utilizing geometry of annotations to create images is currently work in progress and will be added to the documentation soon...


### Updating the background image

The background image can be updated thanks to the `image_content` property (a `character` vector), for example using the `contents` property of `dcc.Upload` (an "open file" dialog). Updating `image_content` triggers the update of the `json_data` property containing the annotations.

### More examples

A gallery of examples using `DashCanvas` is available at [plotly/canvas-portal](https://github.com/plotly/canvas-portal).