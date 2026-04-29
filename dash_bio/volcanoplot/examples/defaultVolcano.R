library(dash)
library(dashBio)
library(dashHtmlComponents)
library(dashCoreComponents)

app <- Dash$new()

df <- read.csv(
  file ='https://git.io/volcano_data1.csv',
  stringsAsFactors = FALSE
)

app$layout(
    htmlDiv(
        list(
            'Effect sizes',
            dccRangeSlider(
                id = 'default-volcanoplot-input',
                min = -3,
                max = 3,
                step = 0.05,
                marks = setNames(
                    lapply(-3:3,
                        function(i){
                            list(label = as.character(i))
                        }),
                        -3:3
                ),
                value = c(-0.5, 1)
            ),
            htmlBr(),
            htmlDiv(
                dccGraph(
                    id = 'dashbio-default-volcanoplot',
                    figure = dashbioVolcano(
                        dataframe = df
                    )
                )
            )
        )
    )
)
app$callback(
    output = list(id = 'dashbio-default-volcanoplot', property = 'figure'),
    params = list(input(id = 'default-volcanoplot-input', property = 'value')),
    function(effects) {
        dashbioVolcano(
            dataframe = df,
            genomewideline_value = 2.5,
            effect_size_line = unlist(effects)
        )
    }
)

app$run_server()
