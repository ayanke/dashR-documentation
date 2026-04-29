library(dashBio)

data = read_json("https://git.io/oncoprint_dataset3.json")

dashbioOncoPrint(
    data=data,
    showlegend = FALSE,
    showoverview = FALSE
)
