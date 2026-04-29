library(dashBio)
library(readr)
library(jsonlite)

app <- Dash$new()

data <- "https://git.io/circos_graph_data.json"

circos_graph_data = read_json(data)

app$layout(htmlDiv(list(
    dashbioCircos(
        id = "my-default-circos-example",
        layout = circos_graph_data[["GRCh37"]],
        selectEvent = list("0" = "hover", "1" = "click", "2" = "both"),
        tracks = list(list(
            "type" = "CHORDS",
            "data" = circos_graph_data[["chords"]],
            "opacity" = 0.7,
            "color" = list("name" = "color"),
            "config" = list(
                "tooltipContent" = list(
                "source" = "source",
                "sourceID" = "id",
                "target" = "target",
                "targetID" = "id",
                "targetEnd" = "end"
                )
            )
        ))
    ),
    "Graph type: ",
    dccDropdown(
        id = 'histogram-chords-default-circos',
        options = list(
            list("label" = "histogram", "value" = "histogram"),
            list("label" = "chords", "value" = "chords")
        ),
        value = "chords"
    ),
    "Event data:",
    htmlDiv(id='default-circos-output')
)))

app$callback(
    output(id = "default-circos-output", property = "children"),
    params = list(
        input(id = 'my-default-circos-example', property = "eventDatum")
    ),
    update_output <- function(value) {
        if (!is.null(value)) {
            return (htmlDiv(sprintf("Data from graph: %s", value)))
        }
    }
)

app$callback(
    output(id = "my-default-circos-example", property = "tracks"),
    params = list(
        input(id = 'histogram-chords-default-circos', property = "value")
    ),
    choose_graph <- function(value) {
        if (value == 'chords') {
            tracks = list(list(
                'type' = 'CHORDS',
                'data' = circos_graph_data[['chords']],
                'config' = list(
                    'tooltipContent' = list(
                        'source' = 'source',
                        'sourceID' = 'id',
                        'target' = 'target',
                        'targetID' = 'id',
                        'targetEnd' = 'end'
                    )
                )
            ))

        }
        else if (value == 'histogram') {
            tracks = list(list(
                'type' = 'HISTOGRAM',
                'data' = circos_graph_data[['histogram']],
                'config' = list(
                    'tooltipContent' = list(
                        'source' = 'source',
                        'sourceID' = 'id',
                        'target' = 'target',
                        'targetID' = 'id',
                        'targetEnd' = 'end'
                    )
                )
            ))
        }
    return(tracks)
    }
)

app$run_server()
