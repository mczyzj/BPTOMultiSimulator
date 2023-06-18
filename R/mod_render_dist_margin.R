#' render_dist_margin UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_render_dist_margin_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("DynamicDistMargin"))
  )
}

#' render_dist_margin Server Functions
#'
#' @noRd
mod_render_dist_margin_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    names_dist_margin <- reactive(
      data()$specs %>%
        filter(.data$Min != .data$Max)
    )

    output$DynamicDistMargin <- renderUI({
      tagList(
        dm_list <- vector("list", length(names_dist_margin()$Product)),
        for (i in 1:length(names_dist_margin()$Product)) {
          dm_list[[i]] <- numericInput(
            inputId = ns(snakecase::to_snake_case(data()$specs[i, 1])),
            label   = data()$specs[i, 1],
            min     = 0,
            max     = 1,
            step    = 0.01,
            value   = data()$specs[i, 5]
          )
        },
        dm_list
      )
    })
  })
}

#' @noRd
mod_get_dm_values_server <- function(id, data, start, resetButton){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    assumptions <- reactiveVal()

    current_dm <- reactiveVal()
    varrying_dm <- reactiveVal()

    varrying_dm <- reactive(
      data()$specs %>%
        filter(.data$Min != .data$Max)
    )

    dm_vec <- reactive(to_snake_case(varrying_dm()$Product))

    assumptions <- reactive(
      list(
        dm   = map_dbl(dm_vec(), ~input[[.x]])
      )
    )


    observeEvent(resetButton(), {
      map2(
        .x = to_snake_case(varrying_dm()$Product),
        .y = varrying_dm()$dm,
        ~updateNumericInput(session, inputId = .x, value   = .y)
      )
    })

    return(list(
      margin = reactive({ as.list(assumptions()) })
    ))

  })
}

## To be copied in the UI
# mod_render_dist_margin_ui("render_dist_margin_1")

## To be copied in the server
# mod_render_dist_margin_server("render_dist_margin_1")
