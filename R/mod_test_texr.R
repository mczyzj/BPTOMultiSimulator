#' test_texr UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_test_texr_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("DynamicText"))
  )
}

#' test_texr Server Functions
#'
#' @noRd
mod_test_texr_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$DynamicText <- renderUI({
      tagList(
        renderText(data()$specs$Product)
      )
    })
  })
}

## To be copied in the UI
# mod_test_texr_ui("test_texr_1")

## To be copied in the server
# mod_test_texr_server("test_texr_1")
