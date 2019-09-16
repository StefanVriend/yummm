# Food items
foods <- c(
  "banana",
  "avocado",
  "kiwi"
)

# Colours
cols <- c(
  "#FFCF4A",
  "#332C34",
  "#7FA430"
)

# Combine
dplyr::tibble(
  Food = foods,
  Col = cols) %>%
  dplyr::arrange(Food) ->
  food.cols
