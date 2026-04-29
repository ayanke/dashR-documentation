library(dashCoreComponents)

dccRangeSlider(
    min=0,
    max=100,
    marks = list(
        "0" = list("label" = "0°C", "style" = list("color" = "#77b0b1")),
        "26" = list("label" = "26°C"),
        "37" = list("label" = "37°C"),
        "100" = list("label" = "100°C" , "style" = list("color" = "#FF4500"))
    )
)