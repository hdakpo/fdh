################################################################################
#                                                                              #
# fdh package doc                                                              #
#                                                                              #
################################################################################

#------------------------------------------------------------------------------#
# fdh package overview                                                         #
# Models: - Farrell distance functions                                         #
#         - Cost Minimization                                                  #
#         - Revenue Maximization                                               #
#         - Cost efficiency decomposition                                      #
#         - Revenue efficiency decomposition                                   #
#         - Scale dominance set                                                #
# Data: Cross sectional data & Pooled data                                     #
#------------------------------------------------------------------------------#

#' fdh: A package for estimating nonconvex frontier models
#'
#' The \pkg{fdh} package provides simple ways, using enumeration algorithms,
#' for estimating different efficiency scores (output, input, graph) with the
#' possibilities of imposing different returns to scale assumptions (constant,
#' nondecreasing, nonincreasing, variable returns to scale).
#' The package also offers the possiblity of estimating the minimum cost as well
#' as the maximum revenue in addition to their corresponding cost efficiency and
#' revenue efficiency scores. For large datasets, the \code{parallel} can be
#' used to speed up computations.
#'
#' @section costEffDecomp: \code{\link{costEffDecomp}} decomposes the overall
#' cost efficiency into seceral components (technical efficiency, overall
#' technical efficiency, scale efficiency, and allocative efficieny).
#'
#' @section costFun: \code{\link{costFun}} returns the minimum cost along with
#' cost efficiency under different returns to scale assumptions.
#'
#' @section distFun: \code{\link{distFun}} estimates the Farrell efficiency
#' scores for the output, input and graph orientations under different returns
#' to scale assumptions.
#'
#' @section dominFun: \code{\link{dominFun}} returns a list that contains for
#' each observation the corresponding scale dominance set.
#'
#' @section revEffDecomp: \code{\link{revEffDecomp}} decomposes the overall
#' revenue efficiency into seceral components (technical efficiency, overall
#' technical efficiency, scale efficiency, and allocative efficieny).
#'
#' @section revFun: \code{\link{revFun}} returns the maximum revenue along with
#' the corresponding revenue efficiency under different returns to scale
#' assumptions.
#'
#' @name fdh-package
#'
#' @aliases fdh-package fdh
#'
#' @docType package
#'
#' @section Bugreport: Any bug or suggestion can be reported using the
#' \code{fdh} tracker facilities at: \url{https://github.com/hdakpo/fdh/issues}
#'
#' @author K Hervé Dakpo, Frederic Ang, and Kristiaan Kerstens
#'
#' @importFrom foreach foreach %dopar%
#' @import progressr
#' @importFrom parallelly availableCores
#' @importFrom doFuture registerDoFuture
#' @importFrom future plan multisession sequential
#' @importFrom dplyr as_tibble
#' @importFrom Rfast colMaxs colMins colsums
# @importFrom katex math_to_rd
NULL
