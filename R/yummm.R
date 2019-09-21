#' @title Delicious colors to decorate your graphics
#' @name yummm
#'
#' @description Use your favourite food items to colour your graphics and texts.
#'
#' @param food a character vector representing the food items of your choice.
#'
#' @return A character string (in hexadecimal format) corresponding to the food item of your choice.
#'
#' @seealso \code{\link{in.yummm}}
#'
#' @examples
#' yummm("banana")
#'
#' @import crayon
#' @import dplyr
#' @export

yummm <- function(food) {

  ## CHANGE THIS CODE TO ALLOW MORE THAN 1 COLOR TO BE SELECTED
  yummm.market %>%
    dplyr::filter(Food %in% food) %>%
    dplyr::select(Colour) ->
    colour

  if(any(food %in% food.items == FALSE)) {
    not.in.yummm <- food[!(food %in% food.items)]
    for(i in 1:length(not.in.yummm)) {
      cat("Error: ", '"', not.in.yummm[i],  '"', " is ",
          crayon::underline("not"), " part of yummm.\n",
          "Find out whether your favourite food items are part of yummm using in.yummm().\n",
          sep="")
    }
  }

  if(!any(food %in% food.items == FALSE)) return(dplyr::pull(colour))

}


#' @title Is this food item part of yummm?
#' @name in.yummm
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

  # Part of yummm
  part.of.yummm <- food[food %in% food.items]
  if(length(part.of.yummm) != 0) {
    for(i in 1:length(part.of.yummm)) {
      cat(crayon::cyan('"', part.of.yummm[i], '"', " is part of yummm.\n", sep=""))
    }
  }

  # Not in yummm
  not.in.yummm <- food[!(food %in% food.items)]
  if(length(not.in.yummm) != 0) {
    for(i in 1:length(not.in.yummm)) {
      cat(crayon::red('"', not.in.yummm[i], '"', "is ",
                      crayon::underline("not"), " part of yummm.\n", sep=""))
    }
  }
}
