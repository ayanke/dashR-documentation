---
url: /datatable/width
name: DataTable Width & Column Width
description:
    "`dash_table.DataTable` is an interactive table that supports rich styling, 
    conditional formatting, editing, sorting, filtering, and more."
languages:
  - python
  - julia
  - r
  - matlab
---

# ![](/assets/images/language_icons/r-lang_50px.svg) DataTable Width & Column Width

#### Default Width

By default, the table will expand to the width of its container.
The width of the columns is determined automatically in order to
accommodate the content in the cells.

{{example example1}}

The default styles work well for a small number of columns and short
text. However, if you are rendering a large number of columns or
cells with long contents, then you'll need to employ one of the
following overflow strategies to keep the table within its container.

## Wrapping onto Multiple Lines

If your cells contain contain text with spaces, then you can overflow
your content into multiple lines.

`style_cell` updates the styling for the data cells & the header cells.
To specify header styles, use `style_header`.
To specify data cell styles, use `style_data`.

This example keeps the header on a single line while wrapping the data cells.

{{example multipleLines}}

### Denser Multi-Line Cells with Line-Height

If you are displaying lots of text in your cells, then you may want to
make the text appear a little more dense by shortening up the line-height.
By default (as above), it's around 22px. Here, it's 15px.

{{example multipleLinesDenserCellsLineHeight}}

### Wrapping onto Multiple Lines while Constraining the Height of Cells

If your text is really long, then you can constrain the height of the
cells and display a tooltip when hovering over the cell.

{{example wrappingMultiLinesConstrainingHeightCells}}

Hover over the cells to see the tooltip.

Why the `css`? Fixed height cells are tricky because, [by CSS 2.1 rules](https://www.w3.org/TR/CSS21/tables.html#height-layout),
the height of a table cell is "the minimum height required by the content".
So, here we are setting the height of the cell indirectly
by setting the div _within_ the cell.

In this example, we display two lines of data by setting the `line-height`
to be 15px and the height of each cell to be 30px.
The second sentence is cut off.

There are a few **limitations** with this method:

1. It is not possible to display ellipses with this method.
2. It is not possible to set a max-height. All of the cells need to be
the same height.

Subscribe to [plotly/dash-table#737](https://github.com/plotly/dash-table/issues/737) for updates or other workarounds
on this issue.

## Overflowing Into Ellipses

Alternatively, you can keep the content on a single line but display
a set of ellipses if the content is too long to fit into the cell.

Here, `max-width` is set to 0. It could be any number, the only
important thing is that it is supplied. The behaviour will be
the same whether it is 0 or 50.

If you want to just hide the content instead of displaying ellipses,
then set `textOverflow` to `'clip'` instead of `'ellipsis'`.

{{example overflowEllipses}}

> In the example above, ellipsis are not displayed for the header.
> We consider this a bug, subscribe to [plotly/dash-table#735](https://github.com/plotly/dash-table/issues/735) for updates.

### Ellipses & Tooltips

If you are display text data that is cut off by ellipses, then you can
include tooltips so that the full text appears on hover.

By setting `tooltip_duration` to `None`, the tooltip will persist
as long as the mouse pointer is above the cell, and it will disappear
when the pointer moves away. You can override this by passing in
a number in milliseconds (e.g. 2000 if you want it to disappear after
two seconds).

{{example ellipsesTooltips}}

## Horizontal Scroll

Instead of trying to fit all of the content in the container, you could
overflow the entire container into a scrollable container.

{{example horizontalScroll1}}

Note how we haven't explicitly set the width of the individual columns
yet. The widths of the columns have been computed dynamically depending
on the width of the table and the width of the cell's contents.
In the example above, by providing a scrollbar, we're effectively
giving the table as much width as it needs in order to fit the entire
width of the cell contents on a single line.

### Horizontal Scroll with Fixed-Width Columns & Cell Wrapping

Alternatively, you can fix the width of each column by adding `width`.
In this case, the column's width will be constant, even if its contents
are shorter or wider.

{{example horizontalScroll2}}

### Horizontal Scroll with Fixed-Width & Ellipses

{{example horizontalScroll3}}

### Horizontal Scrolling via Fixed Columns

You can also add a horizontal scrollbar to your table by fixing
the leftmost columns with `fixed_columns`.

{{example horizontalScroll4}}

Here is the same example but with *fixed-width cells & ellipses*.

{{example horizontalScroll5}}

## Setting Column Widths

### Percentage Based Widths

The widths of individual columns can be supplied through the
`style_cell_conditional` property. These widths can be specified as
percentages or fixed pixels.

{{example individualColumnWidths}}

{{example individualColumnWidths1}}

By default, the column width is the maximum of the percentage given
and the width of the content. So, if the content in the column is wide,
the column may be wider than the percentage given. This prevents overflow.

In the example below, note the first column is actually wider than 10%;
if it were shorter, the text "New York City" would overflow.

{{example individualColumnWidths2}}

To force columns to be a certain width (even if that causes overflow)
use `table-layout: fixed`.

### Percentage Based Widths and `table-layout: fixed`
If you want all columns to have the same percentage-based width,
use `style_data` and `table-layout: fixed`.

{{example percentageBasedWidthsTableLayoutFixed}}

Setting consistent percentage-based widths is a good option if you are using
`virtualization`, sorting (`sort_action`), or `filtering` (`filter_action`).
Without fixed column widths, the table will dynamically resize the
columns depending on the width of the data that is displayed.

**Limitations**

1. Percentage-based widths is not available with `fixed_rows` & `table-layout: fixed`.
See [plotly/dash-table#745](https://github.com/plotly/dash-table/issues/748)
2. Percentage-based widths with `fixed_rows` and without `table-layout: fixed`
has some issues when resizing the window. See [plotly/dash-table#747](https://github.com/plotly/dash-table/issues/747)

### Individual Column Widths with Pixels

In this example, we set three columns to have fixed-widths. The remaining
two columns will be take up the remaining space.

{{example individualColumnWidthPixels}}

### Overriding a Single Column's Width

You can set the width of all of the columns with `style_data` and
override a single column with `style_cell_conditional`.

{{example overridingSingleColumnWidth}}