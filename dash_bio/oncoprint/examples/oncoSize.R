library(dashBio)

data = read_json("https://git.io/oncoprint_dataset3.json")

dashbioOncoPrint(
    data = data,
    height = 800,
    width = 500,
    padding = 0.25
)
