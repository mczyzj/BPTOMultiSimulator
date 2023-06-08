#' render_sliders UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_render_sliders_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("DynamicSliders"))
  )
}

#' render_sliders Server Functions
#'
#' @noRd
mod_render_sliders_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$DynamicSliders <- renderUI({
      tagList(
        sliders_list <- vector("list", length(data()$specs$Product)),
        for (i in 1:length(data()$specs$Product)) {
          sliders_list[[i]] <- sliderInput(
            inputId = ns(snakecase::to_snake_case(data()$specs[i, 1])),
            label   = data()$specs[i, 1],
            min     = data()$specs[i, 2],
            max     = data()$specs[i, 4],
            value   = data()$specs[i, 3]
          )
        },
        sliders_list
      )
    })
  })
}

## To be copied in the UI
# mod_render_sliders_ui("render_sliders_1")

## To be copied in the server
# mod_render_sliders_server("render_sliders_1")