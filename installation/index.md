---
url: /installation
name: Installation
description:
    "How to install and upgrade Dash"
icon: tools.svg
languages:
  - python
  - r
  - fsharp
  - matlab
  - julia
---
# ![](/assets/images/language_icons/r-lang_50px.svg) Dash Installation



Install the `dash` package and its dependencies from GitHub:


```r
install.packages("remotes")
remotes::install_github("plotly/dashR", upgrade = "always")
```


This also brings along the `plotly` graphing
package. This package is
under active development, so install and upgrade frequently.








These docs are using `dash` version ` ||julia `1.0.0` ||r `0.9.1`}}.

Note that Dash requires R version `3.0.2` or higher (you can check which version of R you have by typing `R.version.string` in the R console).




{{oss {{dash-club}} }}



{{oss
{{import /reusable_components/WorkspaceBlurb.md}}
}}
