library(dashBio)

data = read_json("https://git.io/oncoprint_dataset3.json")

dashbioOncoPrint(
    data = data,
    colorscale = list(
        "MISSENSE" = "#e763fa",
        "INFRAME"  = "#E763FA"
    ),
    backgroundcolor = "#F3F6FA"
)
