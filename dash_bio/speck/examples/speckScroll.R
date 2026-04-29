library(dashBio)

data <- importSpeck("https://git.io/speck_methane.xyz")

dashbioSpeck(
    data = data,
    scrollZoom  = TRUE
)
