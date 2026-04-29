---
url: /dash-core-components/upload
name: Upload
description:
    "The dcc.Upload component provides a file upload interface, allowing users to upload files to the app."
languages:
    - python
    - julia
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) dcc.Upload

The `dcc.Upload` component allows your app's viewers to upload files,
like Excel spreadsheets or images, into your application.
Your Dash app can access the contents of an upload by listening to
the `contents` property of the `dcc.Upload`
component.

`contents` is a base64 encoded string that contains the files contents,
no matter what type of file: text files, images, .zip files,
Excel spreadsheets, etc.

{{oss {{dash-club}} }}

## Examples

Find a few usage examples below.

### Displaying Uploaded Spreadsheet Contents

Here's an example that parses CSV or Excel files and displays
the results in a <dccLink href="/datatable" children="Dash DataTable"/>.

{{example upload_datafile}}

### Displaying Uploaded Images

This next example responds to image uploads by displaying them
in the app with the `html.Img` component.

{{example upload_image}}

### Styling the Upload Component

The `children` attribute of the `Upload` component accepts any
Dash component. Selecting the child element triggers the
upload action, as does dragging and dropping files.
Here are three different ways you can style the `Upload`
component using standard Dash components.

{{example upload_gallery}}

------------------------

{{reference dcc.Upload}}
