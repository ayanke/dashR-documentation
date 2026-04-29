library(dashDaq)

daqSlider(
    id = "my-daq-marks",
    min = 0,
    max = 100,
    value = 30,
    marks = list("25" = "mark", "50" = "50")
)