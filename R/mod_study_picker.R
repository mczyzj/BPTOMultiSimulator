#' study_picker UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_study_picker_ui <- function(id, data){
  ns <- NS(id)
  tagList(
    pickerInput(
      inputId = ns("study"),
      label = "Study set",
      choices = names(data),
      selected = names(data)[1],
      width = "100%"
    )
  )
}

#' study_picker Server Functions
#'
#' @noRd
mod_study_picker_server <- function(id, data, validateButton){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    assumptions <- reactiveVal()

    assumptions(list(
      utils   = data[[1]]$utilities,
      filters = data[[1]]$filters,
      key     = data[[1]]$key,
      specs   = data[[1]]$specs
    ))

    observeEvent(validateButton(), {
      assumptions(list(
        utils   = data[[input$study]]$utilities,
        filters = data[[input$study]]$filters,
        key     = data[[input$study]]$key,
        specs   = data[[input$study]]$specs
      ))
    })


    return(list(
      selected_study = reactive({ as.list(assumptions()) })
    ))

  })
}

## To be copied in the UI
# mod_study_picker_ui("study_picker_1")

## To be copied in the server
# mod_study_picker_server("study_picker_1")
