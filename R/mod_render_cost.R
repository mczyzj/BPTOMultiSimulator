#' render_dist_margin UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_render_cost_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("DynamicCost"))
  )
}

#' render_dist_margin Server Functions
#'
#' @noRd
mod_render_cost_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    names_cost <- reactive(
      data()$specs %>%
        filter(.data$Min != .data$Max)
    )

    output$DynamicCost <- renderUI({
      tagList(
        cost_list <- vector("list", length(names_cost()$Product)),
        for (i in 1:length(names_cost()$Product)) {
          cost_list[[i]] <- numericInput(
            inputId = ns(snakecase::to_snake_case(data()$specs[i, 1])),
            label   = data()$specs[i, 1],
            min     = 0,
            step    = 0.1,
            value   = data()$specs[i, 6]
          )
        },
        cost_list
      )
    })
  })
}

#' @noRd
mod_get_cost_values_server <- function(id, data, start, resetButton){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    assumptions <- reactiveVal()

    current_cost <- reactiveVal()
    varrying_cost <- reactiveVal()

    varrying_cost <- reactive(
      data()$specs %>%
        filter(.data$Min != .data$Max)
    )

    cost_vec <- reactive(to_snake_case(varrying_cost()$Product))

    assumptions <- reactive(
      list(
        cost   = map_dbl(cost_vec(), ~input[[.x]])
      )
    )


    observeEvent(resetButton(), {
      map2(
        .x = to_snake_case(varrying_cost()$Product),
        .y = varrying_cost()$cost,
        ~updateNumericInput(session, inputId = .x, value   = .y)
      )
    })

    return(list(
      cost = reactive({ as.list(assumptions()) })
    ))

  })
}

## To be copied in the UI
# mod_render_dist_margin_ui("render_dist_margin_1")

## To be copied in the server
# mod_render_dist_margin_server("render_dist_margin_1")
