library(dashDaq)

daqGraduatedBar(
  color = list(
    "ranges" = list(
      "green" = list(0, 4),
      "yellow" = list(4, 7),
      "red" = list(7, 10)
    )
  ),
  showCurrentValue = TRUE,
  value = 10
)