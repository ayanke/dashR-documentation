library(dashBio)

fasta_str = "MALWMRLLPLLALLALWGPDPAAAFVNQHLCGSHLVEALYLVCGERGFFYTPKTRREAED
LQVGQVELGGGPGAGSLQPLALEGSLQKRGIVEQCCTSICSLYQLENYCN"

dashbioSequenceViewer(
    id = "sequence-viewer-title",
    sequence = fasta_str,
    title = "Insulin",
    badge = FALSE
)