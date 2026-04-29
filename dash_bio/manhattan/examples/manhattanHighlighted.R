library(dashBio)

data = read.table("https://git.io/manhattan_data.csv",
                  header = TRUE, sep = ",")

dccGraph(
    figure = dashbioManhattan(
        dataframe = data,
        highlight_color = "#00FFAA"
    )
)
