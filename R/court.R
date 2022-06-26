#'Polygon to draw the basketball court.
#'
#' @description A `data.frame` containing the lines and circles used to draw
#'   a basketball court.
#' @name court
#' @docType data
#' @usage data("court")
#' @format A data frame with 6548 rows and 5 columns.
#' @references https://egallic.fr/en/drawing-a-basketball-court-with-r/
#'
#' @examples
#' data(court)
#' # Default plot
#'ggplot(court, aes(x = x, y = y, group = group)) + geom_polygon() + coord_fixed()
NULL
