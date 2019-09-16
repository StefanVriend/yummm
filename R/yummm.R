#' @title Delicious colors to decorate your graphics
#' @name yummm
#'
#' @description Use your favourite food items to colour your graphics and texts.
#'
#' @param food a character representing a food item of your choice.
#'
#' @return A character string (in hexadecimal format) corresponding to the food item of your choice.
#'
#' @seealso \code{\link{in.yummm}}
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
#' @examples
#' in.yummm("banana")
#'
#' @return Logical, TRUE or FALSE
#'
#' @inheritParams yummm
#'
#' @export
#'

in.yummm <- function(food) {
  if(food %in% foods) cat(crayon::cyan('"', food, '"', " is part of yummm.", sep=""))
  if(!(food %in% foods)) cat(crayon::red('"', food, '"', "is ", crayon::underline("not"), " part of yummm.", sep=""))
}
