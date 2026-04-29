library(dashDaq)

daqGauge(
  color = list(
    "gradient" = TRUE,
    "ranges" = list(
      "green" = list(0, 6),
      "yellow" = list(6, 8),
      "red" = list(8, 10)
    )
  ),
  value = 2,
  label = "Default",
  max = 10,
  min = 0
)