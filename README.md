# ggbasketball: 'ggplot2' Based Visualization of Basketball Data

This package provides easy plotting for basketball data.

## Installation

Install from Github:

``` r
if(!require(devtools)) install.packages("devtools")
devtools::install_github("ys-xue/ggbasketball")
```

## Court

``` r
ggcourt(orientation = "wide")
```

![](tools/README-ggbasketball-1.png)

## Shotchart

```r
# simple shot chart
data(shotdata)
harden <- shotdata[shotdata$Name == "James Harden", ]
ggshotchart(harden, x = "loc_x", y = "loc_y")
```
![](tools/README-ggbasketball-2.png)

```r
#' # vary the color and shape by shot result
#' ggshotchart(harden, x = "loc_x", y = "loc_y", result = "result_str")
```
![](tools/README-ggbasketball-3.png)

## Intensity Plot

```r
# with contours
ggshotintensity(green_intensity, x = "x", y = "y", value_col = "mean")
```
![](tools/README-ggbasketball-4.png)
