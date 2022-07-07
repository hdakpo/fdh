
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fdh: A package for estimating nonconvex frontier models

<!-- badges: start -->
<!-- badges: end -->

*fdh* provides simple ways, using enumeration algorithms, for estimating
different Farrell distance function under different returns to scale
assumptions:

-   **Input Technical Efficiency**

    -   **Variable Returns to Scale** (vrs)
        ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_i\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle&space;\min_%7B\mathbf%7By%7D%5E\circ&space;\leq&space;\mathbf%7By%7D_n%7D&space;\displaystyle&space;\max_%7Bk=1,\cdots,&space;K%7D&space;\left\lbrace&space;\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D&space;\right\rbrace)
    -   **Constant Returns to Scale** (crs)
        ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_i&space;\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)&space;=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\max_%7Bk=1,\cdots,&space;K%7D&space;\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D\cdot\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\right\rbrace)
    -   **Nonicreasing Returns to Scale** (nirs)
        ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_i\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7B\mathbf%7By%7D%5E\circ&space;\leq&space;\mathbf%7By%7D_n%7D\left\lbrace\displaystyle\max_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D\cdot\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\right\rbrace)
    -   **Nondecreasing Returns to Scale** (ndrs)
        ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_i\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D'&space;\left\lbrace\displaystyle%7Bk=1,\cdots,&space;K%7D%7B\max%7D\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D\cdot&space;\max&space;\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D,&space;1\right\rbrace\right\rbrace)

-   **Output Technical Efficiency**

    -   **Variable Returns to Scale** (vrs)
        ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_o\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7B\mathbf%7Bx%7D%5E\circ&space;\geq&space;\mathbf%7Bx%7D_n%7D\displaystyle\min_%7Bq=1,\cdots,&space;Q%7D\left\lbrace\frac%7By_%7Bqn%7D%7D%7By_q%5E\circ%7D\right\rbrace)
    -   **Constant Returns to Scale** (crs)
        ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_o\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)&space;=\displaystyle\max_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\min_%7Bq=1,\cdots,&space;Q%7D\frac%7By_%7Bqn%7D%7D%7By_q%5E\circ%7D\cdot\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace)
    -   **Nonicreasing Returns to Scale** (nirs)
        ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_o\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\min_%7Bq=1,\cdots,&space;Q%7D\frac%7By_%7Bqn%7D%7D%7By_q%5E\circ%7D\cdot&space;\min&space;\left\lbrace\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D,&space;1\right\rbrace\right\rbrace)
    -   **Nondecreasing Returns to Scale** (ndrs)
        ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_o\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\max_%7B\mathbf%7Bx%7D%5E\circ&space;\geq&space;\mathbf%7Bx%7D_n%7D&space;\left\lbrace\displaystyle\min_%7Bq=1,\cdots,&space;Q%7D&space;\frac%7By_%7Bqn%7D%7D%7By_q%5E\circ%7D\cdot\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace)

-   **Graph Technical Efficiency** For this orientation, let’s first
    define:
    ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;\delta&space;=&space;\left(\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D&space;\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D&space;\cdot&space;\displaystyle\min_%7Bk=1,\cdots,&space;K%7D&space;\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right)%5E%7B1/2%7D)

    -   **Variable Returns to Scale** (vrs)
        ![equation](https://latex.codecogs.com/svg.image?\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\max\left(\displaystyle\max_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_%7Bkn%7D%7D%7Bx_k%5E\circ%7D,\displaystyle\max_%7Bq=1,\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\right)\right\rbrace)
    -   **Constant Returns to Scale** (crs)
        ![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)&space;=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\Big/\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace%5E%7B1/2%7D)
    -   **Nonicreasing Returns to Scale** (nirs) If
        ![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;\delta&space;\leq&space;1)

    ![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,&space;\mathbf%7By%7D%5E\circ\right)&space;=\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D&space;\left\lbrace\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D\Big/\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right\rbrace%5E%7B1/2%7D)

    Else

    ![equation](https://latex.codecogs.com/svg.image?\inline&space;\large&space;\color%7Bwhite%7D&space;E_%7BGR%7D\left(\mathbf%7Bx%7D%5E\circ,\mathbf%7By%7D%5E\circ\right)&space;=&space;\displaystyle\min_%7Bn=1,&space;\cdots,&space;N%7D\left\lbrace\max\left%5B\displaystyle\max_%7Bq=1,&space;\cdots,&space;Q%7D\frac%7By_q%5E\circ%7D%7By_%7Bqn%7D%7D,&space;\left(\displaystyle\min_%7Bk=1,\cdots,&space;K%7D\frac%7Bx_k%5E\circ%7D%7Bx_%7Bkn%7D%7D\right)%5E%7B-1%7D&space;\right%5D\right\rbrace)

    -   **Nondecreasing Returns to Scale** (ndrs) If
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
