#' Fill the yummm market with food palettes
#'
#' Fill the yummm market with a 10-color palette extracted from an image of the food.
#'
#' @format
#' Dataframe of two columns: \describe{
#'   \item{Food}{a character. Food.}
#'   \item{Palette}{a list. Palette of colors in hexadecimal format.}
#' }
#'
#' @name fill.market
#'
#' @import paletter
#' @import tibble
#' @import usethis
#' @import jpeg
#' @import scales
#' @export

fill.market <- function(food, n = 10) {
  pal <- paletter::create_palette(image_path=paste0("inst/images/", food, ".jpg"),
                                  number_of_colors = n,
                                  type_of_variable = "categorical")

  pal_df <- tibble::tibble(Col = pal[order(pal)],
                           ColID = c("01", "02", "03", "04", "05",
                                     "06", "07", "08", "09", "10"))

  if(file.exists("data/yummm.market.rda")){
    yummm.market[[food]] <- pal_df
  } else {
    yummm.market <- list(pal_df)
    names(yummm.market) <- food
  }

  usethis::use_data(yummm.market, overwrite = TRUE)
}

# Create list of food colors
# yummm.list <- list(
#   banana = "#FFCF4A",
#   avocado = "#332C34",
#   kiwi = "#7FA430",
#   orange = "#FFA210",
#   blueberry = "#4F65AD"
# )
