
<!-- README.md is generated from README.Rmd. Please edit that file -->
yummm
=====

Overview
--------

yummm is a package for using the colours of your favourite food items in creating graphics.

Installation
------------

``` r
devtools::install_github("StefanVriend/yummm")
```

Usage
-----

``` r
library(yummm)
yummm("banana")
#> [1] "#FFCF4A"
```

``` r
# Do not run
hist(..., col=yummm("banana"))
```

![](man/figures/README-example-1.png)
