#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  ### Setup data
  sets_list <- BPTOMultiSimulator::cj_example_list

  data_specs <- mod_study_picker_server(
    "study_picker_1", sets_list, reactive(input$validate)
  )

   mod_test_texr_server("test_texr_1", data_specs$selected_study)
   mod_render_sliders_server("render_sliders_1", data_specs$selected_study)
   current_prices <- mod_get_sliders_values_server(
     "render_sliders_1", data_specs$selected_study, reactive(input$validate),
     reactive(input$reset)
  )

  mod_test_prc_server("test_prc_1", current_prices$choice_price)
}
