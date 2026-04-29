library(dashDaq)

daqTank(
  value = 3,
  scale = list(
    "interval" = 2,
    "labelInterval" = 2,
    "custom" = list("5" = "Set point")
  ),
  style = list("margin-left" = "50px")
)