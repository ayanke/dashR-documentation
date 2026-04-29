---
url: /dash-bio/clustergram
name: Clustergram
description:
    "Dash Bio is a component library
    dedicated to visualizing bioinformatics data."
icon_path: images/icons_v2/www (1).svg
languages:
  - python
  - r
  - matlab
thumbnail: 'clustergram.png'
---
# ![](/assets/images/language_icons/r-lang_50px.svg) dash_bio.Clustergram Examples and Reference
see [Clustergram in action](https://dash-gallery.plotly.host/dash-clustergram).

## Clustergram

An example of a default Clustergram component without any extra properties.

{{example defaultClustergram}}

## Customization

### Heatmap Color Scale
Change the color scale by specifying values and colors.

{{example heatmapColorScale}}

### Dendrogram Cluster Colors/Line Widths
Change the colors of the dendrogram traces that are used to represent clusters, and configure their line widths.

{{example dendrogramColorsLineWidths}}

### Relative Dendrogram Size
Change the relative width and height of, respectively, the row and column dendrograms compared to the width and height of the heatmap.

{{example relativeDendrogramSize}}

### Hidden Labels
Hide the labels along one or both dimensions.

{{example hiddenLabels}}

### Annotations
Annotate the clustergram by highlighting specific clusters.

{{example annotateClustergram}}

{{reference dash_bio.Clustergram}}

## Example Data

- https://github.com/plotly/datasets/blob/master/Dash_Bio/Chromosomal/clustergram_brain_cancer.csv
- [Microarray gene expression cancer data](https://data.mendeley.com/datasets/ynp2tst2hh/4)
- [Amygdala gene expression after stress](https://data.mendeley.com/datasets/6x5bkz42k7/1)
- [Autism gene expression data](https://figshare.com/articles/dataset/Autism_gene_expression_data/14251328/1)
