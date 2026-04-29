
### Retrieving the geometry of annotations and using utility functions

You can either write custom functions to parse the JSON string, or use the utility functions included in the `dash_canvas` package. In particular, ``parse_json_string()`` returns a binary mask with non-zero pixels displaying the annotations:

{{example canvas_copy_annotations}}

The above example used the ``array_to_data_url`` utility function to transform a ``2D - matrix`` into an image data string.

Finally, ``dash-canvas`` provides utility functions to process images given the binary mask derived from annotations:"),
These functions rely on [magick - an R wrapper for ``imagemagick``]() to process matrices as images. Here we used the [watershed algorithm] from ``magick``.'),