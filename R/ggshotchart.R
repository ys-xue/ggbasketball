#'Shot Chart
#'
#' @description Draw a shot chart on court.
#'
#' @details Shot charts helps provide insights when analyzing a player's
#'   strengths and weakness.
#' @param shotdata a data.frame containing the location of shots.
#' @param x,y x and y variables for drawing. x aligns with the wider side of the
#'   court, and should have values between [0, 47]. y aligns with the narrower
#'   side of the court (facing the hoop), and should have values between
#'   [-25, 25], with the hoop corresponding to a y value of 0.
#' @param orientation orientation of the court, defaults to "wide"; options are
#'   "wide" and "tall".
#' @param result optional, if not FALSE, it should point to a column indicating
#'   whether the shot was made or missed. Both point shape and color will be
#'   varied by the result.
#'
#' @seealso \code{\link{court}}
#' @examples
#' # load data, take James Harden's shots as an example
#' data(shotdata)
#' harden <- shotdata[shotdata$Name == "James Harden", ]
#' head(harden)
#' # A Basic Shotchart
#' ggshotchart(harden, x = "loc_x", y = "loc_y")
#'
#' # Change orientation
#' ggshotchart(harden, x = "loc_x", y = "loc_y", orientation = "tall")
#'
#' # vary the color and shape by shot result
#' ggshotchart(harden, x = "loc_x", y = "loc_y", result = "result_str")
#'
#' @export
ggshotchart <- function(shotdata, x, y,
                        orientation = "wide",
                        result = NULL,
                        ...) {

  mapping <- ggpubr::create_aes(list(x = x, y = y, shape = result, col = result), parse = TRUE)

  if (orientation == "tall") {
    temp <- mapping[["x"]]
    mapping[["x"]] <- mapping[["y"]]
    mapping[["y"]] <- temp
  }

  p <- ggcourt(halfcourt = TRUE, orientation = orientation) +
    geom_point(data = shotdata, mapping)
  p
}
