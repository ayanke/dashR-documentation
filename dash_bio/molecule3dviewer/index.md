---
url: /dash-bio/molecule3dviewer
name: Molecule3dViewer
description:
    "Dash Bio is a component library
    dedicated to visualizing bioinformatics data."
icon_path: images/icons_v2/www (1).svg
languages:
  - python
  - julia
  - r
  - matlab
thumbnail: 'molecule3dviewer.png'
---
# ![](/assets/images/language_icons/r-lang_50px.svg) dash_bio.Molecule3dViewer Examples and Reference
see [Molecule3dViewer in action](https://dash-gallery.plotly.host/dash-molecule-3d-viewer).

## Molecule3dViewer

An example of a default Molecule3dViewer component without any extra properties.

{{example defaultMolecule3d}}

## Customization

### Zoom Factor
The current stage of the molecule viewer can be zoomed by a constant factor with the zoom prop. This maintains the rotation and orientation of the stage while zooming, as well as any selections or property changes from other callbacks.

It is important to note that the `zoom` animation can conflict with the `zoomTo` animation if both props are set. In this case, it is recommended to set animationDuration to values that would not overlap, or use `fixedPath` to prioritize the animation which occurs.

{{example molecule3dZoomFactor}}

### Zooming to Specific Residues
We can zoom into specific residues and chains on the molecule by setting the `zoomTo` prop. An optional `animationDuration` denotes the duration of the zoom animation (in milliseconds),


The `chain` key indicates the protein chain identifier from the molecule's model data, and `resi` is the internal integer index value on the chain for the residue of interest.

In the example below, select the rows on the table to zoom into and label the chosen residue.

{{example molecule3dZoomingSpecific}}

### Selection Type
Choose what gets highlighted with the same color upon selection.

{{example molecule3dSelectionType}}

### Background Color/Opacity
Change the background color and opacity of the canvas on which Mol3D is rendered.

{{example molecule3dBgColorOpacity}}

### Labels
Add labels corresponding to the atom of the molecule. Label styles can be set with additional parameters. For styling keys, [see](https://3dmol.csb.pitt.edu/doc/types.html#LabelSpec).

{{example molecule3dLabels}}

### Shapes
Add predefined renderable shapes to the molecule. Supported shape types are Arrow, Sphere, and Cylinder.

{{example molecule3dShapes}}

### Isosurfaces
Render a 3D isosurface. Volumetric orbital data must be provided in the `cube` file format.

{{example molecule3dIsoSurfaces}}

{{reference dash_bio.Molecule3dViewer}}

## Example Data

- https://github.com/plotly/datasets/blob/master/Dash_Bio/Molecular/mol3d/model_data.js
- [Computational predictions of protein structures associated with COVID-19](https://deepmind.com/research/open-source/computational-predictions-of-protein-structures-associated-with-COVID-19)
- - [RCSB Protein Data Bank](https://www.rcsb.org/)
