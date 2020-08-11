#' @title Visualize the color palette of the food of your choice
#'
#' @description Visualization of the 10-color palette of your favorite food.
#'
#' @param food a character vector representing the food of your choice.
#'
#' @return A character string (in hexadecimal format) corresponding to the food of your choice.
#'
#' @seealso \code{\link{in.yummm}}
#'
#' @examples
#' yummm.palette("banana")
#'
#' @import shades
#' @import ggplot2
#' @import stringr
#' @export

yummm.palette <- function(food) {

  df <- yummm.market[[food]] %>%
    dplyr::mutate(N = 1,
                  TextCol = ifelse(shades::lightness(Col) > 70, "black", "white"),
                  Bar = rep(1:(length(Col) / 2), each = 2))

  extrafont::loadfonts(device = "win")

  ggplot2::ggplot(df, ggplot2::aes(x = Bar, fill = ColID, y = N)) +
    ggplot2::geom_bar(stat = "identity", position = "stack", width = 1) +
    ggplot2::scale_fill_manual(values = df$Col) +
    ggplot2::geom_text(ggplot2::aes(label = stringr::str_sub(Col, 2, 7), colour = Col), size = 5,
                       family = "Nunito", fontface = "bold",
                       position = ggplot2::position_stack(vjust = 0.9)) +
    ggplot2::geom_text(ggplot2::aes(label = ColID, colour = ColID), size = 3,
                       family = "Nunito", fontface = "italic",
                       position = ggplot2::position_stack(vjust = 0.8)) +
    ggplot2::scale_colour_manual(values = rep(df$TextCol, 2)) +
    ggplot2::theme_void() +
    ggplot2::labs(title = paste0(toupper(stringr::str_sub(food, 1, 1)),
                                 stringr::str_sub(food, 2, -1L)),
                  subtitle = "A 10-colour yummm palette") +
    ggplot2:: theme(legend.position = "none",
                    plot.title = ggplot2::element_text(hjust = 0.5,
                                                       family = "Roboto Slab", face = "bold"),
                    plot.subtitle = ggplot2::element_text(hjust = 0.5,
                                                          family = "Roboto", face = "italic"))

}
