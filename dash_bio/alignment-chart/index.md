---
url: /dash-bio/alignmentchart
name: AlignmentChart
description:
    "Dash Bio is a component library
    dedicated to visualizing bioinformatics data."
languages:
  - python
  - julia
  - r
  - matlab
thumbnail: 'alignmentchart.png'
---
# ![](/assets/images/language_icons/r-lang_50px.svg) dash_bio.AlignmentChart Examples and Reference
see [AlignmentChart in action](https://dash-gallery.plotly.host/dash-alignment-chart).

## AlignmentChart

An example of a default AlignmentChart component without any extra properties

{{example defaultAlignmentChart}}

## Customization

### Color Scales
Change the colors used for the heatmap.

{{example colorscaleAlignmentChart}}

### Show/Hide Barplots
Enable or disable the secondary bar plots for gaps and conservation.

{{example hideBarPlots}}

### Tile Size
Change the height and/or width of the tiles.

{{example tileAlignmentChart}}

### Consensus Sequence
Toggle the display of the consensus sequence at the bottom of the heatmap.

{{example consensusAlignmentChart}}

## Event

### Event Datum
Show data on clicking or hovering the Alignment Chart.

{{example eventDatumAlignmentChart}}

{{reference dash_bio.AlignmentChart}}

## Example Data

- https://github.com/plotly/datasets/blob/master/Dash_Bio/Genetic/alignment_viewer_p53.fasta
- [UniProt - TP53 gene](https://www.uniprot.org/uniprot/?query=TP53&sort=score)
- [NCBI - TP53 gene](https://www.ncbi.nlm.nih.gov/HomoloGene/HGDownload.cgi?hid=49386)
