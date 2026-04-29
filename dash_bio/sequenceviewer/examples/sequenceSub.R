library(dashBio)

fasta_str = "MALWMRLLPLLALLALWGPDPAAAFVNQHLCGSHLVEALYLVCGERGFFYTPKTRREAED
LQVGQVELGGGPGAGSLQPLALEGSLQKRGIVEQCCTSICSLYQLENYCN"


dashbioSequenceViewer(
    id = "sequence-viewer-subsequence",
    sequence = fasta_str,
    selection = list(10, 20, "green")
)