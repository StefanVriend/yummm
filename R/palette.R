#' @title Visualize the color palette of the food of your choice
#'
#' @description Visualization of the 10-color palette of your favorite food.
#'
#' @param food Character vector. Food of your choice.
#' @param load_fonts TRUE or FALSE. Load fonts to be used in visualisation. Default: FALSE.
#'
#' @return A character string (in hexadecimal format) corresponding to the food of your choice.
#'
#' @seealso \code{\link{in.yummm}}
#'
#' @examples
#' yummm_palette("banana")
#'
#' @import shades
#' @import ggplot2
#' @import stringr
#' @importFrom extrafont loadfonts
#' @export

yummm_palette <- function(food, load_fonts = FALSE) {

  # Select palette
  df <- yummm_market[[food]] %>%
    dplyr::mutate(N = 1,
                  TextColor = ifelse(shades::lightness(Color) > 55, "black", "white"),
                  Bar = rep(1:(length(Color) / 2), each = 2))

  # Load Windows fonts
  if(load_fonts) extrafont::loadfonts(device = "win")

  # Plot palette
  ggplot2::ggplot(df, ggplot2::aes(x = Bar, fill = Shade, y = N)) +
    ggplot2::geom_bar(stat = "identity", position = position_stack(reverse=T), width = 1) +
    ggplot2::scale_fill_manual(values = df$Color) +
    ggplot2::geom_text(ggplot2::aes(label = stringr::str_sub(Color, 2, 7), colour = Shade),
                       size = 5, family = "Nunito", fontface = "bold",
                       position = ggplot2::position_stack(vjust = 0.9, reverse=T)) +
    ggplot2::geom_text(ggplot2::aes(label = Shade, colour = Shade), size = 3,
                       family = "Nunito", fontface = "italic",
                       position = ggplot2::position_stack(vjust = 0.8, reverse=T)) +
    ggplot2::scale_colour_manual(values = rep(df$TextColor, 2)) +
    ggplot2::theme_void() +
    ggplot2::labs(title = paste0(toupper(stringr::str_sub(food, 1, 1)),
                                 stringr::str_sub(food, 2, -1L)),
                  subtitle = "A yummm palette") +
    ggplot2:: theme(legend.position = "none",
                    plot.title = ggplot2::element_text(hjust = 0.5,
                                                       family = "Roboto Slab", face = "bold"),
                    plot.subtitle = ggplot2::element_text(hjust = 0.5,
                                                          family = "Roboto", face = "italic"))

}
