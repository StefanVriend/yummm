#' The yummm market: a table of food and colours
#'
#' A table with all food and colours in \code{yummm}. Food and colours are stored in \code{food-colours.R}.
#'
#' @format
#' Dataframe of character vertors. Column entries: \describe{
#'   \item{Food}{Food.}
#'   \item{Colour}{Colours.}
#' }
#'
#' @name yummm.market
#'
#' @include food-colours.R
#'
#' @import tibble

# Create market
tibble::tibble(
  Food = food.items,
  Colour = colours) %>%
  dplyr::arrange(Food) ->
  yummm.market
