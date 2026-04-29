app %>% set_layout(
  dccGraph('graph1'),
  dccGraph('graph2'),
  dccGraph('graph3'),
  dccDropdown('dropdown'),
  dccStore('intermediate-value')
)

app %>% add_callback(
  output('intermediate-value', 'data'),
  input('dropdown', 'value'),
  function(value) {
    cleaned_df <- slow_processing_step(value)

    # a few filter steps that compute the data as it's needed in future callbacks
    df_1 <- subset(cleaned_df, fruit == 'apple')
    df_2 <- subset(cleaned_df, fruit == 'orange')
    df_3 <- subset(cleaned_df, fruit == 'fig')
    datasets <- list(df_1 = df_1, df_2 = df_2, df_3 = df_3)
    jsonlite::toJSON(datasets)
  }
)

app %>% add_callback(
  output('graph1', 'figure'),
  input('intermediate-value', 'data'),
  function(json_clean_data) {
    datasets <- jsonlite::fromJSON(json_clean_data)
    df <- datasets$df_1
    figure <- create_figure1(df)
    figure
  }
)

app %>% add_callback(
  output('graph1', 'figure'),
  input('intermediate-value', 'data'),
  function(json_clean_data) {
    datasets <- jsonlite::fromJSON(json_clean_data)
    df <- datasets$df_2
    figure <- create_figure2(df)
    figure
  }
)

app %>% add_callback(
  output('graph1', 'figure'),
  input('intermediate-value', 'data'),
  function(json_clean_data) {
    datasets <- jsonlite::fromJSON(json_clean_data)
    df <- datasets$df_3
    figure <- create_figure3(df)
    figure
  }
)
