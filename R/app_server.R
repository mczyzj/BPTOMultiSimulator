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

  ### render and read sliders ####
  mod_render_sliders_server("render_sliders_1", data_specs$selected_study)
  mod_render_dist_margin_server("render_dm_1", data_specs$selected_study)
  mod_render_cost_server("render_cost_1", data_specs$selected_study)

  ### get current assumptions ####
  current_prices <- mod_get_sliders_values_server(
     "render_sliders_1", data_specs$selected_study, sets_list,
     reactive(input$reset)
  )
  current_dm <- mod_get_dm_values_server(
    "render_dm_1", data_specs$selected_study, sets_list,
    reactive(input$reset)
  )
  current_cost <- mod_get_cost_values_server(
    "render_cost_1", data_specs$selected_study, sets_list,
    reactive(input$reset)
  )
  current_ms <- mod_market_size_server("market_size_1")


   ### testing ####
  mod_test_texr_server("test_texr_1", data_specs$selected_study)
  mod_test_prc_server("test_prc_1", current_prices$prices)
  mod_test_dm_server("test_dm_1", current_dm$margin)
  mod_test_cost_server("test_cost_1", current_cost$cost)
  mod_test_ms_server("test_ms_1", current_ms$ms)
}

