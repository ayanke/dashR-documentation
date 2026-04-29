library(dashDaq)

daqThermometer(
  id = "my-daq-tscales",
  value = 5,
  scale = list(
    "start" = 2,
    "interval" = 3,
    "labelInterval" = 2,
    "custom" = list("2" = "ideal temperature",
                    "5" = "projected temperature")
  )
)