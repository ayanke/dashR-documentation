---
url: /basic-callbacks
name: Part 2. Basic Callbacks
description:
    "Dash apps are made interactive through Dash Callbacks: chainable functions
    that are automatically called whenever a UI element is changed."
icon: settings.svg
languages:
  - python
  - julia
  - r
  - fsharp
  - matlab
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Basic Dash Callbacks

> This is the 2nd chapter of the [Dash Fundamentals](/).
> The [previous chapter](/layout) covered the Dash app `layout`
> and the [next chapter](/interactive-graphing) covers interactive graphing.
> Just getting started? Make sure to [install the necessary dependencies](/installation).

In the [previous chapter](/layout) we learned that `set_layout()` describes what the app looks like and is a hierarchical tree of components.
The Dash package provides functions for all of the HTML tags, and the keyword arguments describe the HTML attributes like `style`, `className`, and `id`.
The `dashCoreComponents` package generates higher-level components like controls and graphs.

This chapter describes how to make your Dash apps using *callback functions*: functions that are automatically called by Dash whenever an input component's property changes, in order to update some property in another component (the output).

For optimum user-interaction and chart loading performance, production
Dash apps should consider the [Job Queue](https://plotly.com/dash/job-queue/),
[HPC](https://plotly.com/dash/big-data-for-python/), [Datashader](https://plotly.com/dash/big-data-for-python/),
and horizontal scaling capabilities of Dash Enterprise.

Let's get started with a simple example of an interactive Dash app.

#### Simple Interactive Dash App
{{oss
> If you're using Dash Enterprise's [Data Science Workspaces](https://plotly.com/dash/workspaces/),
> copy & paste the below code into your Workspace ([see video](https://plotly.com/dash/workspaces/#screencast)).

> _[Find out if your company is using Dash Enterprise](https://plotly.com/company-lookup/)_
}}

{{example simple-callback}}

Let's break down this example:

1. The "inputs" and "outputs" of our application are described
   as the arguments of the `add_callback()` function. The first parameter is the output, the second parameter is the input.


}}

2. In Dash, the inputs and outputs of our application are simply the
   properties of a particular component. In this example,
   our input is the "`value`" property of the component that has the ID
   "`my-input`". Our output is the "`children`" property of the
   component with the ID "`my-output`". You can think of the "`children`" property of a component as the content inside it on the webpage.
3. Whenever an input property changes, the function defined as the callback will get called automatically.
   Dash provides this callback function with the new value of the input property as
   its argument, and Dash updates the property of the output component
   with whatever was returned by the function.
4. This callback essentially means that we're telling Dash to call the callback function whenever the value of the "input" component (the text box) changes in order to update the content ("children") of the "output" component on the page (the HTML div)..
5. input` object and the `dcc.Input` object. The former is just used in these callback definitions and the latter is an actual component ||r Don't confuse the `input()` used in `add_callback()` with `dcc.Input()`. The former is used to describe the inputs of a callback, while the latter is a Dash component||matlab In your callback function, the output must be json encoded. To do this, use the `jsonencode` function}}.
6. Notice how we don't set a value for the `children` property of the
   `my-output` component in the `layout`. When the Dash app starts, it
   automatically calls all of the callbacks with the initial values of the
   input components in order to populate the initial state of the output
   components. In this example, if you specified the div component as
   (id='my-output', children='Hello world')`
   ||r `div(id = 'my-output', 'Hello world')`
   }},
   it would get overwritten when the app starts.
7. The `id` used for the `input()` and `output()` in the callback must match the ID of Dash components on the page.


It's sort of like programming with Microsoft Excel:
whenever a cell changes (the input), all the cells that depend on that cell (the outputs)
will get updated automatically. This is called "Reactive Programming" because the outputs *react* to changes in the inputs automatically.

Remember how every component is described entirely through its
 arguments? Those arguments that we set in
R become *properties* of the component,
and these properties are important now.
With Dash's interactivity, we can dynamically update any of those properties
using callbacks. Often we'll update the `children` property of HTML
components to display new text (remember that `children` is responsible for the contents of a component) or the `figure` property of a `dcc.Graph`
component to display new data. We could also update the `style` of a
component or even the available `options` of a `dcc.Dropdown` component!

***

Let's take a look at another example where a `dcc.Slider` updates
a `dcc.Graph`.

#### Dash App Layout With Figure and Slider

{{example simple-slider}}

{{details
Theming with **Dash Enterprise Design Kit**

Default Theme
![Default Theme](/assets/images/ddk/default.png)

Mars Theme
![Mars Theme](/assets/images/ddk/mars.png)

Neptune Theme
![Neptune Theme](/assets/images/ddk/neptune.png)

Miller Theme
![Miller Theme](/assets/images/ddk/miller.jpg)

Extrasolar Theme
![Extrasolar Theme](/assets/images/ddk/extrasolar.png)

Preset Themes
![Preset Themes](/assets/images/ddk/theme-editor.png)
}}

In this example, the `"value"` property of the `dcc.Slider` is the
input of the app, and the output of the app is the `"figure"` property of the
`dcc.Graph`.
Whenever the `value` of the `dcc.Slider` changes, Dash calls the
callback function  with the new value. The function filters the
dataframe with this new value, constructs a `figure` object,
and returns it to the Dash application.

There are a few nice patterns in this example:

1. We
   load our dataframe at the start of the app:
   `df <- read.csv('...')`.
   This dataframe `df` is in the global state of the app and can be
   read inside the callback functions.
2. Loading data into memory can be expensive. By loading querying data at
   the start of the app instead of inside the callback functions, we ensure
   that this operation is only done once -- when the app server starts. When a user
   visits the app or interacts with the app, that data (`df`) is already in memory.
   If possible, expensive initialization (like downloading or querying
   data) should be done in the global scope of the app instead of within
   the callback functions.
3. The callback does not modify the original data, it only creates copies
   of the dataframe by filtering .
   **This is important:** *your callbacks should never modify variables
   outside of their scope*. If your callbacks modify global state, then one
   user's session might affect the next user's session and when the app is
   deployed on multiple processes or threads, those modifications will not
   be shared across sessions.


{{oss {{dash-club}} }}

#### Dash App With Multiple Inputs

In Dash, any "output" can have multiple "input" components.
Here's a simple example that binds five inputs
(the `value` property of two `dcc.Dropdown` components,
two `dcc.RadioItems` components, and one `dcc.Slider` component)
to one output component (the `figure` property of the `dcc.Graph` component).
Notice how `add_callback()` lists all five `input()`s after the `output()`. Also notice
that when there is more than one input, you need to place the inputs inside a `list`.

{{example multi-inputs}}

{{details
Theming with **Dash Enterprise Design Kit**

Default Theme
![Default Theme](/assets/images/ddk/multiple-inputs-default.png)

Mars Theme
![Mars Theme](/assets/images/ddk/multiple-inputs-mars.png)

Neptune Theme
![Neptune Theme](/assets/images/ddk/multiple-inputs-neptune.png)

Miller Theme
![Miller Theme](/assets/images/ddk/multiple-inputs-miller.png)

Extrasolar Theme
![Extrasolar Theme](/assets/images/ddk/multiple-inputs-extrasolar.png)

Design Kit Theme Editor
![Design Kit Theme Editor](/assets/images/ddk/theme-editor.png)
}}

In this example, the callback executes whenever the `value` property of any of the
`dcc.Dropdown`, `dcc.Slider`,
or `dcc.RadioItems` components change.

The input arguments of the callback are the current
value of each of the "input" properties, in the order that they were
specified.

Even though only a single input changes at a time (i.e. a user can only change
the value of a single Dropdown in a given moment), Dash collects the
current state of all the specified input properties and passes them
into the callback function. These callback functions are always guaranteed
to receive the updated state of the app.

Let's extend our example to include multiple outputs.

#### Dash App With Multiple Outputs

So far all the callbacks we've written only update a single output property.
We can also update several outputs at once: list all the properties you want to update
inside a `list` in `add_callback()`,
and return that many items from the callback. This is particularly useful if
two outputs depend on the same computationally intensive intermediate result,
such as a slow database query.

{{example multi-output}}

Note that you can update multiple properties of the same component,
or you can even update multiple different components. Also note that when a callback has multiple outputs,
you need to return all the different outputs in a `list`.

A word of caution: it's not always a good idea to combine outputs, even if
you can:

- If the outputs depend on some, but not all, of the same inputs, then keeping
  them separate can avoid unnecessary updates.
- If the outputs have the same inputs but they perform very different computations with these
  inputs, keeping the callbacks separate can allow them to run in parallel.

#### Dash App With Chained Callbacks

You can also chain outputs and inputs together: the output of one callback
function could be the input of another callback function.

This pattern can be used to create dynamic UIs where, for example, one input component
updates the available options of another input component.
Here's a simple example.

{{example callback-chain}}

The first callback updates the available options in the second
`dcc.RadioItems` component based off of the selected value in the
first `dcc.RadioItems` component.

The second callback sets an initial value when the `options` property
changes: it sets it to the first value in that `options` list.

The final callback displays the selected `value` of each component.
If you change the `value` of the countries `dcc.RadioItems`
component, Dash will wait until the `value` of the cities component is updated
before calling the final callback. This prevents your callbacks from being
called with inconsistent state like with `"America"` and `"Montréal"`.

#### Dash App With State

In some cases, you might have a "form"-like pattern in your
application. In such a situation, you may want to read the value
of an input component, but only when the user is finished
entering all of their information in the form rather than immediately after
it changes.

Attaching a callback to the input values directly can look like this:

{{example basic-input}}

In this example, the callback function is fired whenever any of the
attributes described by the inputs change.
Try it for yourself by entering data in the inputs above.

`"state"` allows you to pass along extra values without
firing the callbacks. Here's the same example as above but with the two
`dcc.Input` components as states
and a new button component as an input.

{{example basic-state}}

In this example, changing text in the `dcc.Input` boxes won't fire
the callback, but clicking on the button will. The current values of the
`dcc.Input` values are still passed into the callback even though
they don't trigger the callback function itself.

Note that we're triggering the callback by listening to the `n_clicks` property
of the ` ||r `button`}} component. `n_clicks` is a property that gets
incremented every time the component has been clicked on.
It's available in every pure HTML component in
Dash package, but most useful with buttons.

` component with the `id` 'my-input' and a `html.Div` with the `id` 'my-output':

```
app.layout = html.Div([
    html.H6("Change the value in the text box to see callbacks in action!"),
    html.Div([
        "Input: ",
        dcc.Input(id='my-input', value='initial value', type='text')
    ]),
    html.Br(),
    html.Div(id='my-output'),

@callback(
    Output('my-output', 'children'),
    Input('my-input', 'value')
)
def update_output_div(input_value):
    return f'Output: {input_value}'
```

You can also provide components directly as inputs and outputs without adding or referencing an `id`. Dash autogenerates IDs for these components.

Here is the first example again. Prior to declaring the app layout, we create two components, assigning each one to a variable. We then reference these variables in the layout and pass them directly as inputs and outputs to the callback.

{{example simple-callback-ids}}

In Python 3.8 and higher, you can use the walrus operator to declare the component variables within the app layout:

```python

app.layout = html.Div([
    html.H6("Change the value in the text box to see callbacks in action!"),
    html.Div([
        "Input: ",
        my_input := dcc.Input(value='initial value', type='text')
    ]),
    html.Br(),
    my_output := html.Div(),
])

@callback(
    Output(my_output, 'children'),
    Input(my_input, 'value')
)
def update_output_div(input_value):
    return f'Output: {input_value}'

```

> Note: Auto component IDs won't work with dynamic callback content unless the component variables are defined out of the callback scope. Additionally, they are not compatible with <dccLink href="/pattern-matching-callbacks" children="Pattern-Matching Callbacks"/>.

}}

#### Summary

We've covered the fundamentals of callbacks in Dash.
Dash apps are built off of a set
of simple but powerful principles: UIs that are customizable
through reactive callbacks.
Every attribute/property of a component can be modified
as the output of a callback, while a subset of the attributes (such as the `value`
property of `dcc.Dropdown` component)
are editable by the user through interacting with the page.

***

The next part of the Dash Fundamentals covers interactive graphing. <dccLink href="/interactive-graphing" children="Dash Fundamentals Part 3: Interactive Graphing"/>
