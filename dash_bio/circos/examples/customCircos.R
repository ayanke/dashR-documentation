library(dashBio)
library(readr)
library(jsonlite)

data <- "https://git.io/circos_graph_data.json"

circos_graph_data = read_json(data)

dashbioCircos(
    id = "circos_radii_example",
    layout = circos_graph_data[["GRCh37"]],
    tracks = list(list(
        "type" = "CHORDS",
        "data" = circos_graph_data[["chords"]]
    )),
    config = list(
        "innerRadius" = 40,
        "outerRadius" = 200
    )
)
