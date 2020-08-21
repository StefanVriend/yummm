#' @title Fill the yummm market with food palettes
#'
#' @description Fill the yummm market with a 10-color palette extracted from an image of the food. NB: This function is only used internally.
#'
#' @param food Character. Food to be added to the market.
#'
#' @name fill_market
#'
#' @import paletter
#' @import tibble
#' @import usethis
#' @importFrom jpeg readJPEG
#' @importFrom scales show_col
#' @export

fill_market <- function(food) {

  # Create 10-color palette from image
  pal <- paletter::create_palette(image_path=paste0("inst/images/", food, ".jpg"),
                                  number_of_colors = 10,
                                  type_of_variable = "categorical")

  # Select colors and assign them to shades IDs.
  pal_df <- tibble::tibble(Color = pal,
                           Shade = c("01", "02", "03", "04", "05",
                                     "06", "07", "08", "09", "10"))

  # Add to existing yummm_market
  if(file.exists("data/yummm_market.rda")) {

    yummm_market[[food]] <- pal_df

    # Create yummm_market and add food
  } else {

    yummm_market <- list(pal_df)
    names(yummm_market) <- food

  }

  usethis::use_data(yummm_market, overwrite = TRUE)
}


#' @title Create aliases for food names in the yummm market
#'
#' @description Create alias(es) for food names in the yummm market, so that the correct color is printed when a user calls an alias instead of the name under which the food is stored in the yummm market. NB: This function is only used internally.
#'
#' @param food Character. Food as stored in the yummm market.
#' @param alias Character vector. Alias(es) of food.
#'
#' @name create_aliases
#'
#' @export

create_aliases <- function(food, alias) {

  # Error: food not part of yummm.
  if(!(food %in% names(yummm_market))) {

    cat("Error: ", '"', food,  '"', " is ",
        crayon::underline("not"), " part of yummm.\n",
        "Find out whether your favorite food ",
        "is part of yummm using in_yummm().\n",
        sep="")

  }

  # Yummm_aliases already exists
  if(file.exists("data/yummm_aliases.rda")) {

    # Alias is already in use
    if(alias %in% unlist(yummm_aliases)) {

      double <- which(purrr::imap_lgl(.x = yummm_aliases,
                                      .f = ~{

                                        alias %in% .x

                                      }) == TRUE)

      stop(paste0("Alias ", '"', alias, '"', " is already in use for ",
                  names(yummm_aliases)[double]))

    }

    # Second alias for already existing food in yummm_aliases
    if(food %in% names(yummm_aliases)) {

      alias <- c(yummm_aliases[[food]], alias)
      yummm_aliases[[food]] <- alias

      # First alias for new food in yummm_aliases
    } else {

      yummm_aliases[[food]] <- alias

    }

    usethis::use_data(yummm_aliases, overwrite = TRUE)

    # First-time creation of yummm_aliases
  } else {

    yummm_aliases <- list(alias)
    names(yummm_aliases) <- food

    usethis::use_data(yummm_aliases)

  }
}
