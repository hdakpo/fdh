
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fdh: A package for estimating nonconvex frontier models

<!-- badges: start -->

[![CodeFactor](https://www.codefactor.io/repository/github/hdakpo/fdh/badge)](https://www.codefactor.io/repository/github/hdakpo/fdh)
[![](https://img.shields.io/github/languages/code-size/hdakpo/fdh.svg)](https://github.com/hdakpo/fdh)
[![](https://img.shields.io/badge/devel%20version-0.1.0.900-darkred.svg)](https://github.com/hdakpo/fdh)
[![R build
status](https://github.com/hdakpo/fdh/workflows/R-CMD-check/badge.svg)](https://github.com/hdakpo/fdh/actions)
<!-- [![CRAN status](https://www.r-pkg.org/badges/version/fdh)](https://CRAN.R-project.org/package=pfdh) -->
<!-- [![Downloads](https://cranlogs.r-pkg.org/badges/fdh)](https://CRAN.R-project.org/package=fdh) -->
<!-- badges: end -->

*fdh* provides simple ways, using enumeration algorithms, for estimating
different Farrell distance function under different returns to scale
assumptions:

-   **Input Technical Efficiency**

    -   **Variable Returns to Scale** (vrs)

    <span style="color: green"> check </span>

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_i\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle&space;\min_%7B\mathbf%7By%7D%5E\circ&space;\leq&space;\mathbf%7By%7D_n%7D&space;\displaystyle&space;\max_%7Bk=1,\cdots,&space;K%7D&space;\left\lbrace&space;\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D&space;\right\rbrace)

    -   **Constant Returns to Scale** (crs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_i&space;\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)&space;=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\max_%7Bk=1,\cdots,&space;K%7D&space;\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D\cdot\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\right\rbrace)

    -   **Nonicreasing Returns to Scale** (nirs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_i\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7B\mathbf%7By%7D%5E\circ&space;\leq&space;\mathbf%7By%7D_n%7D\left\lbrace\displaystyle\max_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D\cdot\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\right\rbrace)

    -   **Nondecreasing Returns to Scale** (ndrs)

    ![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;E_i\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\max_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D\cdot&space;\max&space;\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D,&space;1\right\rbrace\right\rbrace)

-   **Output Technical Efficiency**

    -   **Variable Returns to Scale** (vrs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_o\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7B\mathbf%7Bx%7D%5E\circ&space;\geq&space;\mathbf%7Bx%7D_n%7D\displaystyle\min_%7Bq=1,\cdots,&space;Q%7D\left\lbrace\frac%7By_%7Bqn%7D%7D%7By_q%5E\circ%7D\right\rbrace)

    -   **Constant Returns to Scale** (crs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_o\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)&space;=\displaystyle\max_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\min_%7Bq=1,\cdots,&space;Q%7D\frac%7By_%7Bqn%7D%7D%7By_q%5E\circ%7D\cdot\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace)

    -   **Nonicreasing Returns to Scale** (nirs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_o\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\min_%7Bq=1,\cdots,&space;Q%7D\frac%7By_%7Bqn%7D%7D%7By_q%5E\circ%7D\cdot&space;\min&space;\left\lbrace\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D,&space;1\right\rbrace\right\rbrace)

    -   **Nondecreasing Returns to Scale** (ndrs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_o\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7B\mathbf%7Bx%7D%5E\circ&space;\geq&space;\mathbf%7Bx%7D_n%7D&space;\left\lbrace\displaystyle\min_%7Bq=1,\cdots,&space;Q%7D&space;\frac%7By_%7Bqn%7D%7D%7By_q%5E\circ%7D\cdot\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace)

-   **Graph Technical Efficiency**

For this orientation, let’s first define:

![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;\delta&space;=&space;\left(\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D&space;\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D&space;\cdot&space;\displaystyle\min_%7Bk=1,\cdots,&space;K%7D&space;\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right)%5E%7B1/2%7D)

-   **Variable Returns to Scale** (vrs)

![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\max\left(\displaystyle\max_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D,\displaystyle\max_%7Bq=1,\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\right)\right\rbrace)

-   **Constant Returns to Scale** (crs)

![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)&space;=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\Big/\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace%5E%7B1/2%7D)

-   **Nonicreasing Returns to Scale** (nirs)

If
![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;\delta&space;\leq&space;1)

![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)&space;=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\Big/\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace%5E%7B1/2%7D)

Else

![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,\mathbf%7By%7D%5E\circ\right)&space;=&space;\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D\left\lbrace\max\left%5B\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D,&space;\left(\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right)%5E%7B-1%7D&space;\right%5D\right\rbrace)

-   **Nondecreasing Returns to Scale** (ndrs)

If
![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;\delta&space;\geq&space;1)

![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)&space;=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\Big/\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace%5E%7B1/2%7D)

Else

![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,\mathbf%7By%7D%5E\circ\right)&space;=&space;\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D\left\lbrace\max\left%5B\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D,&space;\left(\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right)%5E%7B-1%7D&space;\right%5D\right\rbrace)

*fdh* also offers the possiblity of estimating the minimum cost as well
as the maximum revenue in addition to their corresponding cost
efficiency and revenue efficiency scores.

For large datasets, the `parallel` can be used to speed up computations.

## Installation

You can install the development version of fdh from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hdakpo/fdh")
```

## Example

This subsection provides set of examples introducing some important
features of *fdh*.

``` r
library(fdh)
data(apple)
## Input technical efficiency (vrs)
fdh_in_vrs <- distFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]), rts = 'vrs', orientation = 'in')
#> Le chargement a nécessité le package : foreach
#> Le chargement a nécessité le package : future
#> Warning: UNRELIABLE VALUE: One of the foreach() iterations ('doFuture-1')
#> unexpectedly generated random numbers without declaring so. There is a risk
#> that those random numbers are not statistically sound and the overall results
#> might be invalid. To fix this, use '%dorng%' from the 'doRNG' package instead
#> of '%dopar%'. This ensures that proper, parallel-safe random numbers are
#> produced via the L'Ecuyer-CMRG method. To disable this check, set option
#> 'doFuture.rng.onMisuse' to "ignore".
summary(fdh_in_vrs)
#>   Efficiencies      Benchmarks   
#>  Min.   :0.3590   Min.   :  3.0  
#>  1st Qu.:0.7111   1st Qu.:102.0  
#>  Median :0.9600   Median :234.0  
#>  Mean   :0.8474   Mean   :216.2  
#>  3rd Qu.:1.0000   3rd Qu.:316.0  
#>  Max.   :1.0000   Max.   :405.0
## Minimum cost and cost efficiency (vrs)
fdh_cost_vrs <- costFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]),
wobs = as.matrix(apple[, c('PK', 'PL', 'PM')]), rts = 'vrs')
#> Warning: UNRELIABLE VALUE: One of the foreach() iterations ('doFuture-1')
#> unexpectedly generated random numbers without declaring so. There is a risk
#> that those random numbers are not statistically sound and the overall results
#> might be invalid. To fix this, use '%dorng%' from the 'doRNG' package instead
#> of '%dopar%'. This ensures that proper, parallel-safe random numbers are
#> produced via the L'Ecuyer-CMRG method. To disable this check, set option
#> 'doFuture.rng.onMisuse' to "ignore".
summary(fdh_cost_vrs)
#>     CostEff          CostMin           Benchmarks   
#>  Min.   :0.1337   Min.   :  150113   Min.   :  4.0  
#>  1st Qu.:0.4359   1st Qu.:  374211   1st Qu.: 98.0  
#>  Median :0.6024   Median :  589629   Median :206.0  
#>  Mean   :0.6294   Mean   : 1160906   Mean   :212.8  
#>  3rd Qu.:0.8551   3rd Qu.: 1040739   3rd Qu.:316.0  
#>  Max.   :1.0000   Max.   :13448388   Max.   :400.0
## Cost efficiency decomposition
fdh_cost_decomp <- costEffDecomp(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]),
wobs = as.matrix(apple[, c('PK', 'PL', 'PM')]))
#> Warning: UNRELIABLE VALUE: One of the foreach() iterations ('doFuture-1')
#> unexpectedly generated random numbers without declaring so. There is a risk
#> that those random numbers are not statistically sound and the overall results
#> might be invalid. To fix this, use '%dorng%' from the 'doRNG' package instead
#> of '%dopar%'. This ensures that proper, parallel-safe random numbers are
#> produced via the L'Ecuyer-CMRG method. To disable this check, set option
#> 'doFuture.rng.onMisuse' to "ignore".
summary(fdh_cost_decomp)
#>        TE              SCE               OTE                AE        
#>  Min.   :0.3590   Min.   :0.07886   Min.   :0.04859   Min.   :0.2526  
#>  1st Qu.:0.7111   1st Qu.:0.48262   1st Qu.:0.33893   1st Qu.:0.5296  
#>  Median :0.9600   Median :0.67437   Median :0.55794   Median :0.6758  
#>  Mean   :0.8474   Mean   :0.66366   Mean   :0.58205   Mean   :0.6589  
#>  3rd Qu.:1.0000   3rd Qu.:0.85979   3rd Qu.:0.81492   3rd Qu.:0.7943  
#>  Max.   :1.0000   Max.   :1.00000   Max.   :1.00000   Max.   :1.0000  
#>        OE         
#>  Min.   :0.03933  
#>  1st Qu.:0.21420  
#>  Median :0.33897  
#>  Mean   :0.37842  
#>  3rd Qu.:0.50897  
#>  Max.   :1.00000
## Dominance sets under vrs
dlist <- dominFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]), rts = 'vrs')
#> Warning: UNRELIABLE VALUE: One of the foreach() iterations ('doFuture-1')
#> unexpectedly generated random numbers without declaring so. There is a risk
#> that those random numbers are not statistically sound and the overall results
#> might be invalid. To fix this, use '%dorng%' from the 'doRNG' package instead
#> of '%dopar%'. This ensures that proper, parallel-safe random numbers are
#> produced via the L'Ecuyer-CMRG method. To disable this check, set option
#> 'doFuture.rng.onMisuse' to "ignore".
```
