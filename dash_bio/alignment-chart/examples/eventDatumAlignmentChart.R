library(manhattanly)
library(dashBio)
library(readr)
library(dash)
library(dashHtmlComponents)

app <- Dash$new()

data = read_file("https://git.io/alignment_viewer_p53.fasta")

app$layout(htmlDiv(list(
  dashbioAlignmentChart(
    id = "alignment-viewer-eventDatum-usage",
    data = data
  ),
  htmlP("Hover or click on data to see it in console."),
  htmlDiv(id = "alignment-viewer-eventDatum-usage-output")
)))

app$callback(
  output(id = "alignment-viewer-eventDatum-usage-output", property = "children"),
  params = list(
    input(id = "alignment-viewer-eventDatum-usage", property = "eventDatum")
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
