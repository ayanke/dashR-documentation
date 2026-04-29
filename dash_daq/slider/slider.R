library(dash)
library(dashDaq)
library(data.table)
library(dashTable)

utils <- new.env()
source('dash_docs/styles.R')
source('dash_docs/utils.R', local=utils)

examples <- list(
  defaultSlider = utils$LoadExampleCode(
    "dash_docs/chapters/dash_daq/slider/examples/defaultSlider.R")
)

dashdaq_intro <- htmlDiv(list(
  dccMarkdown('# Slider Examples and Reference')
  )
)

# Individual Components and Examples
defaultSlider <- htmlDiv(list(
  htmlH3("Default Slider"),
  htmlP("An example of a default Slider without any extra properties."),
  htmlDiv(
    list(
      examples$defaultSlider$source_code,
      examples$defaultSlider$layout
    ),
    className = 'code-container'
  )
))

sliderMarks <-  htmlDiv(list(
  htmlH3("Marks"),
  dccMarkdown("Set custom marks on the slider using with `marks`."),
  utils$LoadAndDisplayComponent(
    '

  '
  )))

sliderSize <-  htmlDiv(list(
  htmlH3("Size"),
  dccMarkdown("Change the size of the slider using `size`."),
  utils$LoadAndDisplayComponent('

  ')
))

sliderHandle <-  htmlDiv(list(
  htmlH3("Handle Label"),
  dccMarkdown("Set the labels for the handle that is dragged with `handleLabel`."),
  utils$LoadAndDisplayComponent(
    '

  '
  )))

sliderStep <-  htmlDiv(list(
  htmlH3("Step"),
  dccMarkdown("Change the value of increments or decrements using `step`."),
  utils$LoadAndDisplayComponent(
    '

  '
  )))

sliderVertical <-  htmlDiv(list(
  htmlH3("Vertical Orientation"),
  dccMarkdown("Make the slider display vertically by setting vertical = TRUE."),
  utils$LoadAndDisplayComponent('

  '
  )))

sliderProps <- props_to_list("daqSlider")

sliderPropsDF <- rbindlist(sliderProps, fill = TRUE)

sliderTable <- generate_table(sliderPropsDF)

layout <- htmlDiv(
  list(
    dashdaq_intro,
    htmlHr(),
    defaultSlider,
    htmlHr(),
    sliderMarks,
    htmlHr(),
    sliderSize,
    htmlHr(),
    sliderHandle,
    htmlHr(),
    sliderStep,
    htmlHr(),
    sliderVertical,
    htmlHr(),
    htmlHr(),
    htmlH3("Slider Properties"),
    sliderTable,
    htmlHr(),
    dccMarkdown("[Back to Dash DAQ Documentation](/dash-daq)"),
    dccMarkdown("[Back to the Table of Contents](/)")
  )
)
