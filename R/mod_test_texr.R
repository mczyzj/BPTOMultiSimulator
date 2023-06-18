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

mod_test_prc_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("PRCText"))
  )
}

#' test_texr Server Functions
#'
#' @noRd
mod_test_prc_server <- function(id, prc){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$PRCText <- renderUI({
      tagList(
        renderText(prc()$Base)
      )
    })
  })
}

mod_test_dm_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("DMText"))
  )
}

#' test_texr Server Functions
#'
#' @noRd
mod_test_dm_server <- function(id, dist_margin){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$DMText <- renderUI({
      tagList(
        renderText(dist_margin()$dm)
      )
    })
  })
}

mod_test_cost_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("COSTText"))
  )
}

#' test_texr Server Functions
#'
#' @noRd
mod_test_cost_server <- function(id, cost){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$COSTText <- renderUI({
      tagList(
        renderText(cost()$cost)
      )
    })
  })
}


mod_test_ms_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("MSText"))
  )
}

#' test_texr Server Functions
#'
#' @noRd
mod_test_ms_server <- function(id, ms){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$MSText <- renderUI({
      tagList(
        renderText(ms())
      )
    })
  })
}
