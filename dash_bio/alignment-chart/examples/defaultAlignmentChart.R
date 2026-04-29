library(dashBio)
library(readr)

app <- Dash$new()

data = read_file("https://git.io/alignment_viewer_p53.fasta")

app$layout(htmlDiv(list(
    dashbioAlignmentChart(
        id = "my-default-alignment-viewer",
        data = data
    ),
    htmlDiv(id = "default-alignment-viewer-output")
)))

app$callback(
    output(id = "default-alignment-viewer-output", property = "children"),
    params = list(
        input(id = "my-default-alignment-viewer", property = "eventDatum")
    ),
    update_output <- function(value) {
        if (!exists("value")) {
            return("No data.")
        }
        else {
            return(str(value))
        }
    }
)

app$run_server()
