library(dashBio)

data = read.table("https://git.io/manhattan_data.csv",
                  header = TRUE, sep = ",")

dccGraph(
    figure = dashbioManhattan(
        dataframe = data,
        suggestiveline_color = "#AA00AA",
        genomewideline_color = "#AA5500"
    )
)
