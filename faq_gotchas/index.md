---
url: /faqs
name: FAQs
description: "If you have read through the tutorial and still have questions or are encountering unexpected behaviour, this page may be useful."
icon: question.svg
languages:
  - python
  - julia
  - r
  - fsharp
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Frequently Asked Questions

**Q:** _How can I customize the appearance of my Dash app?_

**A:** Dash apps are rendered in the browser as modern standards-compliant
web apps. This means that you can use CSS to style your Dash app as you
would standard HTML.

All `dashHtmlComponents` support inline CSS styling through a `style`
attribute. An external CSS stylesheet can also be used to style
`dashHtmlComponents` and `dashCoreComponents` by targeting the ID or
class names of your components. Both `dashHtmlComponents` and
`dashCoreComponents` accept the attribute `className`, which corresponds
to the HTML element attribute `class`.

The [Dash HTML Components](/dash-html-components)
section in the Dash User
Guide explains how to supply `dashHtmlComponents` with both inline
styles and CSS class names that you can target with CSS style sheets. The [Adding CSS & JS and Overriding the Page-Load Template](/external-resources) section in the Dash Guide explains how you
can link your own style sheets to Dash apps.

---

**Q:** _How can I add JavaScript to my Dash app?_

**A:** You can add your own scripts to your Dash app, just like you would
add a JavaScript file to an HTML document. See the [Adding CSS & JS and
Overriding the Page-Load Template](/external-resources) section in the
Dash Guide.

---

**Q:** _Can I make a Dash app with multiple pages?_

**A:** Yes! Dash has support for multi-page apps. See the [Multi-Page Apps
and URL Support](/urls) section in the Dash User Guide.

---

**Q:** _How I can I organize my Dash app into multiple files?_

**A:** A strategy for doing this can be found in the [Multi-Page Apps and URL Support](/urls) section in the Dash User Guide.

---

**Q:** *How do I determine which `input` has changed?*

**A:** In addition to event properties like `n_clicks` that change whenever an event happens (in this case a click), there is a global variable `app$callback_context()`, available only inside a callback. It has properties:

- `triggered`: list of changed properties. This will be empty on initial load, unless an `input` prop got its value from another initial callback. After a user action it is a length-1 list, unless two properties of a single component update simultaneously, such as a value and a timestamp or event counter.
- `inputs` and `states`: allow you to access the callback params by id and prop instead of through the function args. These have the form of dictionaries `app$callback_context()$triggered$value`

Here's an example of how this can be done:

```
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(jsonlite)

app <- Dash$new()

app$layout(
  htmlDiv(
    list(
      htmlButton(children = 'Button 1', id='btn-1', n_clicks=0),
      htmlButton(children = 'Button 2', id='btn-2', n_clicks=0),
      htmlButton(children = 'Button 3', id='btn-3', n_clicks=0),
      htmlDiv(id='container')

    )
  )
)

app$callback(output('container', 'children'),
             list(input('btn-1', 'n_clicks'),
                  input('btn-2', 'n_clicks'),
                  input('btn-3', 'n_clicks')),
    function(input1, input2, input3) {

      inputs <- c(input1, input2, input3)

      ctx <- app$callback_context()

      most_recent_click <- if(ctx$triggered$value) {

        unlist(strsplit(ctx$triggered$prop_id, "[.]"))[1]

      } else "No clicks yet"

      toJson <- jsonlite::toJSON(ctx, pretty = TRUE)

      htmlDiv(
        list(
          htmlTable(
            list(
              htmlTr(
                list(
                  htmlTh('Button 1'),
                  htmlTh('Button 2'),
                  htmlTh('Button 3'),
                  htmlTh('Most Recent Click')
                )
              ),
              htmlTr(
                list(
                  htmlTd(input1),
                  htmlTd(input2),
                  htmlTd(input3),
                  htmlTd(most_recent_click)
                )
              )
            )
          ),
          htmlPre(toJson)
        )
      )
    })
#app$run_server()
```

> Note: Prior to the addition of `callback_context`, you needed to compare timestamp properties like `n_clicks_timestamp` to find the most recent click. While existing uses of `*_timestamp` continue to work for now, this approach is deprecated, and may be removed in a future update. The one exception is `modified_timestamp` from `dccStore`, which is safe to use, it is NOT deprecated.

---



**Q:** _Can I use jQuery with Dash?_

**A:** For the most part, you can't. Dash uses React to render your app on
the client browser. React is fundamentally different to jQuery in that it
makes use of a virtual DOM (Document Object Model) to manage page
rendering. Since jQuery doesn't speak React's virtual DOM, you can't use
any of jQuery's DOM manipulation facilities to change the page layout,
which is frequently why one might want to use jQuery. You can however use
parts of jQuery's functionality that do not touch the DOM, such as
registering event listeners to cause a page redirect on a keystroke.

In general, if you are looking to add custom clientside behavior in your
application, we recommend encapsulating that behavior in a [custom Dash component](/build-your-own-components).

---



**Q:** _I have more questions! Where can I go to ask them?_

**A:** The [Dash Community forums](https://community.plotly.com/c/dash) is full
of people discussing Dash topics, helping each other with questions, and
sharing Dash creations. Jump on over and join the discussion.
