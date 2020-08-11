#' @title Delicious smoothies to decorate your graphics
#' @name smoothie
#'
#' @description Use your favorite smoothie to color your graphics and texts.
#'
#' @param food a character vector representing the ingredients of your smoothie.
#' @param id a character vector representing the shade of your food of choice. Possible id's: "01":"10". Default is set to "01".
#' @param alpha a vector opacity levels, with compatible dimensions to \code{foods}. Each level in [0,1]. Default is \code{1/length(food)}.
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

smoothie <- function(food, id = rep("01", length(food)),
                     alpha=rep(1/length(food), length(food))) {

  colors <- purrr::map2(.x = food,
              .y = id,
              .f = ~{
                yummm_market[[.x]] %>%
                  dplyr::filter(ColID == .y) %>%
                  dplyr::pull(Col)
              }) %>% unlist()

  if(sum(alpha) != 1) cat("Error: the alpha levels must sum to 1.")

  if(sum(alpha) == 1) {
    colors.rgb <- t(grDevices::col2rgb(colors))

    if(any(food %in% names(yummm_market) == FALSE)) {
      not.in.yummm <- food[!(food %in% names(yummm_market))]

      purrr::walk(.x = not.in.yummm,
                  .f = ~{
                    cat("Error: ", '"', .x,  '"', " is not part of yummm.\n",
                        "Find out whether your favorite food ",
                        "is part of yummm using in.yummm().\n",
                        sep="")
                  })
    }

    if(!any(food %in% names(yummm_market) == FALSE)) {
      col2hex(c(ceiling(sum(colors.rgb[,1] * alpha)),
                ceiling(sum(colors.rgb[,2] * alpha)),
                ceiling(sum(colors.rgb[,3] * alpha))
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
