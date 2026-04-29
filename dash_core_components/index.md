---
url: /dash-core-components
name: Overview
breadcrumb: Dash Core Components
description:
   "Dash Core Components are essential UI elements for building interactive Dash apps. They include graphs, dropdowns, sliders, and more."
icon: maximize.svg
languages:
    - python
    - julia
    - matlab
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Dash Core Components

Dash ships with supercharged components for interactive user interfaces.

The `dcc` module is part of Dash and you'll find the source for it in the [Dash GitHub repo](https://github.com/plotly/dash).

>**Tip**: In production Dash apps, we recommend using {{de Dash Enterprise <dccLink href="/dash-design-kit" children="Design Kit"/>||oss Dash Enterprise [Design Kit](https://plotly.com/dash/design-kit/)}} to manage the styling and layout of Dash Core Components.



### <dccLink href="/dash-core-components/dropdown" children = "Dropdown"/>
{{example dropdown}}
{{example dropdown_multi}}
**<dccLink href="/dash-core-components/dropdown" children = "More Dropdown Examples and Reference"/>**

### <dccLink href="/dash-core-components/slider" children = "Slider"/>
{{example slider}}
{{example slider_marks}}
**<dccLink href="/dash-core-components/slider" children = "More Slider Examples and Reference"/>**

### <dccLink href="/dash-core-components/rangeslider" children = "RangeSlider"/>
{{example rangeslider}}
{{example rangeslider_marks}}
**<dccLink href="/dash-core-components/rangeslider" children = "More RangeSlider Examples and Reference"/>**

### <dccLink href="/dash-core-components/input" children = "Input"/>
{{example input}}
**<dccLink href="/dash-core-components/input" children = "More Input Examples and Reference"/>**

### <dccLink href="/dash-core-components/textarea" children = "Textarea"/>
{{example textarea}}
**<dccLink href="/dash-core-components/textarea" children = "Textarea Reference"/>**

### <dccLink href="/dash-core-components/checklist" children = "Checkboxes"/>
{{example checkboxes}}
{{example checkboxes_inline}}
**<dccLink href="/dash-core-components/checklist" children = "Checklist Properties"/>**

### <dccLink href="/dash-core-components/radioitems" children = "Radio Items"/>
{{example radioitems}}
{{example radioitems_inline}}
**<dccLink href="/dash-core-components/radioitems" children = "Radio Items Reference"/>**

### <dccLink href="/dash-html-components/button" children = "Button"/>
There actually is no `Button` component in `DashCoreComponents`. The regular  component does the job quite well, but we've included it here because this is the one plain `html` component that's commonly used as a callback input:
{{example button}}
**<dccLink href="/dash-html-components/button" children = "html.Button Reference"/>**
For more on , see **<dccLink href="/basic-callbacks" children = "basic callbacks"/>**.

{{oss {{dash-club}} }}

### <dccLink href="/dash-core-components/datepickersingle" children = "DatePickerSingle"/>
{{example datepicker_single}}
**<dccLink href="/dash-core-components/datepickersingle" children = "More DatePickerSingle Examples and Reference"/>**

### <dccLink href="/dash-core-components/datepickerrange" children = "DatePickerRange"/>
{{example datepicker_range}}
**<dccLink href="/dash-core-components/datepickerrange" children = "More DatePickerRange Examples and Reference"/>**

### <dccLink href="/dash-core-components/markdown" children = "Markdown"/>
{{example markdown}}
**<dccLink href="/dash-core-components/markdown" children = "More Markdown Examples and Reference"/>**

### <dccLink href="/dash-core-components/upload" children = "Upload Component"/>
The  component allows users to upload files into your app through drag-and-drop or the system's native file explorer.
![Upload](/assets/images/gallery/dash-upload.gif)
**<dccLink href="/dash-core-components/upload" children = "More Upload Examples and Reference"/>**

### <dccLink href="/dash-core-components/download" children = "Download Component"/>
The  component allows users to download files from your app through their browser.
{{example download_text}}
**<dccLink href="/dash-core-components/download" children = "More Download Examples and Reference"/>**

### <dccLink href="/dash-core-components/tabs" children = "Tabs"/>
The Tabs and Tab components can be used to create tabbed sections in your app.
{{example tabs_callback}}
**<dccLink href="/dash-core-components/tabs" children = "More Tabs Examples and Reference"/>**

### <dccLink href="/dash-core-components/graph" children = "Graphs"/>
The  component shares the same syntax as the open-source `plotly.py` library. View the **[plotly.py docs](https://plotly.com/python)** to learn more.
{{example graph}}
**<dccLink href="/dash-core-components/graph" children = "More Graphs Examples and Reference"/>**

View the **[plotly.py docs](https://plotly.com/python)**.

### <dccLink href="/dash-core-components/confirmdialogprovider" children = "ConfirmDialogProvider"/>

The  component sends a  when a user clicks the `children` of the component. In the following example, an  is provided as `children` to  and when the button is clicked, the dialog is displayed.

{{example confirm_dialog_provider}}

**<dccLink href="/dash-core-components/confirmdialogprovider" children = "More ConfirmDialogProvider Examples and Reference"/>**


### <dccLink href="/dash-core-components/store" children = "Store"/>
The store component can be used to keep data in the visitor's browser.
The data is scoped to the user accessing the page.

**Three types of storage (`storage_type` prop):**
- `memory`: default, keep the data as long the page is not refreshed.
- `local`: keep the data until it is manually cleared.
- `session`: keep the data until the browser/tab closes.

> _For `local`/`session`, the data is serialized as json when stored._

In this example, one callback saves the value of the selected radio button to a memory store. When the value in the store changes, the second callback outputs the new value and the modified timestamp to a `html.Div` component.

{{example store}}
_The store must be used with callbacks_

**<dccLink href="/dash-core-components/store" children = "More Store Examples and Reference"/>**

### <dccLink href="/dash-core-components/loading" children = "Loading Component"/>

The Loading component can be used to wrap components that you want to display a spinner for, if they take too long to load.

This example shows a spinner each time a user selects a radio button as the callback takes 2 seconds to update the `html.Div` component (`id=loading-demo`) inside the `dcc.Loading` component.

{{example loading}}
**<dccLink href="/dash-core-components/loading" children = "More Loading Component Examples and Reference"/>**

### <dccLink href="/dash-core-components/location" children = "Location"/>
The location component represents the location bar in your web browser. Through its `href`, `pathname`, `search` and `hash` properties you can access different portions of your app's url.
For example, given the url `http://127.0.0.1:8050/page-2?a=test#quiz`:
- `href` = `"http://127.0.0.1:8050/page-2?a=test#quiz"`
- `pathname` = `"/page-2"`
- `search` = `"?a=test"`
- `hash` = `"#quiz"`


**<dccLink href="/dash-core-components/location" children = "More Location Examples and Reference"/>**
