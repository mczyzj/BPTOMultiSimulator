#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {

  ### SIDEBAR CONTENT ###
  sidebar <- dashboardSidebar(
    sidebarMenu(
      tags$style(HTML(".sidebar-menu li a { font-size: 1.2em; }")),
      #mod_study_picker_ui("study_picker_1", study_list),
      menuItem("Main", tabName = "main", icon = icon("home")),
      menuItem("Simulator", tabName = "simulator", icon = icon("poll-h")),
      br()#,
      #actionButton(
      #  "validate", span(icon("redo"), "Calculate"),
      #  style="color: #fff; background-color: #ff2975; border-color: #8c1eff",
      #  width = "80%"
      #),
      #actionButton(
      #  "reset", span(icon("redo"), "Reset assumptions"),
      #  style="color: #fff; background-color: #ff2975; border-color: #8c1eff",
      #  width = "80%"
      #),
      #mod_sample_boxes_ui("sample_boxes_ui_1"),
      #mod_sample_boxes_ui("sample_boxes_ui_2")
    )
  )

  body <- dashboardBody()

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
