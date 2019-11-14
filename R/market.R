#' The yummm market: a table of food and palettes
#'
#' A table with all food and palettes in \code{yummm}.
#'
#' @format
#' Dataframe of two columns: \describe{
#'   \item{Food}{a character. Food.}
#'   \item{Palette}{a list. Palette of colors in hexadecimal format.}
#' }
#'
#' @name yummm.market
#'
#' @import tibble

# Create list of food colors
yummm.list <- list(
  banana = "#FFCF4A",
  avocado = "#332C34",
  kiwi = "#7FA430",
  orange = "#FFA210",
  blueberry = "#4F65AD"
)

# Create market
yummm.market <- tibble::tibble(
  Food = names(yummm.list),
  Palette = yummm.list
)
