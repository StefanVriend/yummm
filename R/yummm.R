#' @title Delicious colors to decorate your graphics
#' @name yummm
#'
#' @description Use your favorite food to color your graphics and texts.
#'
#' @param food a character vector representing the food of your choice.
#'
#' @return A character string (in hexadecimal format) corresponding to the food of your choice.
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
    dplyr::pull(Palette) ->
    color

  if(any(food %in% yummm.market$Food == FALSE)) {
    not.in.yummm <- food[!(food %in% yummm.market$Food)]

    purrr::walk(.x = not.in.yummm,
                .f = ~{
                  cat("Error: ", '"', .x,  '"', " is ",
                      crayon::underline("not"), " part of yummm.\n",
                      "Find out whether your favorite food ",
                      "is part of yummm using in.yummm().\n",
                      sep="")
                })
  }

  if(!any(food %in% yummm.market$Food == FALSE)) return(unlist(color))

}


#' @title Is this food part of yummm?
#' @name in.yummm
#'
#' @description Find out whether your favorite food is part of the `yummm` package.
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
                part.of.yummm <- .x %in% yummm.market$Food
                if(part.of.yummm == TRUE) {
                  cat(crayon::cyan('"', .x, '"', " is part of yummm.\n", sep=""))
                } else {
                  cat(crayon::red('"', .x, '"', " is not part of yummm.\n", sep=""))
                }
              })
}


# Satisfy RCMD Checks
Color <- Food <- NULL
