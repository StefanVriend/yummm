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
#' @import purrr
#' @export

yummm <- function(food) {

  yummm.market %>%
    dplyr::filter(Food %in% food) %>%
    dplyr::select(Colour) ->
    colour

  if(any(food %in% food.items == FALSE)) {
    not.in.yummm <- food[!(food %in% food.items)]

    purrr::walk(.x = not.in.yummm,
                .f = ~{
                  cat("Error: ", '"', .x,  '"', " is ",
                      crayon::underline("not"), " part of yummm.\n",
                      "Find out whether your favourite food ",
                      "is part of yummm using in.yummm().\n",
                      sep="")
                })
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

  purrr::walk(.x = food,
              .f = ~{
                part.of.yummm <- .x %in% food.items
                if(part.of.yummm == TRUE) {
                  cat(crayon::cyan('"', .x, '"', " is part of yummm.\n", sep=""))
                } else {
                  cat(crayon::red('"', .x, '"', " is ",
                                  crayon::underline("not"), " part of yummm.\n", sep=""))
                }
              })
}
