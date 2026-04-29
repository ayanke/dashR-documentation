library(dashBio)

data = read_json("https://git.io/needle_PIK3CA.json")

dashbioNeedlePlot(
    mutationData = data,
    needleStyle = list(
        "stemColor" = "#FF8888",
        "stemThickness" = 2,
        "stemConstHeight" = TRUE,
        "headSize" = 10,
        "headColor" = list("#FFDD00", "#000000")
    )
)
