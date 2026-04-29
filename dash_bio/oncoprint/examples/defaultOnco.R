library(jsonlite)
library(dash)
library(dashHtmlComponents)
library(dashCoreComponents)
library(dashBio)

app <- Dash$new()

data = read_json("https://git.io/oncoprint_dataset3.json")

app$layout(htmlDiv(list(
    dashbioOncoPrint(
        data = data,
        id = "dashbio-default-oncoprint"
    ),
    htmlDiv(id = 'default-oncoprint-output')
)))

app$callback(
    output(id = "default-oncoprint-output", property = "children"),
    params = list(
        input(id = 'dashbio-default-oncoprint', property = "eventDatum")
    ),

    update_output <- function(event_data) {
        if (is.null(event_data)) {
            return("There is no event data. Hover over or click on a part of the graph to generate event data.")
        }

        else {
            return(htmlDiv(
                sprintf("Event Data: %s", event_data)
            ))
        }

    }
)

app$run_server()
