library(dashBio)

model_data <- read_json("https://git.io/mol2d_buckminsterfullerene.json")

for (node in model_data$nodes) {
    node$atom <- "N"
}

for (link in model_data$links) {
    link$distance <- 50.0
    link$strength <- 0.5
}

dashbioMolecule2dViewer(
    modelData = model_data,
    selectedAtomIds = list(seq(1:10))
)
