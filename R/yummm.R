#' @title Delicious colors to decorate your graphics
#' @name yummm
#'
#' @description Use your favorite food to color your graphics and texts.
#'
#' @param food a character vector representing the food of your choice.
#' @param shade a character vector representing the shade of your food of choice. Possible id's: "01":"10".
#'
#' @details Use \code{yummm_palette} to visualize all the shades of the food of your choice.
#'
#' @return A character string (in hexadecimal format) corresponding to the food of your choice.
#'
#' @seealso \code{\link{in_yummm}}
#'
#' @examples
#' yummm(food = "banana", shade = "05")
#'
#' @import crayon
#' @import dplyr
#' @import purrr
#' @export

yummm <- function(food, shade) {

  if(any(food %in% names(yummm_market) == FALSE)) {
    not_in_yummm <- food[!(food %in% names(yummm_market))]

    purrr::walk(.x = not_in_yummm,
                .f = ~{
                  cat("Error: ", '"', .x,  '"', " is ",
                      crayon::underline("not"), " part of yummm.\n",
                      "Find out whether your favorite food ",
                      "is part of yummm using in_yummm().\n",
                      sep="")
                })

  } else if(missing(shade)) {

    shade <- rep("01", length(food))
    cat("Shade is set to '01'. If you want a different shade, use yummm_palette() to pick your favorite.")

  } else if(any(shade > 10)) {

    cat("Yummm palettes contain 10 colours. Please select a lower ID.")

  } else {

    purrr::map2(.x = food,
                .y = shade,
                .f = ~{
                  yummm_market[[.x]] %>%
                    dplyr::filter(Shade == .y) %>%
                    dplyr::pull(Color)
                }) %>% unlist()
  }

}


#' @title Is this food part of yummm?
#' @name in_yummm
#'
#' @description Find out whether your favorite food is part of the `yummm` package.
#'
#' @examples
#' in_yummm("banana")
#'
#' @return Logical, TRUE or FALSE
#'
#' @inheritParams yummm
#'
#' @export
#'

in_yummm <- function(food) {

  purrr::walk(.x = food,
              .f = ~{
                part_of_yummm <- .x %in% names(yummm_market)
                if(part_of_yummm == TRUE) {
                  cat(crayon::cyan('"', .x, '"', " is part of yummm :)\n", sep=""))
                } else {
                  cat(crayon::red('"', .x, '"', " is not part of yummm :(\n", sep=""))
                }
              })
}


# Satisfy RCMD Checks
Color <- Food <- NULL
