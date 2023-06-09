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

    names_sliders <- reactive(
      data()$specs %>%
        filter(.data$Min != .data$Max)
    )


    output$DynamicSliders <- renderUI({
      tagList(
        sliders_list <- vector("list", length(names_sliders()$Product)),
        for (i in 1:length(names_sliders()$Product)) {
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

mod_get_sliders_values_server <- function(id,
                                          data,
                                          start,
                                          resetButton){
  moduleServer(id, function(input, output, session){
    ns <- session$ns


    assumptions <- reactiveVal()

    current_prices <- reactiveVal()
    varrying_prices <- reactiveVal()

    varrying_prices <- reactive(
        data()$specs %>%
          filter(.data$Min != .data$Max)
      )

    sliders_vec2 <- reactive(to_snake_case(varrying_prices()$Product))

    assumptions <- reactive(list(
      Base   = map_dbl(sliders_vec2(), ~input[[.x]])
    ))


    observeEvent(resetButton(), {
      map2(
        .x = to_snake_case(varrying_prices()$Product),
        .y = varrying_prices()$Base,
        ~updateSliderInput(session, inputId = .x, value   = .y)
      )
    })

    return(list(
      prices = reactive({ as.list(assumptions()) })
    ))

  })
}

## To be copied in the UI
# mod_render_sliders_ui("render_sliders_1")

## To be copied in the server
# mod_render_sliders_server("render_sliders_1")
