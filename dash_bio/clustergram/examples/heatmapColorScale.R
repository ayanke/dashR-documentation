library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBio)
library(heatmaply)
library(data.table)

df = read.table("https://git.io/clustergram_mtcars.tsv",
                        skip = 4, sep ="	",  row.names = 1, header = TRUE)

dccGraph(figure = heatmaply(
    df,
    row_labels = list(row.names(data)),
    hide_labels = list("row"),
    column_labels = as.list(colnames(data)),
    color_threshold = list(
        "row" = 150,
        "col" = 700
    ),
    colors = BrBG,
    limits = c(0, 500),
    midpoint = 200
))
