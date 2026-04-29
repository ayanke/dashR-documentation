---
url: /dash-core-components/dropdown
name: Dropdown
description:
    "The dcc.Dropdown component creates a customizable dropdown menu for selecting one or multiple items from a list of options."
languages:
    - python
    - r
    - julia
    - fsharp
    - matlab
---
# ![](/assets/images/language_icons/r-lang_50px.svg) dcc.Dropdown

`dcc.Dropdown` is a component that creates a customizable dropdown menu for selecting one or multiple items from a list of options.

## Examples

Find a few usage examples below.



### Basic Dropdown

` in that order.||else
An example of a basic dropdown without any extra properties.}}

{{example dropdown}}

{{oss {{dash-club}} }}

`. There are multiple ways to set `options`. The following examples define the same dropdown:

```python
dcc.Dropdown(['New York City', 'Montreal', 'San Francisco'], 'Montreal')
```

```python
dcc.Dropdown(
   options=['New York City', 'Montreal', 'San Francisco'],
   value='Montreal'
)
```

```python
dcc.Dropdown(
   options=[
       {'label': 'New York City', 'value': 'New York City'},
       {'label': 'Montreal', 'value': 'Montreal'},
       {'label': 'San Francisco', 'value': 'San Francisco'},
   ],
   value='Montreal'
)
```

```python
dcc.Dropdown(
   options={
        'New York City': 'New York City',
        'Montreal': 'Montreal',
        'San Francisco': 'San Francisco'
   },
   value='Montreal'
)
```

In these examples, the option's label (what the user sees) and the value (what's passed into the callback) are equivalent. Often it is helpful for these to be separate so that you can easily change the label without changing the callback logic that uses the value:

```
dcc.Dropdown(
   options={
        'NYC': 'New York City',
        'MTL': 'Montreal',
        'SF': 'San Francisco'
   },
   value='MTL'
)
```
Options provided as a single dictionary render in no particular order in the browser.
Providing a list that contains a dictionary for each option ensures the options render in the order provided.

```
dcc.Dropdown(
   options=[
       {'label': 'New York City', 'value': 'NYC'},
       {'label': 'Montreal', 'value': 'MTL'},
       {'label': 'San Francisco', 'value': 'SF'},
   ],
   value='MTL'
)
```

> Note: Versions of Dash before 2.1 only support keyword arguments for `options` and `value`, and also `options` must be provided as a list of dictionaries.
<!--- --->
}}

### Multi-Value Dropdown

A dropdown component with the `multi` property set to `True`
will allow the user to select more than one value
at a time.

{{example dropdown_multi_value}}

### Disable Search

The `searchable` property is set to `True` by default on all
`dcc.Dropdown` components. To prevent searching the dropdown
value, just set the `searchable` property to `False`.
Try searching for 'New York' on this dropdown below and compare
it to the other dropdowns on the page to see the difference.

{{example dropdown_disable_search}}

### Dropdown Clear

The `clearable` property is set to `True` by default on all
`dcc.Dropdown` components. To prevent the clearing of the selected dropdown
value, just set the `clearable` property to `False`

{{example dropdown_clearable}}

### Placeholder Text

The `placeholder` property allows you to define
default text shown when no value is selected.

{{example dropdown_placeholder}}

### Disable Dropdown

To disable the dropdown just set `disabled` to `True`.

{{example dropdown_disable}}

### Disable Options

To disable a particular option inside the dropdown
menu, set the `disabled` property in the options.

{{example dropdown_disable_options}}

### Dynamic Options

This is an example on how to update the options on the server
depending on the search terms the user types. For example purpose
the options are empty on first load, as soon as you start typing
they will be loaded with the corresponding values.

{{example dropdown_dynamic_options}}



### Components as Option Labels

> This feature is available in Dash 2.5 and later.

In previous examples, we've set option labels as strings. You can also use Dash components as option labels.
In this example, each label is an `html.Span` component with an `html.Img` component and some text inside.

{{example dropdown_components_as_props}}

### Styling Components as Option Labels

> This feature is available in Dash 2.5 and later.

You can also style labels by using an `html.Span` component for each label and then setting styles using the `style` property:

{{example dropdown_components_as_props_style}}

### Custom Search Values

When you use components as option labels, the dropdown's search uses the option values by default.
You can add an extra string for the search by setting an option's `search` property.
Here we set a search value for each option to match that option's label text.

The value provided to `search` is in addition to option `value`. For example, option 2 is displayed when a user searches
for either 'NYC' or 'New York City'.

{{example custom_search}}

### Dropdown Height

The height of an expanded dropdown is 200px by default. Options that fit within this height are visible on screen,
while the remaining options can be accessed using the dropdown's vertical scrollbar.
You can change the height with `maxHeight` if you want more or fewer options to be visible when the dropdown is expanded.
In this example, we set it to 300px.

{{example dropdown_height}}

### Option Height

You can change the height of options in the dropdown by setting `optionHeight`. In this example, we set it to 50px.
The default is 35px.

{{example dropdown_option_height}}

------------------------


{{reference dcc.Dropdown}}
