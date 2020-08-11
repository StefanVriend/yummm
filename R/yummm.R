#' @title Delicious colors to decorate your graphics
#' @name yummm
#'
#' @description Use your favorite food to color your graphics and texts.
#'
#' @param food a character vector representing the food of your choice.
#' @param id a character vector representing the shade of your food of choice. Possible id's: "01":"10".
#'
#' @details Use \code{yummm.palette} to visualize all the shades of the food of your choice.
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

yummm <- function(food, id) {

  if(any(food %in% names(yummm_market) == FALSE)) {
    not.in.yummm <- food[!(food %in% names(yummm_market))]

    purrr::walk(.x = not.in.yummm,
                .f = ~{
                  cat("Error: ", '"', .x,  '"', " is ",
                      crayon::underline("not"), " part of yummm.\n",
                      "Find out whether your favorite food ",
                      "is part of yummm using in.yummm().\n",
                      sep="")
                })

  } else if(missing(id)) {

    cat("Please select your favourite shade using yummm.palette().")

  } else if(any(id > 10)) {

    cat("Yummm palettes contain 10 colours. Please select a lower ID.")

  } else {

    purrr::map2(.x = food,
                .y = id,
                .f = ~{
                  yummm_market[[.x]] %>%
                    dplyr::filter(ColID == .y) %>%
                    dplyr::pull(Col)
                }) %>% unlist()
  }

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
                part.of.yummm <- .x %in% names(yummm_market)
                if(part.of.yummm == TRUE) {
                  cat(crayon::cyan('"', .x, '"', " is part of yummm :)\n", sep=""))
                } else {
                  cat(crayon::red('"', .x, '"', " is not part of yummm :(\n", sep=""))
                }
              })
}


# Satisfy RCMD Checks
Color <- Food <- NULL
