library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBio)
library(heatmaply)
library(data.table)

df = read.table("https://git.io/clustergram_mtcars.tsv",
                        skip = 4, sep ="	",  row.names = 1, header = TRUE)

# The following is a color palette.

rc <- colorspace::rainbow_hcl(nrow(df))

dccGraph(figure = heatmaply(
    df,
    row_labels = list(row.names(data)),
    hide_labels = list("row"),
    column_labels = as.list(colnames(data)),
    color_threshold = list(
        "row" = 250,
        "col" = 700
    ),
    seriate = "mean",
    RowSideColors = rc,
    k_col = 2,
    k_row = 2
))
