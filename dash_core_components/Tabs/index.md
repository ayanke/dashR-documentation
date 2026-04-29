---
url: /dash-core-components/tabs
name: Tabs
description:
    "dcc.Tabs is a component that creates a tabbed interface, enabling users to switch between different views or sections."
languages:
    - python
    - julia
    - r
    - matlab
---

# ![](/assets/images/language_icons/r-lang_50px.svg) dcc.Tabs

 The `dcc.Tabs` and `dcc.Tab` components can be used to create tabbed sections in
 your app. The `dcc.Tab` component controls the style and value of the individual
 tab and the `dcc.Tabs` component hold a collection of `dcc.Tab` components.

## Examples

Find a few usage examples below.



### Method 1. Content as Callback

Attach a callback to the Tabs `value` prop and update a container's `children`
property in your callback.

{{example tabs_callback }}



### Method 2. Content as Tab Children

Instead of displaying the content through a callback, you can embed the content
directly as the `children` property in the `Tab` component:

{{example tabs_simple }}

Note that this method has a drawback: it requires that you compute the children
property for each individual tab _upfront_ and send all of the tab's content over
the network _at once_. The callback method allows you to compute the tab's content
_on the fly_ (that is, when the tab is clicked).

### Styling the Tabs Component

#### With CSS Classes

Styling the Tabs (and Tab) component can either be done using CSS classes by
providing your own to the `className` property:

{{example tabs_styled_with_classes }}

Notice how the container of the Tabs can be styled as well by supplying a class
to the `parent_className` prop, which we use here to draw a border below it,
positioning the actual Tabs (with padding) more in the center. We also added
`display: flex` and `justify-content: center` to the regular `Tab` components,
so that labels with multiple lines will not break the flow of the text. The
corresponding CSS file (`assets/tabs.css`) looks like this. Save the file in
an `assets` folder (it can be named anything you want). Dash will automatically
include this CSS when the app is loaded. Learn more in
<dccLink href="/external-resources" children="Adding CSS & JS and Overriding the Page-Load Template"/>.

```css
.custom-tabs-container {
    width: 85%;
}
.custom-tabs {
    border-top-left-radius: 3px;
    background-color: #f9f9f9;
    padding: 0px 24px;
    border-bottom: 1px solid #d6d6d6;
}

.custom-tab {
    color:#586069;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
    border-top: 3px solid transparent !important;
    border-left: 0px !important;
    border-right: 0px !important;
    border-bottom: 0px !important;
    background-color: #fafbfc;
    padding: 12px !important;
    font-family: "system-ui";
    display: flex !important;
    align-items: center;
    justify-content: center;
}
.custom-tab--selected {
    color: black;
    box-shadow: 1px 1px 0px white;
    border-left: 1px solid lightgrey !important;
    border-right: 1px solid lightgrey !important;
    border-top: 3px solid #e36209 !important;
}
```

#### With Inline Styles

An alternative to providing CSS classes is to provide style dictionaries directly:

{{example tabs_styled_with_inline }}

Lastly, you can set the colors of the Tabs components in the `color` prop, by
specifying the "border", "primary", and "background" colors in a dict. Make sure
you set them all, if you're using them!

{{example tabs_styled_with_props }}

------------------------

{{reference dcc.Tabs}}