#' The yummm market: a table of food and colors
#'
#' A table with all food and colors in \code{yummm}. Food and colors are stored in \code{food-colors.R}.
#'
#' @format
#' Dataframe of character vertors. Column entries: \describe{
#'   \item{Food}{Food.}
#'   \item{Color}{Colors.}
#' }
#'
#' @name yummm.market
#'
#' @include food-colors.R
#'
#' @import tibble

# Create market
tibble::tibble(
  Food = food.items,
  Color = colors) %>%
  dplyr::arrange(Food) ->
  yummm.market
