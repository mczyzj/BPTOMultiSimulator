#' market_size UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_market_size_ui <- function(id){
  ns <- NS(id)
  tagList(
    numericInput(ns("ms"), label = "Market size", value = 100000)
  )
}

#' market_size Server Functions
#'
#' @noRd
mod_market_size_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    assumptions <- reactiveVal()

    assumptions <- reactive(list(market_size = 100000))

    assumptions <- reactive(list(market_size = input$ms))

    return(list(ms = reactive({assumptions()$market_size})))
  })
}

## To be copied in the UI
# mod_market_size_ui("market_size_1")

## To be copied in the server
# mod_market_size_server("market_size_1")
