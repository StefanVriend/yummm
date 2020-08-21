#' The yummm market: a table of food and palettes
#'
#' A list with all food and palettes in \code{yummm}. The market is filled using \code{fill_market}.
#'
#' @format
#' A list of food names, each item is a dataframe of 10 rows and 2 columns: \describe{
#'   \item{Color}{Character. Color in hexadecimal format.}
#'   \item{Shade}{Character. Shade ID of each color ("01"--"10").}
#' }

"yummm_market"

#' Aliases for food names
#'
#' A list with aliases for food names, so that the correct color is printed when a user calls an alias instead of the name under which the food is stored in the yummm market.
#'
#' @format A list of food names, each item is a character vector of aliases.

"yummm_aliases"

#' Bananas per week
#'
#' A fictional dataset containing the average number of bananas eaten per week for 1,000 supermarket visitors.
#'
#' @format A data frame with 1000 observations and 2 variables:
#' \describe{
#'   \item{id}{Integer. Personal IDs for supermarkt visitors (1--1000).}
#'   \item{n}{Integer. Average umber of bananas eaten per week (0--10).}
#' }

"bpw"
