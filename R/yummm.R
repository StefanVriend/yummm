#' @title Delicious colors to decorate your graphics
#' @name yummm
#'
#' @description Use your favorite food to color your graphics and texts.
#'
#' @param food Character vector. Food of your choice.
#' @param shade Character vector. Shade of your food of choice. Possible id's: "01":"10".
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
#' @importFrom crayon underline red cyan
#' @import dplyr
#' @import purrr
#' @export

yummm <- function(food, shade) {

  # Missing shades, set to "01".
  if(missing(shade)) {

    shade <- rep("01", length(food))
    cat("Shade is set to '01'. If you want a different shade, use yummm_palette() to pick your favorite.\n")

  }

  # Impossible shade ID
  if(any(!(shade %in% c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10")))) {

    cat("Yummm palettes contain 10 colours. Please select a different ID.\n")

  }

  # Error if food is not part of yummm.
  if(any(food %in% names(yummm_market) == FALSE)
     & any(food %in% unlist(yummm_aliases)) == FALSE) {
    not_in_yummm <- food[!(food %in% names(yummm_market))]

    purrr::walk(.x = not_in_yummm,
                .f = ~{
                  cat("Error: ", '"', .x,  '"', " is ",
                      crayon::underline("not"), " part of yummm.\n",
                      "Find out whether your favorite food ",
                      "is part of yummm using in_yummm().\n",
                      sep="")
                })


  } else {

    # Print color
    purrr::map2(.x = food,
                .y = shade,
                .f = ~{

                  # Alias color
                  if(.x %in% unlist(yummm_aliases)) {

                    alias <- .x
                    double <- which(purrr::imap_lgl(.x = yummm_aliases,
                                                    .f = ~{

                                                      alias %in% .x

                                                    }) == TRUE)
                    yummm_market[[names(yummm_aliases)[double]]] %>%
                      dplyr::filter(Shade == .y) %>%
                      dplyr::pull(Color)

                    # Market color
                  } else {

                    yummm_market[[.x]] %>%
                      dplyr::filter(Shade == .y) %>%
                      dplyr::pull(Color)

                  }

                }) %>% unlist()

  }
}


#' @title Is this food part of yummm?
#' @name in_yummm
#'
#' @description Find out whether your favorite food is part of the `yummm` package.
#'
#' @param food Character vector. Food of your choice.
#'
#' @examples
#' in_yummm("banana")
#'
#' @export

in_yummm <- function(food) {

  purrr::walk(.x = food,
              .f = ~{

                part_of_market <- .x %in% names(yummm_market)
                part_of_aliases <- .x %in% unlist(yummm_aliases)

                if(part_of_market == TRUE) {

                  cat(crayon::cyan('"', .x, '"', " is part of yummm :)\n", sep=""))

                } else if(part_of_aliases == TRUE) {

                  alias <- .x
                  double <- which(purrr::imap_lgl(.x = yummm_aliases,
                                                  .f = ~{

                                                    alias %in% .x

                                                  }) == TRUE)

                  cat(crayon::cyan('"', .x, '"', " is part of yummm as an alias for ",
                                   '"', names(yummm_aliases)[double], '".\n', sep=""))

                } else {

                  cat(crayon::red('"', .x, '"', " is not part of yummm :(\n", sep=""))

                }
              })
}


# Satisfy RCMD Checks
Color <- Food <- NULL
