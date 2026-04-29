library(dashDaq)

daqKnob(label = "Color Ranges",
        value = 3,
        color = list("ranges" =
                       list(
                         "green" = list(0, 5),
                         "yellow" = list(5, 9),
                         "red" = list(9, 10)
                       )
                     )
        )