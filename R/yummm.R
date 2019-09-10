#' @title Coloring with all delicious food items
#' @name yummm
#'
#' @description Use your favourite food items to colour your graphics and texts.
#'
#' @param food a character representing a food item of your choice.
#'
#' @return The hexadecimal color code corresponding to the food item in `food`.
#'
#' @seealso [yummm::in.yummm()]
#'
#' @examples
#' yummm("banana")
#'
#' @import dplyr
#' @import crayon
#' @export

yummm <- function(food) {

  food.cols %>%
    dplyr::filter(Food == food) %>%
    dplyr::select(Col) ->
    color

  if(!(food %in% foods)) {
    cat("Error: ", '"', food,  '"', " is ", crayon::underline("not"), " part of yummm.\n",
        "Find out whether your favourite food items are part of yummm using in.yummm().",
        sep="")
  }

  if(food %in% foods) return(dplyr::pull(color))

}


#' @title Is this food item part of yummm?
#'
#' @description Find out whether your favourite food item is part of the `yummm` package.
#'
#' @return Logical, `TRUE` or `FALSE`
#' @export
#'

in.yummm <- function(food) {
  if(food %in% foods) cat(crayon::cyan('"', food, '"', " is part of yummm.", sep=""))
  if(!(food %in% foods)) cat(crayon::red('"', food, '"', "is ", crayon::underline("not"), " part of yummm.", sep=""))
}
