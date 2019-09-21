#' The Yummm Market: a table of food items and colours
#'
#' @name yummm.market
#'
#' @format
#' Dataframe of character vertors. Column entries: \describe{
#'   \item{Food}{Food items.}
#'   \item{Colour}{Colours.}
#' }
#'
#' @import tibble

# Food items
food.items <- c(
  "banana",
  "avocado",
  "kiwi"
)

# Colours
colours <- c(
  "#FFCF4A",
  "#332C34",
  "#7FA430"
)


# Combine in market
tibble::tibble(
  Food = food.items,
  Colour = colours) %>%
  dplyr::arrange(Food) ->
  yummm.market
