#'Basketball Court
#'
#' @description Draw a base basketball court.
#'
#' @details This only plots a plain court without any labels or ticks.
#' @param orientation orientation of the plot, can be "wide" (default) or "tall".
#' @param halfcourt boolean. If TRUE, only draws a half court.
#' @param ... other arguments to be passed
#' @import ggplot2
#' @import ggpubr
#'
#' @seealso \code{\link{court}}
#' @examples
#' ggcourt(orientation = "wide")
#'
#' @export
ggcourt <- function(orientation = "wide",
                    halfcourt = FALSE,
                    ...) {
  if (!(orientation %in% c("wide", "tall"))) {
    stop("Wrong graph orientation. Choose one of wide or tall")
  }
  if (halfcourt) {
    court <- court[court$y <= 47,]
  }

  p <- ggplot(court) +
    coord_fixed() + theme_pubr(border = TRUE) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    xlab("") + ylab("") +
    theme(axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank())
  if (orientation == "wide") {
    p <- p + geom_polygon(aes(x = y, y = x, group = group))
  } else {
    p <- p + geom_polygon(aes(x = x, y = y, group = group))
  }
  p
}
