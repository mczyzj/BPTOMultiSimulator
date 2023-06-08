#' @importFrom dplyr filter
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @importFrom purrr map_chr map_dbl map2
#' @importFrom shiny NS tagList column
#' @importFrom snakecase to_snake_case
#' @import bs4Dash
#' @import shiny
#' @import shinyWidgets
#' @title BPTO Simulator
#' @description This is a boilerplate for BPTO Simulator for multiple HB
#'   conjoint models. It works with Alternative Specific design, where the
#'   Alternatives are brands, and their only attribute is Price. The package
#'   supports the models with some alternatives having constant price
#'   (for details please visit Vignette). To build the simulator you need to
#'   provide data in proper format, and the package will figure out itself the
#'   how to build the interface. As of now, it gives the insight in the
#'   Share of Preference, Revenue, Channel Sales and Profit.
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL
