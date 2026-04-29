---
url: /layout
name: Part 1. Layout
description:
    "The Dash `layout` describes what your app will look like and is composed
    of a set of declarative Dash components."
icon: layout.svg
languages:
  - python
  - julia
  - r
  - fsharp
  - matlab
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Dash Layout

<blockquote>
This is the 1st chapter of the <dccLink children="Dash Fundamentals" href="/"/>.
The <dccLink href="/basic-callbacks" children="next chapter"/> covers Dash callbacks.
</blockquote>

This tutorial will walk you through a fundamental aspect of Dash apps, the
app `layout`, through six self-contained apps.

For production Dash apps, we recommend styling the app `layout` with
{{de Dash Enterprise <dccLink href="/dash-design-kit" children="Design Kit"/>.||oss Dash Enterprise [Design Kit](https://plotly.com/dash/design-kit/).}}

***

Dash apps are composed of two parts. The first part is the "`layout`", which describes what the app looks like.
The second part describes the interactivity of the app and will be
covered in the <dccLink href="/basic-callbacks" children="next chapter"/>.

Note: Throughout this documentation,

 R
code examples are meant to be saved as files and executed
either using `source("app.R")` in your R terminal or using `Rscript app.R` in a shell. Throughout this documentation we'll use the former method.


{{oss
> If you're using Dash Enterprise's [Data Science Workspaces](https://plotly.com/dash/workspaces/),
> copy & paste the below code into your Workspace ([see video](https://plotly.com/dash/workspaces/#screencast)).

> _[Find out if your company is using Dash Enterprise](https://plotly.com/company-lookup/)_
}}

To get started, create a file named
`app.R`
, copy the code below into it, and then run it
 with `source("app.R")`.

{{example getting_started_layout_1}}

```
> source("app.R")
Fire started at 127.0.0.1:8050
start: 127.0.0.1:8050
```


Visit [http://127.0.0.1:8050/](http://127.0.0.1:8050/)
 in your web browser. You should see an app that looks like the one above.

Note:

1. The `layout` is composed of a tree of "components" such as
   `div`
    and `dccGraph`.
2. The
   `dash` package contains an `html` list which
    has a component for every HTML tag. For convenience, some common HTML tags have shortcuts as functions; e.g. `h1()` and `div()` are aliases for `html$h1()` and `html$div()`.
   The `h1('Hello Dash')`
    component generates a `<h1>Hello Dash</h1>` HTML element in your app.
3. Not all components are pure HTML.
   `DashCoreComponents`
   contains higher-level components that are interactive and are generated with
    JavaScript, HTML, and CSS through the React.js library.

4. Each component is described entirely through the parameters to its function.

. It  can contain a string, a number, a single component, or a list of components.
||r 5. For pure HTML components, any named argument becomes an attribute on the HTML tag, while any unnamed argument becomes a child. For example, `div(id = "name", "Joe")` results in `<div id="name">Joe</div>`.}}
6. The fonts in your app will look a little bit different than what is displayed here.
   This app is using a custom CSS stylesheet and {{de Dash Enterprise <dccLink href="/dash-design-kit" children="Design Kit"/>||oss Dash Enterprise [Design Kit](https://plotly.com/dash/design-kit/)}}
    to modify the default styles of the elements. You can learn more about custom CSS in the
    <dccLink href="/external-resources" children="CSS tutorial"/>.


### A Quick Note about Syntax

You'll notice that most examples on this website use the [pipe operator](https://magrittr.tidyverse.org/reference/pipe.html) (`%>%`) to manipulate the Dash app object. The above code can be rewritten to fully embrace the pipe operator as

```
dash_app() %>%
  set_layout(...) %>%
  run_app()
```

or it can be rewritten without the pipe operator as

```
app <- dash_app()
set_layout(app, ...)
run_app(app)
```

Functionally there is no difference between these three, so you can choose whichever style best suits you.


### Making Your First Change



You can change the title "Hello Dash" in your app or change the
`x` or `y` data. Save the file and restart the app to see your changes.


{{oss {{dash-club}} }}
### More about HTML Components




Any valid HTML tag can be added to a Dash app using the HTML components in the `html` list. For example, a `div` component that results in a `<div>` tag in the app can be created with `html$div()`.

Some common HTML tags, such as `div` and `button`, are also available as functions for your convenience, so you can simply use `div()` or `button()`. Run `?dash::html` to see the full list of HTML tags that support this short form.

An HTML tag can contain arbitrary attributes and content: any named arguments to the function become attributes in the HTML tag, and any unnamed arguments become children. The children can either be simple text or they can be other Dash components themselves.


Let's customize the text in our app by modifying the inline styles of the components.
 Create a file named `app.R` with the following code:

{{example getting_started_layout_2}}

In this example, we modified the inline styles of the
 title `h1`
and subtitle `div`components with the `{{fsharp Attr.  style` property}}.

```r
h1(
  'Hello Dash',
  style = list(
    textAlign = 'center',
    color = '#7FDBFF'
  )
)
```

The above code is rendered in the Dash app as
`<h1 style="text-align: center; color: #7FDBFF">Hello Dash</h1>`.

There are a few important differences between the Dash HTML components
and the HTML attributes:

1. The `style` property in HTML is a semicolon-separated string. In Dash,
   you can just supply a named list.
2. The names in the `style` list are [camelCased](https://en.wikipedia.org/wiki/Camel_case).
   So, instead of `text-align`, it's `textAlign`.
3. The HTML `class` attribute is `className` in Dash.
.
||r 4. The HTML `for` attribute is `htmlFor` in Dash.
}}
5. A special property `n_clicks` is automatically added to every HTML tag. This property represents the number of times that an HTML element has been clicked on, which is mostly useful for `<button>`s. If not explicitly initialized to a certain integer, its default value is `NULL` initially.

Besides that, all of the available HTML attributes and tags are available
to you within your R context.

A few more useful tips for Dash HTML components:

1. Named arguments with a value of `NULL` will not get rendered. This can be useful for conditionally including an attribute.
2. Named arguments with a value of `NA` will be rendered as [boolean attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes#boolean_attributes).


***

### Reusable Components

By writing our markup in R, we can create complex reusable components like tables without switching contexts or languages.

Here's a quick example that generates a `Table` from a
 CSV file. Create a file named `app.R` with the following code:

{{example getting_started_table}}

> In fact, creating simple tables like this is such a common task that Dash provides a special function for it: `simple_table()`. You can also use `dash::dashDataTable()` for more complex tables.

### More about Visualization

The `DashCoreComponents`
 package includes a component called
 `dccGraph`.

`dccGraph`
 renders interactive data visualizations using the open source
[plotly.js](https://github.com/plotly/plotly.js) JavaScript graphing
library. Plotly.js supports over 35 chart types and renders charts in
both vector-quality SVG and high-performance WebGL.

The `figure` argument in the `dccGraph`
 component is the same `figure` argument that is used by `plotly.py`, Plotly's
open source  graphing library.
Check out the [plotly.py documentation and gallery](https://plotly.com/python)
to learn more.

Here's an example that creates a scatter plot from a
 CSV file. Create a file named `app.R` with the following code:

{{example getting_started_viz}}

*These graphs are interactive and responsive.
 **Hover** over points to see their values,
 **click** on legend items to toggle traces,
 **click and drag** to zoom,
 **hold down shift, and click and drag** to pan.*


### Markdown

While Dash exposes HTML through `DashHtmlComponents`, it can be tedious to write your copy in HTML.  For writing blocks of text, you can use the
`dccMarkdown` component in
`DashCoreComponents`. Create a file named `app.R` with the following code:

{{example getting_started_markdown}}

### Core Components

`DashCoreComponents`
 includes a set of higher-level components like dropdowns, graphs, markdown blocks, and more.

Like all Dash components, they are described entirely declaratively.
Every option that is configurable is available as a keyword argument
of the component.

We'll see many of these components throughout the tutorial.
You can view all of the available components in the
<dccLink href="/dash-core-components" children="Dash Core Components overview"/>.

Here are a few of the available components.
Create a file named `app.R` with the following code:

{{example getting_started_core_components}}

### Help

Dash components are declarative: every configurable aspect of these
components is set during instantiation as a keyword argument.

Call `?` in your R terminal  on any of the components to
learn more about a component and its available arguments.
```
> ?dccDropdown
```


### Summary

The `layout` of a Dash app describes what the app looks like.
The `layout` is a hierarchical tree of components, or a list of components (in Dash 2.17 and later).


 Dash package
 provides functions for all of the HTML
tags and the keyword arguments describe the HTML attributes like `style`, `class`, and `id`.
The `DashCoreComponents`
 package
 generates higher-level components like controls and graphs.
}}

For reference, see:

* <dccLink href="/dash-core-components" children="Dash Core Components overview"/>
* <dccLink href="/dash-html-components" children="Dash HTML Components overview"/>

The next part of the Dash Fundamentals covers how to make these apps interactive.
<dccLink href="/basic-callbacks" children="Dash Fundamentals Part 2: Basic Callbacks"/>
