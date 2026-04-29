library(dashDaq)

daqSlider(
    min = 0,
    max = 100,
    value = 50,
    handleLabel = list("showCurrentValue" = TRUE, "label" = "VALUE"),
    step = 10
)