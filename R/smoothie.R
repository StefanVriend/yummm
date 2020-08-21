#' @title Delicious smoothies to decorate your graphics
#' @name smoothie
#'
#' @description Use your favorite smoothie to color your graphics and texts.
#'
#' @param food Character vector. Ingredients of your smoothie.
#' @param shade Character vector. Shade of your food of choice. Possible id's: "01":"10". Default is set to "01".
#' @param alpha Numeric vector. Opacity levels of ingredients of your smoothie. Each value in [0,1]. Default is \code{1/length(food)}.
#'
#' @return A character string (in hexadecimal format) corresponding to the smoothie created with the food of your choice.
#'
#' @seealso \code{\link{yummm}}
#'
#' @examples
#' smoothie(c("banana", "kiwi"))
#'
#' smoothie(c("banana", "kiwi"), alpha=c(0.4, 0.6))
#'
#' @importFrom grDevices col2rgb
#' @export

smoothie <- function(food, shade = rep("01", length(food)),
                     alpha=rep(1/length(food), length(food))) {

  if(sum(alpha) != 1) stop(paste("Error: the alpha levels must sum to 1."))

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

    colors <- purrr::map2(.x = food,
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

    colors_rgb <- t(grDevices::col2rgb(colors))

    smoothie <- col2hex(c(ceiling(sum(colors_rgb[,1] * alpha)),
                          ceiling(sum(colors_rgb[,2] * alpha)),
                          ceiling(sum(colors_rgb[,3] * alpha))))

    return(smoothie)

  }
}

# Convert color in RGB (red/green/blue) to hexadecimal format
col2hex <- function(col) {
  paste0("#", paste(toupper(as.hexmode(col)), collapse=""))
}

# Satisfy RCMD Checks
Color <- Food <- NULL
