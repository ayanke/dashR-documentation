library(dashBio)

data = read_json("https://git.io/needle_PIK3CA.json")

dashbioNeedlePlot(
    mutationData = data,
    domainStyle = list(
        "displayMinorDomains" = TRUE,
        "domainColor" = list("#FFDD00", "#00FFDD", "#0F0F0F", "#D3D3D3")
    )
)
