---
url: /dash-core-components/datepickerrange
name: DatePickerRange
description:
    "The dcc.DatePickerRange component helps users select a range between two dates in a calendar."
languages:
    - python
    - r
    - julia
    - fsharp
---

# ![](/assets/images/language_icons/r-lang_50px.svg) dcc.DatePickerRange

`dcc.DatePickerRange` is a component for rendering calendars from which users can select a range of dates.

. `{{component dcc.DatePickerRange` accepts dates with a time part, but this can be confusing, particularly for the initial call of a callback. After the user chooses a new date, there will be no time part&mdash;only the date. If you already have a }} object, you can convert it with 

## Month and Display Format

The  property determines how calendar headers are displayed when the calendar is opened.
The  property determines how selected dates are displayed in the `dcc.DatePickerRange` component.

Both of these properties are configured through strings that use a combination of any of the following tokens.

| String Token | Example        | Description                                              |
|--------------|----------------|----------------------------------------------------------|
|` YYYY`       | `2014`           | 4 or 2 digit year                                      |
| `YY`         | `14`             | 2 digit year                                           |
| `Y`          | `-25`            | Year with any number of digits and sign                |
| `Q`          | `1..4`           | Quarter of year. Sets month to first month in quarter. |
| `M MM`       | `1..12`          | Month number                                           |
| `MMM MMMM`   | J`an..December`  | Month name                                             |
| `D DD`       | `1..31`          | Day of month                                           |
| `Do`         | `1st..31st`      | Day of month with ordinal                              |
| DDD DDDD     | `1..365`         | Day of year                                            |
| `X`          | `1410715640.579` | Unix timestamp                                         |
| `x`          | `1410715640579`  | Unix ms timestamp                                      |

## Examples

Find a few usage examples below.



### Simple DatePickerRange Example

This is a simple example of a `dcc.DatePickerRange` component tied to a callback.

The  properties define the minimum and maximum selectable dates on the calendar while  defines the calendar month that is first displayed when the `dcc.DatePickerRange` component is opened.

{{example simple_datepickerrange}}

### Month Format Examples

You can set  to any permutation of the string tokens shown in **Month and Display Format** above to change how calendar titles are displayed in the `dcc.DatePickerRange` component.

{{example datepickerrange_MMM_format_month}}
{{example datepickerrange_MDYQ_format_month}}
{{example datepickerrange_MMMMYDD_format_month}}
{{example datepickerrange_x_format_month}}

### Display Format Examples

You can use any permutation of the string tokens shown in **Month and Display Format** above to change how selected dates are displayed in the `dcc.DatePickerRange` component.

{{example datepickerrange_MMM_format}}
{{example datepickerrange_MDYQ_format}}
{{example datepickerrange_MMMMYDD_format}}
{{example datepickerrange_x_format}}

### Vertical Calendar and Placeholder Text

The `dcc.DatePickerRange` component can be rendered in two orientations, either horizontally or vertically. If  is set to , it will be rendered vertically and will default to  if not defined.

 define the grey default text defined in the calendar input boxes when no date is selected.

{{example datepickerrange_vertical}}

### Minimum Nights, Calendar Clear, and Portals

The  property defines the number of nights that must be in between the range of two selected dates.

When the `clearable` property is set to , the `dcc.DatePickerRange` renders with a small 'x' that the user can select to remove selected dates.

The `dcc.DatePickerRange` component supports two different portal types, one being a full screen portal () and another being a simple screen overlay, like the one shown below ().

{{example datepickerrange_clearable}}

### Right to Left Calendars and First Day of Week
When the  property is set to  the calendar will be rendered from right to left.

The  property allows you to define which day of the week will be set as the first day of the week. In the example below, Tuesday is the first day of the week.

{{example datepickerrange_rtl}}

------------------------

{{reference dcc.DatePickerRange}}
