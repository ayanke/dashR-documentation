library(dashBio)

model_data <- read_json("https://git.io/mol2d_buckminsterfullerene.json")

dashbioMolecule2dViewer(
    modelData = model_data,
    selectedAtomIds = list(seq(1:10))
)
