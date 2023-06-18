#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  ### Setup data
  sets_list <- BPTOMultiSimulator::cj_example_list

  ### SIDEBAR CONTENT ####
  sidebar <- dashboardSidebar(
    sidebarMenu(
      tags$style(HTML(".sidebar-menu li a { font-size: 1.2em; }")),
      mod_study_picker_ui("study_picker_1", sets_list),
      menuItem("Main", tabName = "main", icon = icon("home")),
      menuItem("Simulator", tabName = "simulator", icon = icon("poll-h")),
      br(),
      actionBttn(
       inputId = "validate", label = span(icon("redo"), "Calculate"),
       style = "unite",
       color = "royal",
       width = "80%"
      ),
      actionBttn(
        inputId = "reset", label = span(icon("redo"), "Reset assumptions"),
        style = "unite",
        color = "royal",
        width = "80%"
      )
    )
  )
 ### BODY CONTENT ####
  body <- dashboardBody(
    tabItems(
      tabItem(
        tabName = "main",
        fluidRow(
          ### ASSUMPTIONS BOX ###
            box(
              title = span(icon("info"), "test"),
              width = 12, solidHeader = TRUE, collapsible = TRUE,
              mod_test_texr_ui("test_texr_1")
            ),
            box(
              title = span(icon("info"), "test"),
              width = 12, solidHeader = TRUE, collapsible = TRUE,
              mod_test_prc_ui("test_prc_1")
            ),
            box(
              title = span(icon("info"), "test"),
              width = 12, solidHeader = TRUE, collapsible = TRUE,
              mod_test_dm_ui("test_dm_1")
            ),
            box(
              title = span(icon("info"), "test"),
              width = 12, solidHeader = TRUE, collapsible = TRUE,
              mod_test_cost_ui("test_cost_1")
            ),
            box(
              title = span(icon("info"), "test"),
              width = 12, solidHeader = TRUE, collapsible = TRUE,
              mod_test_ms_ui("test_ms_1")
            ),
          column(width = 3, box(
            title = span(icon("sliders-h"), " Assumptions"),
            width = 12, solidHeader = TRUE, collapsible = TRUE,
            h4(span(icon("euro-sign"), " Price")),
            shinyWidgets::chooseSliderSkin("Modern", color = "#ff2975"),
            mod_render_sliders_ui("render_sliders_1")
          )),
          column(width = 3, box(
            title = h4(span(icon("percent")), " Distribution margin"),
            width = 12, solidHeader = TRUE, collapsible = TRUE,
            mod_render_dist_margin_ui("render_dm_1")
          )),
          column(width = 3, box(
            h4(span(icon("calculator")), " Cost"),
            width = 12, solidHeader = TRUE, collapsible = TRUE,
            mod_render_cost_ui("render_cost_1")
          )),
          column(width = 3, box(
            h4(span(icon("globe")), " Market size"),
            width = 12, solidHeader = TRUE, collapsible = TRUE,
            mod_market_size_ui("market_size_1")
          ))
      )
    )
  ))

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    dashboardPage(
      dashboardHeader(
        title = "Example Mulitple BPTO Simulator",
        tags$li(a(
          href = 'http://codingmanatee.ninja',
          img(
            src = 'www/cj_logo.png',
            title = "Coding Manatee Ninja",
            height = "45px"
          ),
          style = "padding: 2px 0px 0px 0px;"),
          class = "dropdown"),
        tags$li(a(
          href = 'http://codingmanatee.ninja',
          icon("power-off"),
          title = "Back to Apps Home"),
          class = "dropdown"
        )
      ),
      sidebar,
      body
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "BPTO Multi Simulator"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
