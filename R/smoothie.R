#' @title Delicious smoothies to decorate your graphics
#' @name smoothie
#'
#' @description Use your favourite smoothie to colour your graphics and texts.
#'
#' @param food a character vector representing the ingredients of your smoothie.
#' @param alpha a vector opacity levels, with compatible dimensions to \code{foods}. Each level in [0,1]. Default is \code{1/length(food)}.
#'
#' @return A character string (in hexadecimal format) corresponding to the smoothie created with the food items of your choice.
#'
#' @seealso \code{\link{yummm}}
#'
#' @examples
#' smoothie(c("banana", "kiwi"))
#'
#' @export

smoothie <- function(food, alpha=rep(1/length(food), length(food))) {

  yummm.market %>%
    dplyr::filter(Food %in% food) %>%
    dplyr::select(Colour) %>%
    dplyr::pull(Colour) ->
    colours

  if(sum(alpha) != 1) cat("Error: the alpha levels must sum to 1.")

  if(sum(alpha) == 1) {
    colours.rgb <- t(col2rgb(colours))

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

    if(!any(food %in% food.items == FALSE)) {
      col2hex(c(ceiling(sum(colours.rgb[,1] * alpha)),
                ceiling(sum(colours.rgb[,2] * alpha)),
                ceiling(sum(colours.rgb[,3] * alpha))
      )) -> smoothie

      return(smoothie)
    }
  }

}

# Convert color in RGB (red/green/blue) to hexadecimal format
col2hex <- function(col) {
  paste0("#", paste(toupper(as.hexmode(col)), collapse=""))
}
