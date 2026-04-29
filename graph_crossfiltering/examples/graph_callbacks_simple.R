library(dash)

app <- dash_app()
app %>% add_stylesheet('https://codepen.io/chriddyp/pen/bWLwgP.css')

pre_style <- list(
  border = 'thin lightgrey solid',
  overflowX = 'scroll'
)

figure_data <- list(
  list(
    x = c(1, 2),
    y = c(1, 2),
    name = 'apple',
    mode = 'markers',
    marker = list(size = 20)
  ),
  list(
    x = c(1, 2),
    y = c(3, 4),
    name = 'orange',
    mode = 'markers',
    marker = list(size = 20)
  )
)

app %>% set_layout(
  dccGraph(
    id = 'basic-interactions',
    figure = list(
      data = figure_data,
      layout = list(
        clickmode = 'event+select'
      )
    )
  ),

  div(
    className = 'row',

    div(
      dccMarkdown(
        "
          **Hover Data**
          Mouse over values in the graph.
          "
      ),
      html$pre(id = 'hover-data', style = pre_style),
      className = 'three columns'
    ),

    div(
      dccMarkdown(
        "
          **Click Data**
          Click on points in the graph.
          "
      ),
      html$pre(id = 'click-data', style = pre_style),
      className = 'three columns'
    ),

    div(
      dccMarkdown(
        "
          **Selection Data**
          Choose the lasso or rectangle tool in the graph's menu
          bar and then select points in the graph.
          Selection data also accumulates (or un-accumulates) selected
          data if you hold down the shift button while clicking.
          "
      ),
      html$pre(id = 'selected-data', style = pre_style),
      className = 'three columns'
    ),

    div(
      dccMarkdown(
        "
          **Zoom and Relayout Data**
          Click and drag on the graph to zoom or click on the zoom
          buttons in the graph's menu bar.
          Clicking on legend items will also fire
          this event.
          "
      ),
      html$pre(id = 'relayout-data', style = pre_style),
      className = 'three columns'
    )
  )
)

json_return <- function(data) {
  jsonlite::prettify(jsonlite::toJSON(data), indent = 2)
}

app %>% add_callback(
  output('hover-data', 'children'),
  input('basic-interactions', 'hoverData'),
  function(hoverData) {
    json_return(hoverData)
  }
)

app %>% add_callback(
  output('click-data', 'children'),
  input('basic-interactions', 'clickData'),
  function(clickData) {
    json_return(clickData)
  }
)

app %>% add_callback(
  output('selected-data', 'children'),
  input('basic-interactions', 'selectedData'),
  function(selectedData) {
    json_return(selectedData)
  }
)

app %>% add_callback(
  output('relayout-data', 'children'),
  input('basic-interactions', 'relayoutData'),
  function(relayoutData) {
    json_return(relayoutData)
  }
)

app %>% run_app()
