#'A Heatmap-type Visualization of Shot Intensity
#'
#' @description Draw a heatmap on the court visualizing shot intensities.
#'
#' @details Shot intensity plots help us identify the strengths and weaknesses
#'   of players. It is often a summary of the shotchart, either using raw
#'   counts, or model-based estimated values.
#' @param intensity a `data.frame` with at least three columns. They should
#'   be the (x,y) locations of the center of each rectangle in the grid, and the
#'   corresponding (estimated) intensity values on the rectangle.
#' @param breaks if there are too many intensity values, for ease of
#'   visualization, it is often better to break them into separate buckets. If
#'   not specified, defaults to around 10.
#' @param palette optional color palette. If not specified, defaults to be based
#'   on `Blues` in \code{RColorBrewer}
#' @param x column name for horizontal locations of rectangle centers
#' @param y column name for vertical locations of rectangle centers
#' @param value_col name of the column that contains the intensity values
#' @param color color for the boundary of contours, defaults to black.
#' @param orientation orientation of court, defaults to "wide"
#' @param label_name legend label in the final plot.
#'
#' @importFrom grDevices colorRampPalette
#' @importFrom stats quantile
#' @importFrom RColorBrewer brewer.pal
#' @import ggplot2
#' @import ggpubr
#' @seealso \code{\link{court}}
#' @examples
#' # load data, take Draymond Green's LGCP estimated intensity as an example.
#' data(green_intensity)
#'
#' ggshotintensity(green_intensity, x = "x", y = "y", value_col = "mean")
#'
#' @export
ggshotintensity <- function(intensity, breaks = NULL, palette = NULL,
                            x, y, value_col, color = "black",
                            orientation = "wide",
                            label_name = NULL){
  if (is.null(breaks)) {
    breaks <- unique(round(quantile(intensity[, value_col] + 0.01,
                                    probs = seq(0, 10)/10), 2))
  }
  breaks <- unique(c(c(-1, 0), breaks))
  if (is.null(label_name)) {
    label_name <- "Intensity"
  }

  # intensity[, label_name] <- cut(intensity[, value_col], breaks = breaks)
  court_mapping <- ggpubr::create_aes(list(x = "y", y = "x", group = "group"))
  mapping <-
    ggpubr::create_aes(list(
      x = x
      ,y = y
      ,z = value_col
    ), parse = TRUE)
  # if orientation is tall, swap the mapping
  if (orientation == "tall") {
    temp <- mapping[["x"]]
    mapping[["x"]] <- mapping[["y"]]
    mapping[["y"]] <- temp

    temp <- court_mapping[["x"]]
    court_mapping[["x"]] <- court_mapping[["y"]]
    court_mapping[["y"]] <- temp
  }

  if (is.null(palette)) {
    palette <- colorRampPalette(RColorBrewer::brewer.pal(9, "Blues"))(length(breaks) - 1)
  }

  p <- ggplot() + geom_contour_filled(data = intensity, mapping = mapping,
                                         breaks = breaks, color = color, size = 0.2)  +
    geom_polygon(data = court[court$y <= 47,], mapping = court_mapping) +
    scale_fill_manual(values = palette) +
    coord_fixed() + ggpubr::theme_pubr(border = TRUE) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    xlab("") + ylab("") +
    theme(axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank()) +
    labs(fill = label_name)
  p
}

