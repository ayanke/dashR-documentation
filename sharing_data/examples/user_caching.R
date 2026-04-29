library(dash)
library(memoise)

app <- dash_app()

app %>% add_stylesheet(list(
  'https://codepen.io/chriddyp/pen/bWLwgP.css',
  'https://codepen.io/chriddyp/pen/brPBPO.css'
))

app %>% set_layout(
  function() {
    session_id <- uuid::UUIDgenerate()

    div(
      dccStore(id = 'session-id', data = session_id),
      button('Get data', id = 'get-data-button'),
      div(id = 'output-1'),
      div(id = 'output-2')
    )
  }
)

get_dataframe <- function(session_id) {
  query_and_serialize_data <- memoise(
    cache = cachem::cache_disk("df_user_cache"),

    function(session_id) {
      # expensive session-specific data processing step goes here
      # simulate a session-unique data processing step by generating
      # data that is dependent on time
      now <- Sys.time()
      df <- data.frame(
        time = c(
          as.character(now - 15),
          as.character(now - 10),
          as.character(now - 5),
          as.character(now)
        ),
        values = c('a', 'b', 'a', 'c')
      )

      # simulate expensive query
      Sys.sleep(3)
      jsonlite::toJSON(df)
    }
  )

  jsonlite::fromJSON(query_and_serialize_data(session_id))
}

app %>% add_callback(
  output('output-1', 'children'),
  list(
    input('get-data-button', 'n_clicks'),
    input('session-id', 'data')
  ),
  function(value, session_id) {
    df <- get_dataframe(session_id)
    div(
      paste('Output 1 - Button has been clicked', value, 'times'),
      simple_table(df)
    )
  }
)

app %>% add_callback(
  output('output-2', 'children'),
  list(
    input('get-data-button', 'n_clicks'),
    input('session-id', 'data')
  ),
  function(value, session_id) {
    df <- get_dataframe(session_id)
    div(
      paste('Output 2 - Button has been clicked', value, 'times'),
      simple_table(df)
    )
  }
)

app %>% run_app()
