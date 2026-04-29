library(dash)
library(memoise)

app <- dash_app()

app %>% add_stylesheet(list(
  'https://codepen.io/chriddyp/pen/bWLwgP.css',
  'https://codepen.io/chriddyp/pen/brPBPO.css'
))

N <- 100
df <- data.frame(
  category = c(rep("apples", 5*N), rep("oranges", 10*N), rep("figs", 20*N), rep("pineapples", 15*N))
)
df$x <- rnorm(nrow(df))
df$y <- rnorm(nrow(df))

app %>% set_layout(
  dccDropdown('dropdown', lapply(unique(df$category), function(x) list(label=x, value=x)), "apples"),
  div(
    className = "row",
    div(dccGraph('graph-1'), className="six columns"),
    div(dccGraph('graph-2'), className="six columns")
  ),
  div(
    className = "row",
    div(dccGraph('graph-3'), className="six columns"),
    div(dccGraph('graph-4'), className="six columns")
  ),

  # signal value to trigger callbacks
  dccStore('signal')
)

# perform expensive computations in this "global store"
# these computations are cached in a globally available
# cache that's available across processes for all time.
global_store <- memoise(
  function(value) {
    print(paste('Computing value with', value))
    # simulate expensive query
    Sys.sleep(3)
    subset(df, category == value)
  }
)

generate_figure <- function(value, figure) {
  filtered_df <- global_store(value)
  figure$data[[1]]$x <- filtered_df$x
  figure$data[[1]]$y <- filtered_df$y
  figure$layout <- list(margin = list(l =  20, r = 10, b = 20, t = 10))
  figure
}

app %>% add_callback(
  output('signal', 'data'),
  input('dropdown', 'value'),
  function(value) {
    # compute value and send a signal when done
    global_store(value)
    value
  }
)

app %>% add_callback(
  output('graph-1', 'figure'),
  input('signal', 'data'),
  function(value) {
    data <- list(
      list(
        type = "scatter",
        mode = "markers",
        marker = list(
          opacity = 0.5,
          size = 14,
          line = list(border = "thin darkgrey solid")
        )
      )
    )
    # generate_figure gets data from `global_store`.
    # the data in `global_store` has already been computed
    # by the `compute_value` callback and the result is stored
    # in the global cache
    generate_figure(value, list(data = data))
  }
)

app %>% add_callback(
  output('graph-2', 'figure'),
  input('signal', 'data'),
  function(value) {
    data <- list(
      list(
        type = "scatter",
        mode = "lines",
        line = list(
          shape = "spline",
          width = 0.5
        )
      )
    )
    generate_figure(value, list(data = data))
  }
)

app %>% add_callback(
  output('graph-3', 'figure'),
  input('signal', 'data'),
  function(value) {
    data <- list(
      list(
        type = "histogram2d"
      )
    )
    generate_figure(value, list(data = data))
  }
)

app %>% add_callback(
  output('graph-4', 'figure'),
  input('signal', 'data'),
  function(value) {
    data <- list(
      list(
        type = "histogram2dcontour"
      )
    )
    generate_figure(value, list(data = data))
  }
)

app %>% run_app()
