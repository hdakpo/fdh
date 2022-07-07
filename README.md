
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fdh: A package for estimating nonconvex frontier models

<!-- badges: start -->
<!-- badges: end -->

*fdh* provides simple ways, using enumeration algorithms, for estimating
different Farrell distance function under different returns to scale
assumptions:

-   **Input Technical Efficiency**
    -   **Variable Returns to Scale** (vrs)

<!-- $$e^{i \pi} = -1$$ -->

<div align="center">

<img style="background: white;" src="https://latex.codecogs.com/svg.latex?">

</div>

-   **Output Technical Efficiency**
-   **Graph Technical Efficiency**

Efficiency scores are obtained by imposing different returns to scale
assumptions: - **Constant Returns to Scale** (crs) - **Nondecreasing
Returns to Scale** (ndrs) - **Nonicreasing Returns to Scale** (nirs) -
**Variable Returns to Scale** (vrs)

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
