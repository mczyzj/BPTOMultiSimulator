library("DirichletReg")
library("dplyr")
cj_utils_example1 <- rdirichlet(83, c(1,2,3,4,5,6,7,8)) %>%
  sweep(., 1, rowMeans(.)) %>%
  as.data.frame() %>%
  setNames(paste0("Prod", 1:8)) %>%
  mutate(
    across(
      num_range(prefix = "Prod", range = 1:8),
      ~rnorm(83, sample(seq(-1.5,-0.5,0.1),1), 0.15),
      .names = "att_{col}"
    )
  ) %>%
  mutate(
    att_Prod8 = 0
  ) %>%
  mutate(Respondent = 1:83 + 20000, .before = "Prod1")


cj_utils_example2 <- rdirichlet(100, c(11,10,9,8,5,6,7,5,6,7,3)) %>%
  sweep(., 1, rowMeans(.)) %>%
  as.data.frame() %>%
  setNames(paste0("Prod", 1:11)) %>%
  mutate(
    across(
      num_range(prefix = "Prod", range = 1:11),
      ~rnorm(100, sample(seq(-2,-0.7,0.1),1), 0.19),
      .names = "att_{col}"
    )
  ) %>%
  mutate(
    across(att_Prod4:att_Prod11, ~0)
  ) %>%
  mutate(Respondent = 1:100 + 10000, .before = "Prod1")


cj_filters_example1 <- read.csv("data-raw/cj_filters_example1.csv", stringsAsFactors = FALSE)
cj_key_filters_example1 <- read.csv("data-raw/cj_key_filters_example1.csv", stringsAsFactors = FALSE)
cj_specs_example1 <- read.csv("data-raw/cj_specs_example1.csv", stringsAsFactors = FALSE)
cj_specs_test_example1 <- read.csv("data-raw/cj_specs_example1.csv", stringsAsFactors = FALSE) %>%
  dplyr::mutate(Max = ifelse(Product %in% c("Competitor 5", "Competitor 6"), Min, Base),
                Base = ifelse(Product %in% c("Competitor 5", "Competitor 6"), Min, Base),
                dm = ifelse(Product %in% c("Competitor 5", "Competitor 6"), 0, dm),
                cost = ifelse(Product %in% c("Competitor 5", "Competitor 6"), 0, cost))


cj_filters_example2 <- read.csv("data-raw/cj_filters_example2.csv", stringsAsFactors = FALSE)
cj_key_filters_example2 <- read.csv("data-raw/cj_key_filters_example2.csv", stringsAsFactors = FALSE)
cj_specs_example2 <- read.csv("data-raw/cj_specs_example2.csv", stringsAsFactors = FALSE)

cjt_example_1 <- list(
  utilities = cj_utils_example1,
  filters = cj_filters_example1,
  key = cj_key_filters_example1,
  specs = cj_specs_example1
)

cjt_example_2 <- list(
  utilities = cj_utils_example2,
  filters = cj_filters_example2,
  key = cj_key_filters_example2,
  specs = cj_specs_example2
)

cj_example_list <- list(
  anonymous_study = cjt_example_1,
  alkohol_study = cjt_example_2
)

usethis::use_data(cj_utils_example2, overwrite = TRUE)
usethis::use_data(cj_filters_example2, overwrite = TRUE)
usethis::use_data(cj_key_filters_example2, overwrite = TRUE)
usethis::use_data(cj_specs_example2, overwrite = TRUE)

usethis::use_data(cj_example_list, overwrite = TRUE)
