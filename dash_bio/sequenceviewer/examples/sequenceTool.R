library(dashBio)

fasta_str = "MALWMRLLPLLALLALWGPDPAAAFVNQHLCGSHLVEALYLVCGERGFFYTPKTRREAED
LQVGQVELGGGPGAGSLQPLALEGSLQKRGIVEQCCTSICSLYQLENYCN"

dashbioSequenceViewer(
    id = "sequence-viewer-toolbar",
    sequence = fasta_str,
    toolbar = TRUE
)