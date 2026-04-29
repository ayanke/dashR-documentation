---
url: /external-resources
name: Adding CSS & JS and Overriding the Page-Load Template
description:
    "Learn how to add custom CSS and JS to your app as well as how to customize the HTML title, meta tags, and more."
icon: web-page.svg
languages:
  - python
  - r
  - fsharp
---
# ![](/assets/images/language_icons/r-lang_50px.svg) Adding CSS & JS and Overriding the Page-Load Template
Dash apps are rendered in the web browser with CSS and JavaScript.
On page load, Dash serves a small HTML template that includes references to
the CSS and JavaScript that are required to render the app.
This chapter covers everything that you need to know about configuring
this HTML file and about including external CSS and JavaScript in Dash
apps.

## Adding Your Own CSS and JavaScript to Dash Apps

Dash supports adding custom CSS or JavaScript in your apps.

Create a folder named `assets` in the root of your app directory
and include your CSS and JavaScript
files in that folder. Dash automatically serves all the files that
are included in this folder. By default, the URL to request the assets
is `/assets`, but you can customize this with the `assets_url_path` argument
to `dash.Dash`.



### Example: Including Local CSS and JavaScript

We'll create several files: `app.R`, a folder named `assets`, and
three files in that folder:

&nbsp;

`app.R`

{{example local-css}}

&nbsp;

`typography.css`

```css
body {
    font-family: sans-serif;
}
h1, h2, h3, h4, h5, h6 {
    color: hotpink
}
```

&nbsp;

`header.css`

```css
.app-header {
    height: 60px;
    line-height: 60px;
    border-bottom: thin lightgrey solid;
}

.app-header .app-header--title {
    font-size: 22px;
    padding-left: 5px;
}
```

&nbsp;

`custom-script.js`

```js
alert('If you see this alert, then your custom JavaScript script has run!')
```

When you run your app, it should look something like this:

![Preview of the local-css example Dash app with the CSS styling applied](/assets/images/external-resources/local-css.png)







## Embedding Images in Your Dash Apps

In addition to CSS and JavaScript files, you can include images in
the `assets` folder. An example of the folder structure:

```
- app.py
- assets/
    |-- image.png

```
&nbsp;

In your `app.R` file you can use the relative path to that image:

{{example embedding-images}}

> If placing images inside the `assets` folder isn't an option, then you can
> also embed images "inline" with base64 encoding:

{{example embedding-images-base64}}

***

## Changing the Favicon

It is possible to override the default favicon by adding
a file named `favicon.ico` to your `assets` folder. Changes to
this file will implement cache-busting automatically.

```
- app.py
- assets/
    |-- favicon.ico
```

***

## Adding External CSS/JavaScript



**Example:**

{{example external-resources-init}}

***

## Controlling the Plotly.js Version Used by `dcc.Graph`

The `dcc.Graph` component leverages the [Plotly.js](https://plotly.com/javascript/) library to render visualizations.

` component uses the version of the Plotly.js library in the Plotly.py version you have installed. Each version of Dash prior to 2.13 included its own version of Plotly.js.

If you want to use a different version of Plotly.js in Dash 2.13 or later, you can use a different version of Plotly.py. See the [Plotly.py releases page](https://github.com/plotly/plotly.py/releases) for more details on which version of Plotly.js was included with each release.

In all versions of Dash you can also override the Plotly.js version by placing a Plotly.js bundle [in the `assets` directory](/external-resources).||julia|r

You can override the Plotly.js version by placing a Plotly.js bundle in the `assets` directory.

||fsharp

You can override the Plotly.js version by placing a Plotly.js bundle in the `WebRoot` directory.

}}

This technique can be used to:
* take advantage of new features in a version of Plotly.js that is **more recent** than the one that is included in the currently installed version of Dash or Dash Design Kit.
* take advantage of more desirable behavior of a version of Plotly.js that is **less recent** than the one that is included in the currently installed version of Dash or Dash Design Kit. We strive to make Plotly.js releases completely backwards-compatible, so you shouldn't have to do this very often.
* use [a Plotly-distributed Plotly.js partial bundle](https://github.com/plotly/plotly.js/blob/master/dist/README.md) or [a custom-built Plotly.js bundle](https://github.com/plotly/plotly.js/blob/master/BUILDING.md) which only includes the subset of Plotly.js features that your Dash app uses. Partial bundles are smaller than the full Plotly.js bundles that come with the `dcc.Graph` component and can therefore improve your app's loading time.

## Rendering LaTeX Inside `dcc.Graph` Figures

To use the built-in Plotly.js capability of rendering LaTeX inside figure labels, the `external_script` functionality described above can be used: add `external_scripts=["https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML" ]` to the `app = dash.Dash()` call.

{{oss {{dash-club}} }}

## Customizing Dash's Document or Browser Tab Title
The document title is the name of the web page that appears in your
web browser's tab.

By default, it is Dash.



## Update the Document Title Dynamically Based on the URL or Tab

To set the document title dynamically, you can use a clientside callback
that updates the `document.title` as a side effect. The example below
sets the `document.title` based off of the currently selected tab.

{{example clientside-callback-title}}

Updating the page based off of the URL would be similar: the input of the
callback would be the `pathname` property of `{{component dcc.Location`. See the
<dccLink href="/urls" children="URLs and Multi Page Apps"/> chapter for
a `dcc.Location` example.
}}

## Customizing or Removing Dash's "Updating..." Message

When a callback is running, Dash updates the document title
(the title that appears in your browser tab) with the "Updating..."
message.

Customize this message with the `update_title=` property:



***

## Customizing Dash's HTML Index Template

Dash's UI is generated dynamically with Dash's React.js front-end. So,
on page load, Dash serves a very small HTML template string that includes
the CSS and JavaScript that is necessary to render the page and some simple
HTML meta tags.

This simple HTML string is customizable. You might want to customize this
string if you wanted to:
- Customize the way that your CSS or JavaScript is included in the page.
For example, if you wanted to include remote scripts or if you wanted to
include the CSS _before_ the Dash component CSS
- Include custom meta tags in your app. Note that meta tags can also be
added with the `meta_tags` argument (example below).
- Include a custom version of `dash-renderer`, by instantiating the
`DashRenderer` JavaScript class yourself. You can add request hooks this way, by providing
a `hooks` config object as in the example below.



***

## Customizing `dash-renderer` with Request Hooks



{{example custom-dash-renderer}}

When you provide your own DashRenderer, you can also pass in a `hooks` object that holds `request_pre` and `request_post` functions. These request hooks will be fired
before and after Dash makes a request to its backend. Here's an example:

{{example custom-dash-renderer-hooks}}

Notice the `request_pre` function takes the payload of the request being sent as its argument, and the `request_post` function takes both the payload and the response of the server
as arguments. These can be altered in our function, allowing you to modify the response and request objects that Dash sends to the server. In the example above, the `request_pre`
function is fired before each server call, and in the case of this example, it will `console.log()` the request parameter. The `request_post` function will fire __after__ each server
call, and in our example will also print out the response parameter.

***

## Customizing Meta Tags

> Not sure what meta tags are?
> [Check out this tutorial on meta tags and why you might want to use them](https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/The_head_metadata_in_HTML).

Dash adds some meta tags to your app by default:

- A tag to tell [Internet Explorer](https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/compatibility#understanding-legacy-document-modes) to use the latest renderer available for that browser:

    ```
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    ```

- A tag to set the [encoding](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta#attr-charset) to UTF-8:

    ```
    <meta charset="UTF-8">
    ```

- And in Dash 2.5 and later, a tag to control [page layouts on mobile browsers](https://developer.mozilla.org/en-US/docs/Web/HTML/Viewport_meta_tag):

    ```
    <meta name="viewport" content="width=device-width, initial-scale=1">
    ```

### Overriding Default Tags
To override or add custom meta tags to your app, 
you can specify meta tags directly in the Dash constructor:

- To clear the `name="viewport" content="width=device-width, initial-scale=1"` tag (introduced in Dash 2.5), set an empty tag:

    ```
    app = Dash(__name__, meta_tags=[{"viewport": ""}])
    ```

- To override the `http-equiv="X-UA-Compatible"` meta tag, set a new one:

    ```
    app = Dash(__name__, meta_tags=[{'http-equiv': 'X-UA-Compatible', 'content': 'IE=9'}])

    ```

- To override the `charset` meta tag, set a new one:

    ```
    app = Dash(__name__, meta_tags=[{'charset': 'iso-8859-1'}])
    ```

### Adding Additional Tags

You can also add additional tags. Here's an example of adding `description`
and `robots` meta tags.

{{example dash-meta-tags}}

If you inspect the source of your app, you'll see the meta tags.
In this example, there are the two custom tags we added, along with
the three default meta tags.

![Dash App with Custom Meta Tags](/assets/images/gallery/external-resources-head.jpg)

***
## Serving Dash's Component Libraries Locally or from a CDN

**Changed in Dash 1.0.0 - now `serve_locally` defaults to `True`,
previously it defaulted to `False`**

Dash's component libraries, like `dash_core_components` and `dash_html_components`,
are bundled with JavaScript and CSS files. Dash automatically checks with
component libraries are being used in your app and will automatically
serve these files in order to render the app.

By default, Dash serves the JavaScript and CSS resources from the
local files on the server where Dash is running. This is the more flexible
and robust option: in some cases, such as firewalled or airgapped
environments, it is the only option. It also avoids some hard-to-debug
problems like packages that have not been published to NPM or CDN downtime,
and the unlikely but possible scenario of the CDN being hacked. And of
course, component developers will want the local version while changing the
code, so when dev bundles are requested (such as with `debug=True`) we
always serve locally.

However, for performance-critical apps served beyond an intranet, online
CDNs can often deliver these files much faster than loading the resources
from the file system, and will reduce the load on the Dash server.

```python
from dash import Dash

app = Dash(__name__, serve_locally=False)

```

This will load the bundles from the https://unpkg.com/ CDN, which is a community-maintained project that serves JavaScript bundles from NPM. We don't maintain it, so we cannot guarantee or attest to its uptime, performance, security, or long term availability.

Also note that we don't publish the dev bundles to `unpkg`, so when running the app locally with `python app.py`, the local JavaScript files will be served. When the app is deployed with `gunicorn`, it'll switch to the CDN.

***


## Sample Dash CSS Stylesheet

Currently, Dash does not include styles by default.

To get started with Dash styles, we recommend starting with this [CSS stylesheet](https://codepen.io/chriddyp/pen/bWLwgP?editors=1100) hosted
on [Codepen](https://codepen.io).

To include this stylesheet in your app, copy and paste it into a file
in your `assets` folder. You can view the raw CSS source here:
[https://codepen.io/chriddyp/pen/bWLwgP.css](https://codepen.io/chriddyp/pen/bWLwgP.css).

{{oss

Here is an embedded version of this stylesheet.

<iframe
    width='100%'
    height='400'
    border='none'
    src='//codepen.io/chriddyp/embed/bWLwgP/?height=265&theme-id=light&default-tab=css,result&embed-version=2'></iframe>

}}

***

## Syntax Highlighting With Markdown

Both [`dash-table`](https://dash.plotly.com/datatable) and
[`dash-core-components`](https://dash.plotly.com/dash-core-components)
support Markdown formatting, which you can use to specify
syntax highlighting for inline code.

Highlighting is handled by
[`highlight.js`](https://highlightjs.org/). By default, only
certain languages are recognized, and there is only one color
scheme available. However, you can override this by downloading a
custom `highlight.js` package. To do this, visit
[https://highlightjs.org/download/](https://highlightjs.org/download/),
and in the **Custom package** section, select all the
languages that you require, download your package, and place the
resulting `highlight.min.js` file into the `assets` folder. The package should also come with a `styles/` directory;
to use a different color scheme, copy the corresponding
stylesheet into your app's `assets` folder.
