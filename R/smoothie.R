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

  colors <- purrr::map2(.x = food,
              .y = shade,
              .f = ~{
                yummm_market[[.x]] %>%
                  dplyr::filter(Shade == .y) %>%
                  dplyr::pull(Color)
              }) %>% unlist()

  if(sum(alpha) != 1) cat("Error: the alpha levels must sum to 1.")

  if(sum(alpha) == 1) {
    color_rgb <- t(grDevices::col2rgb(colors))

    if(any(food %in% names(yummm_market) == FALSE)) {
      not_in_yummm <- food[!(food %in% names(yummm_market))]

      purrr::walk(.x = not_in_yummm,
                  .f = ~{
                    cat("Error: ", '"', .x,  '"', " is not part of yummm.\n",
                        "Find out whether your favorite food ",
                        "is part of yummm using in.yummm().\n",
                        sep="")
                  })
    }

    if(!any(food %in% names(yummm_market) == FALSE)) {
      col2hex(c(ceiling(sum(colors_rgb[,1] * alpha)),
                ceiling(sum(colors_rgb[,2] * alpha)),
                ceiling(sum(colors_rgb[,3] * alpha))
      )) -> smoothie

      return(smoothie)
    }
  }

}

# Convert color in RGB (red/green/blue) to hexadecimal format
col2hex <- function(col) {
  paste0("#", paste(toupper(as.hexmode(col)), collapse=""))
}

# Satisfy RCMD Checks
Color <- Food <- NULL
