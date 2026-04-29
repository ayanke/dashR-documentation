---
url: /dash-html-components
name: Overview
breadcrumb: Dash HTML Components
description:
    "Dash provides HTML tags as user-friendly Python classes. This chapter explains how they work and the key differences between Dash HTML components and standard HTML"
icon: gallery-1.svg
languages:
    - python
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Dash HTML Components

Dash is a web app framework that provides pure Python abstraction around HTML, CSS, and JavaScript.

Instead of writing HTML or using an HTML templating engine, you compose your layout using Python with the Dash HTML Components module (`dash.html`).

Import `dash.html` with:

```py
from dash import html
```

The Dash HTML Components module is part of Dash and you'll find the source for it in the [Dash GitHub repo](https://github.com/plotly/dash).


>**Tip**: In production Dash apps, we recommend using {{de Dash Enterprise <dccLink href="/dash-design-kit" children="Design Kit"/>||oss Dash Enterprise [Design Kit](https://plotly.com/dash/design-kit/)}} to style Dash HTML Components.

Here is an example of a simple HTML structure:

```python
from dash import html

html.Div([
    html.H1('Hello Dash'),
    html.Div([
        html.P('Dash converts Python classes into HTML'),
        html.P("This conversion happens behind the scenes by Dash's JavaScript front-end")
    ])
])
```

which gets converted (behind the scenes) into the following HTML in your web app:


```html
<div>
    <h1>Hello Dash</h1>
    <div>
        <p>Dash converts Python classes into HTML</p>
        <p>This conversion happens behind the scenes by Dash's JavaScript front-end</p>
    </div>
</div>
```

If you're not comfortable with HTML, don't worry!
You can get 95% of the way there with just a few elements
and attributes.

If you want to use [Markdown](http://commonmark.org/help) in your app, you can use the <dccLink href="/dash-core-components" children="Dash Core Components"/> Markdown component:

{{example markdown_example}}

{{oss {{dash-club}} }}

## HTML Component Properties

If you're using HTML components, then you also have access to
properties like `style`, `class`, and `id`.
All of these attributes are available in the Python classes.

The HTML elements and Dash classes are mostly the same but there are
a few key differences:
- The `style` property is a dictionary
- Properties in the `style` dictionary are camelCased
- The `class` key is renamed as `className`
- Style properties in pixel units can be supplied as just numbers without the `px` unit

Let's take a look at an example.

```py
from dash import html

html.Div([
    html.Div('Example Div', style={'color': 'blue', 'fontSize': 14}),
    html.P('Example P', className='my-class', id='my-p-element')
], style={'marginBottom': 50, 'marginTop': 25})
```

That Dash code will render this HTML markup:

```html
<div style="margin-bottom: 50px; margin-top: 25px;">

    <div style="color: blue; font-size: 14px">
        Example Div
    </div>

    <p class="my-class", id="my-p-element">
        Example P
    </p>

</div>
```

### n_clicks and disable_n_clicks

All Dash HTML components have an `n_clicks` property, which is an integer that represents the number of times the element has been clicked. You can use `n_clicks` to trigger a callback and use the value of `n_clicks` in your callback logic.

In this example, we capture the `n_clicks` value from the `html.Div` with ID `click-div` and output it to the `html.P` with ID `click-output`. `n_clicks` uses an event listener to capture user click events on the element and increment the `n_clicks` value.

{{example n_clicks_example}}

Many Dash HTML components are rarely intended to be clicked (in the example above, it's unusual that the `html.Div` is clickable&mdash;a better design choice would be to use a button). Even when you use elements like `html.Div` that you don't intend for the user to click, the `n_clicks` event listener causes screen-reading software to interpret the elements as clickable, which can be confusing.

In Dash 2.8 and later, Dash HTML components are improved for better control over the `n_clicks` event listener:
- If you don't give your HTML component an ID, the `n_clicks` event listener is not added.
- If your HTML component does have an ID but you don't need to capture clicks, you can disable the `n_clicks` event listener by setting `disable_n_clicks=True`.

Here is the same example as above, but we've decided that we don't need to capture clicks, so we've disabled `n_clicks` on the `html.Div` (the callback is for illustrative purposes):

{{example n_clicks_example_disabled_id}}

With `disable_n_clicks=True`, we convey to screen reader assisted users that the `html.Div` is not clickable.
## Full Elements Reference

