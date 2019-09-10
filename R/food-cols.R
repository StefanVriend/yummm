# Food items
foods <- c(
  "banana",
  "avocado"
)

# Colours
cols <- c(
  "#FFCF4A",
  "#332C34"
)

# Combine
dplyr::tibble(
  Food = foods,
  Col = cols) %>%
  dplyr::arrange(Food) ->
  food.cols
