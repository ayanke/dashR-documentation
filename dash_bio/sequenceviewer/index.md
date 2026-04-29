---
url: /dash-bio/sequenceviewer
name: SequenceViewer
description:
    "Dash Bio is a component library
    dedicated to visualizing bioinformatics data."
icon_path: images/icons_v2/www (1).svg
languages:
  - python
  - julia
  - r
  - matlab
thumbnail: 'sequenceviewer.png'
---
# ![](/assets/images/language_icons/r-lang_50px.svg) dash_bio.SequenceViewer Examples and Reference
see [SequenceViewer in action](https://dash-gallery.plotly.host/dash-sequence-viewer).

## SequenceViewer

An example of a default SequenceViewer component without any extra properties.

{{example defaultSequenceViewer}}

## Customization

### Line Length And Line Numbers
Change the characters per line, and toggle the display of line numbers.

{{example sequenceLine}}

### Subsequence Selection
Highlight a part of the sequence with a defined color.

{{example sequenceSub}}

### Toolbar
Display a toolbar to change the line length from the component itself.

{{example sequenceTool}}

### Title And Badge
Show a title or a badge with the nucleotide or amino acid count of the protein.

{{example sequenceTitle}}

{{reference dash_bio.SequenceViewer}}

## Example Data

- https://github.com/plotly/datasets/blob/master/Dash_Bio/Genetic/sequence_viewer_P01308.fasta
- [Severe acute respiratory syndrome coronavirus 2 isolate Wuhan-Hu-1, complete genome](https://www.ncbi.nlm.nih.gov/nuccore/NC_045512.2?report=fasta)
- [Human Genome Resources at NCBI](https://www.ncbi.nlm.nih.gov/projects/genome/guide/human/index.shtml)
