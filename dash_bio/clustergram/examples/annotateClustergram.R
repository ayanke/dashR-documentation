library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBio)
library(heatmaply)
library(data.table)

df = read.table("https://git.io/clustergram_mtcars.tsv",
                        skip = 4, sep ="	",  row.names = 1, header = TRUE)

dccGraph(figure = heatmaply(
    df[, -c(8,9)],
    row_labels = list(row.names(data)),
    hide_labels = list("row"),
    column_labels = as.list(colnames(data)),
    color_threshold = list(
        "row" = 250,
        "col" = 700
    ),
    seriate = "mean",
    col_side_colors = c(rep(0,5), rep(1,4)),
    row_side_colors = df[,8:9],
))
