library(dashBio)

data <- importSpeck("https://git.io/speck_methane.xyz")

dashbioSpeck(
    data = data,
    view = list(
        "resolution" = 400,
        "ao" = 0.1,
        "outline" = 1,
        "atomScale" = 0.25,
        "relativeAtomScale" = 0.33,
        "bonds" = TRUE
    )
)
