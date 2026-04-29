library(dash)

df <- data.frame(
  student_id = 1:10,
  score = c(1, 5, 2, 5, 2, 3, 1, 5, 1, 5)
)

dash_app() %>%
  set_layout(
    dccDropdown('num', lapply(1:5, function(x) list(label = x, value = x)), 1),
    "was scored by this many students:",
    div(id = 'output')
  ) %>%
  add_callback(
    output('output', 'children'),
    input('num', 'value'),
    function(value) {
      df <<- subset(df, score == value)
      nrow(df)
    }
  ) %>%
  run_app()
