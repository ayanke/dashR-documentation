app %>% set_layout(
  dccGraph('graph'),
  html$table(id = 'table'),
  dccDropdown('dropdown'),

  # dccStore stores the intermediate value
  dccStore('intermediate-value')
)

app %>% add_callback(
  output('intermediate-value', 'data'),
  input('dropdown', 'value'),
  function(value) {
    # some expensive data processing step
    cleaned_df <- slow_processing_step(value)
    # Note that the data must be stored as a JSON string
    jsonlite::toJSON(cleaned_df)
  }
)

app %>% add_callback(
  output('graph', 'figure'),
  input('intermediate-value', 'data'),
  function(json_clean_data) {
    df <- jsonlite::fromJSON(json_clean_data)
    figure <- create_figure(df)
    figure
  }
)

app %>% add_callback(
  output('table', 'children'),
  input('intermediate-value', 'data'),
  function(json_clean_data) {
    df <- jsonlite::fromJSON(json_clean_data)
    table <- create_table(df)
    table
  }
)
