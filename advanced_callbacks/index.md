---
url: /advanced-callbacks
name: Advanced Callbacks
description:
    Now that you've gotten through the basics,
    explore some other things you can do with callbacks -
    from performance improvements to callback contexts.
icon: startup.svg
languages:
  - python
  - julia
  - r
  - fsharp
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Advanced Callbacks

> To get the most out of this page, make sure you've read about <dccLink href="/basic-callbacks" children="Basic Callbacks"/> in the Dash Fundamentals.

## Catching Errors with `dashNoUpdate`

In certain situations, you don't want to update the callback output. You can
achieve this by
returning `dashNoUpdate()` in
the callback function.


{{example prevent_update_button}}

## Displaying Errors with `dashNoUpdate`

This example illustrates how you can show an error while keeping the previous
input, using `dashNoUpdate`
to update only some of the callback outputs.

{{example prevent_update}}



## Determining which `Input` Has Fired with `callback_context`

In addition to event properties like `n_clicks`
that change whenever an event happens (in this case a click), there is

a method `app$callback_context`
available only inside a callback. Using `dash.callback_context`, you can determine which component/property pairs triggered a callback.

Below is a summary of properties of `dash.callback_context` outlining the basics of when to use them. For more detail and examples see <dccLink href="/determining-which-callback-input-changed" children="Determining Which Callback Input Changed"/>.

{{python For more examples of minimal Dash apps that use `dash.callback_context`, go to the community-driven [Example Index](https://dash-example-index.herokuapp.com/?code=ctx).

### Properties for `callback_context`

- `triggered_id`: The `id` of the component that triggered the callback. *Available in Dash 2.4 and later*.
- `triggered_prop_ids`: A dictionary of the component ids and props that triggered the callback. Useful when multiple inputs can trigger the callback at the same time, or multiple properties of the same component can trigger the callback. *Available in Dash 2.4 and later*.
- `args_grouping`: A dictionary of the inputs used with flexible callback signatures. *Available in Dash 2.4 and later*.

  The keys are the variable names and the values are dictionaries containing:
    - "id": the component ID. If it’s a pattern matching ID, it will be a dict.
    - "id_str": for pattern matching IDs, it’s the stringified dict ID with no white spaces.
    - "property": the component property used in the callback.
    - "value": the value of the component property at the time the callback was fired.
    - "triggered": a boolean indicating whether this input triggered the callback.
- `triggered`: list of all the `Input` props that changed and caused the callback to execute.
It is empty when the callback is called on initial load, unless an `Input` prop got its
value from another initial callback. Callbacks triggered by user actions typically have
one item in `triggered`, unless the same action changes two props at once or the callback
has several `Input` props that are all modified by another callback based on a single user action.

  > **More about empty `triggered` lists**: For backward compatibility purposes, an empty
  `triggered` is not really empty. It's
  falsy so that you can use `if triggered` to detect the initial call, but it still has a placeholder
  element so that `ctx.triggered[0]["prop_id"].split(".")` yields a blank ID and prop `["", ""]`
  instead of an error.

- `inputs` and `states`: allow you to access the callback params
  by ID and prop instead of through the function args. These have the form
  of dictionaries `{ 'component_id.prop_name': value }`
}}


Here's an example of how this can be done:

{{example last_clicked_button}}





{{oss {{dash-club}} }}

## When Are Callbacks Executed?

This section describes the circumstances under which the `dash-renderer`
front-end client can make a request to the Dash back-end server (or the
clientside callback code) to execute a callback function.

### When a Dash App First Loads

All of the callbacks in a Dash app are executed with the initial value
of their inputs when the app is first loaded. This is known as the
"initial call" of the callback. To learn how to suppress this behavior,
see the documentation for the
[`prevent_initial_call`](#prevent-callbacks-from-being-executed-on-initial-load)
attribute of Dash callbacks.

It is important to note that when a Dash app is initially loaded in a
web browser by the `dash-renderer` front-end client, its entire callback
chain is introspected recursively.

This allows the `dash-renderer` to predict the order in which callbacks
will need to be executed, as callbacks are blocked when their inputs are
outputs of other callbacks which have not yet fired. In order to unblock
the execution of these callbacks, first callbacks whose inputs are
immediately available must be executed. This process helps the
`dash-renderer` to minimize the time and effort it uses, and avoid
unnecessarily redrawing the page, by making sure it only requests that
a callback is executed when all of the callback's inputs have reached
their final values.

Examine the following Dash app:

{{example callbacks-initial-call}}

Notice that when this app is finished being loaded by a web browser and
ready for user interaction, the `html.Div` components do not say
"callback not executed" as declared in the app's layout, but rather
"n_clicks is None" as the result of the
`change_text()` callback being
executed. This is because the "initial call" of the callback occurred
with `n_clicks` having the value of `None`.


### As a Direct Result of User Interaction

Most frequently, callbacks are executed as a direct result of user
interaction, such as clicking a button or selecting an item in a
dropdown menu. When such interactions occur, Dash components communicate
their new values to the `dash-renderer` front-end client, which then
requests that the Dash server execute any callback function that has the
newly changed value as input.

If a Dash app has multiple callbacks, the `dash-renderer` requests
callbacks to be executed based on whether or not they can be immediately
executed with the newly changed inputs. If several inputs change
simultaneously, then requests are made to execute them all.

Whether or not these requests are executed in a synchronous or
asynchronous manner depends on the specific setup of the Dash back-end
server. If it is running in a multi-threaded environment, then all of
the callbacks can be executed simultaneously, and they will return
values based on their speed of execution. In a single-threaded
environment however, callbacks will be executed one at a time in the
order they are received by the server.

In the example application above, clicking the button results in the
callback being executed.

### As an Indirect Result of User Interaction

When a user interacts with a component, the resulting callback might
have outputs that are themselves the input of other callbacks. The
`dash-renderer` will block the execution of such a callback until the
callback whose output is its input has been executed.

Take the following Dash app:

{{example callbacks-user-interaction}}

The above Dash app demonstrates how callbacks chain together. Notice
that if you first click "execute slow callback" and then click "execute
fast callback", the third callback is not executed until after the slow
callback finishes executing. This is because the third callback has the
second callback's output as its input, which lets the `dash-renderer`
know that it should delay its execution until after the second callback
finishes.

### When Dash Components Are Added to the Layout

It is possible for a callback to insert new Dash components into a Dash
app's layout. If these new components are themselves the inputs to other
callback functions, then their appearance in the Dash app's layout will
trigger those callback functions to be executed.

In this circumstance, it is possible that multiple requests are made to
execute the same callback function. This would occur if the callback in
question has already been requested and its output returned before the
new components which are also its inputs are added to the layout.

## Prevent Callback Execution Upon Initial Component Render

You can use the `prevent_initial_call`
attribute to prevent callbacks
from firing when their inputs initially appear in the layout of your
Dash application.

This attribute applies when the layout of your Dash app is initially
loaded, and also when new components are introduced into the layout when
a callback has been triggered.

{{example callbacks-prevent-initial-call}}

However, the above behavior only applies if both the callback output and
input are present in the app layout upon initial load of the application.

It is important to note that `prevent_initial_call`
will not prevent a callback from firing in the case where the callback's input is inserted
into the layout as the result of another callback after the app initially
loads **unless the output is inserted alongside that input**!

In other words, if the output of the callback is already present in the
app layout before its input is inserted into the layout,
`prevent_initial_call`
will not prevent its execution when the input is first inserted into the layout.

Consider the following example:

{{example prevent_initial_chain}}

In this case, `prevent_initial_call`
will prevent the `update_output()`
callback from firing when its input is first inserted into the app
layout as a result of the `display_page()`
callback. This is because both the input and output of the callback are already
contained within the app layout when the callback executes.

However, because the app layout contains only the output of the
callback, and not its input, `prevent_initial_call`
will not prevent the `update_layout_div()`
callback from firing. Since `suppress_callback_exceptions=True` is specified here,
Dash has to assume that the input is present in the app layout when the app is
initialized. From the perspective of the output element in this example,
the new input component is handled as if an existing input had been
provided a new value, rather than treating it as initially rendered.


## Circular Callbacks

As of `dash v1.19.0`, you can create circular updates
_within the same callback_.

Circular callback chains that involve multiple callbacks are not supported.

Circular callbacks can be used to keep multiple inputs synchronized to
each other.

### Synchronizing a Slider with a Text Input Example

{{example circular_slider_input}}

### Displaying Two Inputs with Different Units Example

{{example circular_units_input}}

### Synchronizing Two Checklists

{{example circular_checkbox}}

