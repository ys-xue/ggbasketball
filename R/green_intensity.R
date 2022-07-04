#'Shot data for selected players.
#'
#' @description A `data.frame` containing the estimated shooting intensity of
#'   Draymond Green on the offensive half court.
#' @name green_intensity
#' @docType data
#' @usage data("green_intensity")
#' @format a data.frame with columns being: the estimated intensity,
#'   (x, y) locations of rectangle centers over the court, Player name.
#'
#' @references \url{https://onlinelibrary.wiley.com/doi/abs/10.1002/sta4.324}
#'
#' @examples
#' data(green_intensity)
#' ggshotintensity(green_intensity, x = "x", y = "y", value_col = "mean")
#'
NULL
