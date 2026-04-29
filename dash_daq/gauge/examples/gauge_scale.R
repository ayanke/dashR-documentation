library(dashDaq)

daqGauge(
    label = "Scale",
    scale = list("start" = 0, "interval" = 3, "labelInterval" = 2),
    value = 3,
    min=0,
    max=24
)