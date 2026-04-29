library(dashCoreComponents)

dccRangeSlider(
  min=0,
  max=10,
  marks=list(
    "0" = "0°F",
    "3" = "3°F",
    "5" = "5°F",
    "7.65" = "7.65°F",
    "10" = "10°F"
  ),
  value=list(3, 7.65)
)
