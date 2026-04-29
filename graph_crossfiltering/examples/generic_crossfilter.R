library(dash)

app <- dash_app()
app %>% add_stylesheet('https://codepen.io/chriddyp/pen/bWLwgP.css')

df <- as.data.frame(matrix(rnorm(180, seq(0, 50, 10), 0.1), ncol=6, byrow = TRUE))
colnames(df) <- paste("Column", 1:6)

app %>% set_layout(
  div(
    div(
      dccGraph(
        id = 'graph1',
        config = list(displayModeBar = FALSE)
      ),
      className = 'four columns'
    ),
    div(
      dccGraph(
        id = 'graph2',
        config = list(displayModeBar = FALSE)
      ),
      className='four columns'
    ),
    div(
      dccGraph(
        id = 'graph3',
        config = list(displayModeBar = FALSE)
      ),
      className = 'four columns'
    ),
    className = 'row'
  )
)

callback <- function(g1, g2, g3, x, y){
  selectedDatas = na.omit(c(g1, g2, g3))
  selectedpoints = as.numeric(rownames(df))
  selected_index =  lapply(1:length(selectedDatas[['points']]),
                           function(i) {selectedDatas[['points']][[i]][['customdata']]
                           })
  if(length(selected_index) > 0){
    selectedpoints = intersect(selectedpoints, selected_index)
  }

  data = list(
    x = df[[x]],
    y = df[[y]],
    text = as.numeric(rownames(df)),
    textposition = 'top',
    selectedpoints = unlist(lapply(selectedpoints, function(x){x-1})),
    customdata = as.numeric(rownames(df)),
    type = 'scatter',
    mode = 'markers+text',
    marker = list(
      color = 'rgb(0, 116, 217, 0.7)',
      size = 12,
      line = list(
        color = 'rgb(0, 116, 217)',
        width = 0.5
      )
    ),
    textfont = list(
      color = 'rgb(30, 30, 30, 1)'
    ),
    unselected = list(
      marker =list(
        opacity = 0.3
      ),
      textfont = list(
        # make text transparent when not selected
        color = 'rgb(0, 0, 0, 0)'
      )
    )
  )
  layout = list(
    clickmode = 'event+select',
    margin = list('l' = 15, 'r' = 0, 'b' = 15, 't' = 5),
    dragmode = 'select',
    hovermode = 'closest',
    xaxis = list(range = list(min(df[x]),max(df[x]))),
    yaxis = list(range = list(min(df[y]),max(df[y]))),
    showlegend = FALSE
  )
  figure = list(
    data = list(data
    ),
    layout = layout
  )
  shape = list(
    type = 'rect',
    line = list(
      width = 1,
      dash = 'dot',
      color = 'darkgrey'
    )
  )
  if(is.null(selectedDatas[['range']]) == FALSE){
    figure[['layout']]['shapes'] = list(list(list(
      'x0' = unlist(selectedDatas[['range']][['x']][1]),
      'x1' = unlist(selectedDatas[['range']][['x']][2]),
      'y0' = unlist(selectedDatas[['range']][['y']][1]),
      'y1' = unlist(selectedDatas[['range']][['y']][2]),shape)))
  }
  else{
    figure[['layout']]['shapes'] = list(list(list(
      'type' = 'rect',
      'x0' = min(df[x], na.rm = TRUE),
      'x1' = max(df[x], na.rm = TRUE),
      'y0' = min(df[y], na.rm = TRUE),
      'y1' = max(df[y], na.rm = TRUE),shape)))
  }
  return(figure)
}

app %>% add_callback(
  output('graph1', 'figure'),
  list(
    input('graph1', 'selectedData'),
    input('graph2', 'selectedData'),
    input('graph3', 'selectedData')
  ),
  function(g1, g2, g3){
    callback(g1, g2, g3, 'Column 1', 'Column 2')
  }
)

app %>% add_callback(
  output('graph2', 'figure'),
  list(
    input('graph2', 'selectedData'),
    input('graph1', 'selectedData'),
    input('graph3', 'selectedData')
  ),
  function(g2, g1, g3){
    callback(g2, g1, g3, 'Column 3', 'Column 4')
  }
)

app %>% add_callback(
  output('graph3', 'figure'),
  list(
    input('graph3', 'selectedData'),
    input('graph1', 'selectedData'),
    input('graph2', 'selectedData')
  ),
  function(g3, g1, g2){
    callback(g3, g1, g2, 'Column 5', 'Column 6')
  }
)

app %>% run_app()
