library(dash)

df <- read.csv('https://plotly.github.io/datasets/country_indicators.csv', header = TRUE, sep = ",")
available_indicators <- unique(df$Indicator.Name)
option_indicator <- lapply(available_indicators, function(x) list(label = x, value = x))

app <- dash_app()
app %>% add_stylesheet('https://codepen.io/chriddyp/pen/bWLwgP.css')

app %>% set_layout(
  div(
    style = list(
      borderBottom = 'thin lightgrey solid',
      backgroundColor = 'rgb(250, 250, 250)',
      padding = '10px 5px'
    ),

    div(
      dccDropdown(
        id = 'crossfilter-xaxis-column',
        options = option_indicator,
        value = 'Fertility rate, total (births per woman)'
      ),
      dccRadioItems(
        id = 'crossfilter-xaxis-type',
        options = list(list(label = 'Linear', value = 'linear'),
                       list(label = 'Log', value = 'log')),
        value = 'linear',
        labelStyle = list(display = 'inline-block')
      ),
      style = list(width = '49%', display = 'inline-block')
    ),

    div(
      dccDropdown(
        id = 'crossfilter-yaxis-column',
        options = option_indicator,
        value = 'Life expectancy at birth, total (years)'
      ),
      dccRadioItems(
        id = 'crossfilter-yaxis-type',
        options = list(list(label = 'Linear', value = 'linear'),
                       list(label = 'Log', value = 'log')),
        value = 'linear',
        labelStyle = list(display = 'inline-block')
      ),
      style = list(width = '49%', flaot = 'display', display = 'inline-block')
    ),

    div(
      dccGraph(
        id = 'crossfilter-indicator-scatter',
        hoverData = list(points = list(list(customdata = 'Japan')))
      ),
      style = list(
        width ='49%',
        display = 'inline-block',
        padding = '0 20'
      )
    ),

    div(
      dccGraph(id='x-time-series'),
      dccGraph(id='y-time-series'),
      style = list(display = 'inline-block', width = '49%')
    ),

    div(
      dccSlider(
        id = 'crossfilter-year--slider',
        min = 0,
        max = length(unique(df$Year))-1,
        marks = unique(df$Year),
        value = length(unique(df$Year))-1
      ),
      style = list(width = '49%', padding = '0px 20px 20px 20px')
    )
  )
)

app %>% add_callback(
  output('crossfilter-indicator-scatter', 'figure'),
  list(
    input('crossfilter-xaxis-column', 'value'),
    input('crossfilter-yaxis-column', 'value'),
    input('crossfilter-xaxis-type', 'value'),
    input('crossfilter-yaxis-type', 'value'),
    input('crossfilter-year--slider', 'value')
  ),
  function(xaxis_column_name, yaxis_column_name, xaxis_type, yaxis_type, year_value) {
    selected_year <- unique(df$Year)[year_value]
    traces <- list()

    if (selected_year %in% unique(df$Year)) {
      filtered_df <- df[df[["Year"]] %in% selected_year, ]
      traces[[1]] <- list(
        x = filtered_df[filtered_df$Indicator.Name %in% xaxis_column_name, "Value"],
        y = filtered_df[filtered_df$Indicator.Name %in% yaxis_column_name, "Value"],
        opacity=0.7,
        text = filtered_df[filtered_df$Indicator.Name %in% yaxis_column_name, "Country.Name"],
        customdata = filtered_df[filtered_df$Indicator.Name %in% yaxis_column_name, "Country.Name"],
        mode = 'markers',
        marker = list(
          'size'= 15,
          'opacity' = 0.5,
          'line' = list('width' = 0.5, 'color' = 'white')
        )
      )

      list(
        'data' = traces,
        'layout'= list(
          xaxis = list('title' = xaxis_column_name, 'type' = xaxis_type),
          yaxis = list('title' = yaxis_column_name, 'type' = yaxis_type),
          margin = list('l' = 40, 'b' = 30, 't' = 10, 'r' = 0),
          height = 450,
          hovermode = 'closest'
        )
      )
    }
  }
)

create_time_series <- function(dff, axis_type, title) {
  list(
    'data' = list(list(
      x = dff[['Year']],
      y = dff[['Value']],
      mode = 'lines+markers'
    )),
    'layout' = list(
      height = 225,
      margin = list('l' = 20, 'b' = 30, 'r' = 10, 't' = 10),
      'annotations' = list(list(
        x = 0, 'y' = 0.85, xanchor = 'left', yanchor = 'bottom',
        xref = 'paper', yref = 'paper', showarrow = FALSE,
        align = 'left', bgcolor = 'rgba(255, 255, 255, 0.5)',
        text = title[1]
      )),
      yaxis = list(type = axis_type),
      xaxis = list(showgrid = FALSE)
    )
  )
}

app %>% add_callback(
  output('x-time-series', 'figure'),
  list(
    input('crossfilter-indicator-scatter', 'hoverData'),
    input('crossfilter-xaxis-column', 'value'),
    input('crossfilter-xaxis-type', 'value')
  ),
  function(hoverData, xaxis_column_name, axis_type) {
    Country.Name <- hoverData$points[[1]]$customdata
    dff <- df[df[["Country.Name"]] %in% Country.Name, ]
    dff <- dff[dff[["Indicator.Name"]] %in% xaxis_column_name, ]
    title <- paste(c(Country.Name, xaxis_column_name), sep = '<br>')
    create_time_series(dff, axis_type, title)
  }
)

app %>% add_callback(
  output('y-time-series', 'figure'),
  list(
    input('crossfilter-indicator-scatter', 'hoverData'),
    input('crossfilter-yaxis-column', 'value'),
    input('crossfilter-yaxis-type', 'value')
  ),
  function(hoverData, yaxis_column_name, axis_type) {
    dff <- df[df[["Country.Name"]] %in% hoverData$points[[1]]$customdata, ]
    dff <- dff[dff[["Indicator.Name"]] %in% yaxis_column_name, ]
    create_time_series(dff, axis_type, yaxis_column_name)
  }
)

app %>% run_app()
