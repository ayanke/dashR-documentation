---
url: /pattern-matching-callbacks
name: Pattern-Matching Callbacks
description:
    "The pattern-matching callback selectors `MATCH`, `ALL`, & `ALLSMALLER` allow you to write callbacks that respond to or update an arbitrary or dynamic number of components."
icon: paste.svg
languages:
    - python
    - r
---

# ![](/assets/images/language_icons/r-lang_50px.svg) Pattern-Matching Callbacks

> To get the most out of this page, make sure you've read about <dccLink href="/basic-callbacks" children="Basic Callbacks"/> in the Dash Fundamentals.

The pattern-matching callback selectors `MATCH`, `ALL`, & `ALLSMALLER` allow you to write callbacks that respond to or update an arbitrary or dynamic number of components.

## Simple Example with `ALL`

> This example uses <dccLink href="/partial-properties" children="partial property updates"/>, introduced in Dash 2.9. For an example that works with earlier versions of Dash, see Simple `ALL` Example Without Partial Updates at the end of this example.

This example renders an arbitrary number of `dcc.Dropdown` elements and the callback is fired whenever any of the `dcc.Dropdown` elements change. Try adding a few dropdowns and selecting their values to see how the app updates.

{{example simple_all}}

Some notes about this example:
- Notice how the `id` in `dcc.Dropdown` is a _dictionary_ rather than a _string_.
This is a new feature that we enabled for pattern-matching callbacks (previously, IDs had to be strings).
- In our second callback, we have `Input({'type': 'city-filter-dropdown', 'index': ALL}, 'value')`. This means "match any input that has an ID dictionary where `'type'` is `'city-filter-dropdown'` and `'index'` is _anything_. Whenever the `value` property of any of the dropdowns change, send _all_ of their values to the callback."
- The keys & values of the ID dictionary (`type`, `index`, `city-filter-dropdown`) are arbitrary. This could've be named `{'foo': 'bar', 'baz': n_clicks}`.
- However, for readability, we recommend using keys like `type`, `index`, or `id`. `type` can be used to refer to the class or set dynamic components and
`index` or `id` could be used to refer _which_ component you are matching within that set. In this example, we just have a single set of dynamic
components but you may have multiple sets of dynamic components in more complex apps or if you are using `MATCH` (see below).
- In fact, in this example, we didn't actually _need_ `'type': 'city-filter-dropdown'`. The same callback would have worked with `Input({'index': ALL}, 'value')`.
We included `'type': 'city-filter-dropdown'` as an extra specifier in case you create multiple sets of dynamic components.
- The component properties themselves (e.g. `value`) cannot be matched by a pattern, only the IDs are dynamic.
- This example uses `Patch` to make a  <dccLink href="/partial-properties" children="partial update"/> to the `'children'` property  of `'dropdown-container-div'`. We append a dropdown each time the first callback runs.

{{details Simple `ALL` Example Without Partial Updates

This example is similar to the Simple Example with `ALL` above, but uses `State` to access the list of currently displayed dropdowns. In the first callback, we then append to this list of dropdowns and return it as the output.

{{example simple_all_without_partial_updates}}

}}

## Simple Example with `MATCH`

> This example uses <dccLink href="/partial-properties" children="partial property updates"/>, introduced in Dash 2.9. For an example that works with earlier versions of Dash, see Simple `MATCH` Example Without Partial Updates at the end of this example.

Like `ALL`, `MATCH` will fire the callback when any of the component's properties change. However, instead of passing _all_ of the values into the callback, `MATCH` will pass just a single value into the callback. Instead of updating a single output, it will update the dynamic output that is "matched" with.

{{example simple_match}}

Notes about this example:
- The `display_dropdowns` callback returns two elements with the _same_ `index`: a dropdown and a div.
- The second callback uses the `MATCH` selector. With this selector, we're asking Dash to:

  1. Fire the callback whenever the `value` property of any component with the id `'type': 'dynamic-dropdown'` changes:
  `Input({'type': 'dynamic-dropdown', 'index': MATCH}, 'value')`
  1. Update the component with the id `'type': 'dynamic-output'` and the `index` that _matches_ the same `index` of the input:
  `Output({'type': 'dynamic-output', 'index': MATCH}, 'children')`
  1. Pass along the `id` of the dropdown into the callback:
  `State({'type': 'dynamic-dropdown', 'index': MATCH}, 'id')`
- With the `MATCH` selector, only a _single_ value is passed into the callback for each `Input` or `State`. This is unlike the previous example with the
`ALL` selector where Dash passed _all_ of the values into the callback.
- Notice how it's important to design IDs dictionaries that "line up" the inputs with outputs. The `MATCH` contract is that Dash will update whichever output has the same dynamic ID as the id. In this case, the "dynamic ID" is the value of the `index` and we've designed our layout to return dropdowns & divs with identical values of `index`.
- In some cases, it may be important to know _which_ dynamic component changed. As above, you can access this by setting `id` as `State` in the callback.
- You can also use `dash.callback_context` to access the inputs and state and to know which input changed. `outputs_list` is particularly useful with
`MATCH` because it can tell you _which_ dynamic component this particular invocation of the callback is responsible for updating. Here is what that data might look like with two dropdowns rendered on the page after we change the first dropdown.
  - `dash.callback_context.triggered_prop_ids` (available from Dash 2.4) returns a dictionary of inputs that triggered the callback. Each key is a `<component_id>.<component_property>` and the corresponding value is the `<component_id>`. In this example, we can see that the id of the component that triggered the callback was `{'index': 0, 'type': 'dynamic-dropdown'}`and the property was `value`:
  ```
  {
    '{"index":0,"type":"dynamic-dropdown"}.value': {
        "index": 0,
        "type": "dynamic-dropdown",
    }
  }
  ```

  - `dash.callback_context.triggered`. Note that the `prop_id` is a stringified dictionary with no whitespace.

  - `dash.callback_context.inputs`. Note that the key is a stringified dictionary with no whitespace.

  - `dash.callback_context.inputs_list`. Each element of the list corresponds to one of the input declarations. If one of the input declarations matches a pattern then it will contain a list of values.

  - `dash.callback_context.outputs_list`

{{details Simple `MATCH` Example Without Partial Updates

{{example simple_match_without_partial_updates}}

}}

## Simple Example with `ALLSMALLER`

> This example uses <dccLink href="/partial-properties" children="partial property updates"/>, introduced in Dash 2.9. For an example that works with earlier versions of Dash, see Simple `ALLSMALLER` Example Without Partial Updates at the end of this example.

In the following example, `ALLSMALLER` is used to pass in the values of all of the dropdowns on the page that have an index smaller than the index corresponding to the div.

The user interface in the example below displays filter results that are increasingly specific in each as we apply each additional dropdown.

`ALLSMALLER` can only be used in `Input` and `State` items, and must be used on a key that has `MATCH` in the `Output` item(s).

`ALLSMALLER` it isn't always necessary (you can usually use `ALL` and filter out the indices in your callback) but it will make your logic simpler.

{{example simple_allsmaller}}

- In the example above, try adding a few filters and then change the first dropdown. Notice how changing this dropdown will update the text of each `html.Div` that has an index that depends on that dropdown.
- That is, each `html.Div` will get updated whenever any of the dropdowns with an `index` smaller than it has changed.
- So, if there are 10 filters added and the first dropdown has changed, Dash will fire your callback 10 times, once to update each `html.Div` that depends
on the `dcc.Dropdown` that changed.
- As above, you can also use `dash.callback_context` to access the inputs and state and to know which input changed. Here is what that data might look like when updating the second div with two dropdowns rendered on the page after we change the first dropdown.

  - `dash.callback_context.triggered_prop_ids` (available from Dash 2.4) returns a dictionary of inputs that triggered the callback. Each key is a `<component_id>.<component_property>` and the corresponding value is the `<component_id>`. In this example, we can see that the id of the component that triggered the callback was ` {'index': 0, 'type': 'filter-dropdown-ex3'}`and the property was `value`:
    ```
    {
      '{"index":0,"type":"filter-dropdown-ex3"}.value': {
          "index": 0,
          "type": "filter-dropdown-ex3",
      }
    }

    ```

  - `dash.callback_context.triggered`. Note that the `prop_id` is a stringified dictionary with no whitespace.
  - `dash.callback_context.inputs`. Note that the key is a stringified dictionary with no whitespace.
  - `dash.callback_context.inputs_list`. Each element of the list corresponds to
    one of the input declarations. If one of the input declarations matches a
    pattern then it will contain a list of values.
  - `dash.callback_context.outputs_list`

{{details `ALLSMALLER` Example Without Partial Updates

{{example simple_all_smaller_without_partial_updates}}

}}
## Todo App
Creating a Todo App is a classic UI exercise in that demonstrates many features in common "create, read, update and delete" (CRUD) applications.

> This example uses partial property updates and duplicate callback outputs, introduced in Dash 2.9. For an example that works with earlier versions of Dash, see Todo App Without Partial Updates below.

{{example todo}}

{{details Todo App Without Partial Updates

{{example todo_without_partial_updates}}

}}

