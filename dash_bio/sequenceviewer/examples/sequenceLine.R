library(dashBio)

fasta_str = "MALWMRLLPLLALLALWGPDPAAAFVNQHLCGSHLVEALYLVCGERGFFYTPKTRREAED
LQVGQVELGGGPGAGSLQPLALEGSLQKRGIVEQCCTSICSLYQLENYCN"

dashbioSequenceViewer(
  id = "sequence-viewer-lines",
  sequence = fasta_str,
  showLineNumbers = FALSE,
  charsPerLine = 20
)