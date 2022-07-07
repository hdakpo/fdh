
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
efficiency and revenue efficiency scores. The enumeration algorithms
associated with the minimum and the maximum revenues are as follows:

-   **Minimum Cost**

    -   **Variable Returns to Scale** (vrs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;C_%7Bmin%7D\left(\mathbf%7Bw%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7B\mathbf%7By%7D%5E\circ&space;\leq&space;\mathbf%7By%7D_n%7D\left\lbrace\mathbf%7Bw%7D%5E\circ&space;\mathbf%7Bx%7D_n\right\rbrace)

    -   **Constant Returns to Scale** (crs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;C_%7Bmin%7D\left(\mathbf%7Bw%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\left(\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\right)&space;\cdot&space;\mathbf%7Bw%7D%5E\circ&space;\mathbf%7Bx%7D_n\right\rbrace)

    -   **Nonicreasing Returns to Scale** (nirs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;C_%7Bmin%7D\left(\mathbf%7Bw%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7B\mathbf%7By%7D%5E\circ&space;\leq&space;\mathbf%7By%7D_n%7D\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\left(\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\right)&space;\cdot&space;\mathbf%7Bw%7D%5E\circ&space;\mathbf%7Bx%7D_n\right\rbrace)

    -   **Nondecreasing Returns to Scale** (ndrs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;C_%7Bmin%7D\left(\mathbf%7Bw%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\max&space;\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\left(\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\right),&space;1\right\rbrace\cdot&space;\mathbf%7Bw%7D%5E\circ&space;\mathbf%7Bx%7D_n\right\rbrace)

-   **Maximum Revenue**

    -   **Variable Returns to Scale** (vrs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;R_%7Bmax%7D\left(\mathbf%7Bp%7D%5E\circ,\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7B\mathbf%7Bx%7D%5E\circ&space;\geq&space;\mathbf%7Bx%7D_n%7D\left\lbrace\mathbf%7Bp%7D%5E\circ&space;\mathbf%7By%7D_n\right\rbrace)

    -   **Constant Returns to Scale** (crs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;R_%7Bmax%7D\left(\mathbf%7Bp%7D%5E\circ,\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\min_%7Bk=1,&space;\cdots,&space;K%7D\left(\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right)&space;\cdot&space;\mathbf%7Bp%7D%5E\circ&space;\mathbf%7By%7D_n\right\rbrace)

    -   **Nonicreasing Returns to Scale** (nirs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;R_%7Bmax%7D\left(\mathbf%7Bp%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\min&space;\left\lbrace\displaystyle\min_%7Bk=1,&space;\cdots,&space;K%7D\left(\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right),&space;1\right\rbrace\cdot&space;\mathbf%7Bp%7D%5E\circ&space;\mathbf%7By%7D_n\right\rbrace)

    -   **Nondecreasing Returns to Scale** (ndrs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;R_%7Bmax%7D\left(\mathbf%7Bp%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7B\mathbf%7Bx%7D%5E\circ&space;\geq&space;\mathbf%7Bx%7D_n%7D\left\lbrace\displaystyle\min_%7Bk=1,&space;\cdots,&space;K%7D\left(\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right)&space;\cdot\mathbf%7Bp%7D%5E\circ&space;\mathbf%7By%7D_n\right\rbrace)

Finally, different scaled dominance sets can be obtained for each
observation:

-   **Variable Returns to Scale** (vrs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;\left\lbrace&space;\left(\mathbf%7Bx%7D_n,&space;\mathbf%7By%7D_n\right)&space;%7C&space;\mathbf%7Bx%7D&space;\geq&space;\mathbf%7Bx%7D_n,&space;\mathbf%7By%7D&space;\leq&space;\mathbf%7Bx%7D_n\right\rbrace)

-   **Constant Returns to Scale** (crs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;\left\lbrace&space;\left(\mathbf%7Bx%7D_n,&space;\mathbf%7By%7D_n\right)&space;%7C&space;\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D&space;\leq&space;\displaystyle\min_%7Bk=1,&space;\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace)

-   **Nonicreasing Returns to Scale** (nirs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;\left\lbrace&space;\left(\mathbf%7Bx%7D_n,&space;\mathbf%7By%7D_n\right)&space;%7C&space;\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D&space;\leq&space;1\right\rbrace)

-   **Nondecreasing Returns to Scale** (ndrs)

    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;\left\lbrace&space;\left(\mathbf%7Bx%7D_n,&space;\mathbf%7By%7D_n\right)&space;%7C&space;\displaystyle\min_%7Bk=1,&space;\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D&space;\geq&space;1\right\rbrace)

For large datasets, the `parallel` option can be used to speed up
computations.

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
summary(fdh_in_vrs)
## Minimum cost and cost efficiency (vrs)
fdh_cost_vrs <- costFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]),
wobs = as.matrix(apple[, c('PK', 'PL', 'PM')]), rts = 'vrs')
summary(fdh_cost_vrs)
## Cost efficiency decomposition
fdh_cost_decomp <- costEffDecomp(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]),
wobs = as.matrix(apple[, c('PK', 'PL', 'PM')]))
summary(fdh_cost_decomp)
## Dominance sets under vrs
dlist <- dominFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]), rts = 'vrs')
```
