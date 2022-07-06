################################################################################
#                                                                              #
# R functions for the fdh package                                              #
#                                                                              #
################################################################################

#------------------------------------------------------------------------------#
# Cost efficiency decomposition functions (costEffDecomp)                      #
#------------------------------------------------------------------------------#

#' Cost efficiency decomposition functions for nonconvex technologies
#'
#' Given a vector of input prices, \code{costEffDecomp} decomposes the overall
#' efficiency (cost efficiency) into several efficiency components.
#'
#' @param xobs a \eqn{K \times N} matrix with \eqn{K} the number of inputs and
#' \eqn{N} the number of decision making units (DMUs) under evaluation.
#' @param yobs a \eqn{Q \times N} matrix with \eqn{Q} the number of outputs and
#' \eqn{N} the number of DMUs under evaluation.
#' @param wobs a \eqn{K \times N} matrix of input prices.
#' @param xref (optional). a  \eqn{K \times N_r} matrix on inputs of DMUs
#' serving as benchmark (or use to define the technology).
#' Default to \code{'xobs'}.
#' @param yref (optional). a  \eqn{Q \times N_r} matrix on outputs of DMUs
#' serving as benchmark (or use to define the technology).
#' Default to \code{'yobs'}.
#' @param parallel Logical. Allows parallel computation. If \code{FALSE}
#' (default), the estimation is conducted in sequential mode. If \code{TRUE},
#' parallel mode is activated using the number of cores specified in
#' \code{cores}. When the sample size is small, it is recommended to keep the
#' \code{parallel} option to its default value (\code{FALSE}).
#' @param cores Integer. Used only if \code{parallel = TRUE}. It specifies the
#' number of cores to be used for parallel computation. By default,
#' \code{cores = availableCores(omit = 1)}.
#'
#' @details
#' All estimations are based on the implicit enumeration algorithm
#' (Briec et al. 2004).
#'
#' @return \code{costEffDecomp} returns a tibble that contains five columns.
#' The first column (\code{'TE'}), contains the technical efficiency scores
#' obtained under variable returns to scale - vrs, the second column (\code{'SCE'})
#' contains the scale efficiency, the third column (\code{'OTE'} contains the
#' overall technical efficiency obtained under constant returns to scale - crs -
#' the fourth column (\code{'AE'} contains the allocative efficiency, and the
#' fifth column (\code{'OE'}) contains the overall efficiency (cost efficiency)
#' obtained under crs. The following equalities are true:
#' \eqn{OTE = TE \times SCE} and \eqn{OE = AE \times OTE}
#'
#' @references Briec, W., Kerstens, K., & Eeckaut, P. V. (2004). Non-convex
#' technologies and cost functions: Definitions, duality and nonparametric
#' tests of convexity. \emph{Journal of Economics-Zeitschrift Fur Nationalokonomie},
#' \bold{81}(2), 155-192. doi: \url{10.1007/s00712-003-0620-y}
#'
#'
#' @export
#'
#' @keywords models optimize
#'
#' @examples
#' fdh_cost_decomp <- costEffDecomp(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
#' yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]),
#' wobs = as.matrix(apple[, c('PK', 'PL', 'PM')]))
costEffDecomp <- function(xobs, yobs, wobs, xref = NULL, yref = NULL,
  parallel = FALSE, cores = availableCores(omit = 1)) {
  if (!is.matrix(xobs))
    stop("'xobs' must be an object of class 'matrix'", call. = FALSE)
  if (!is.matrix(yobs))
    stop("'yobs' must be an object of class 'matrix'", call. = FALSE)
  if (!is.matrix(wobs))
    stop("'wobs' must be an object of class 'matrix'", call. = FALSE)
  if (dim(xobs)[1] != dim(yobs)[1])
    stop("'xobs' and 'yobs' do not have the same number of rows",
      call. = FALSE)
  if (dim(xobs)[1] != dim(wobs)[1])
    stop("'xobs' and 'wobs' do not have the same number of rows",
      call. = FALSE)
  if (dim(xobs)[2] != dim(wobs)[2])
    stop("'xobs' and 'wobs' do not have the same number of columns",
      call. = FALSE)
  if (is.null(xref) && !is.null(yref))
    stop("'xref' is NULL but 'yref' is not", call. = FALSE)
  if (is.null(yref) && !is.null(xref))
    stop("'yref' is NULL but 'xref' is not", call. = FALSE)
  if (!is.null(xref) && !is.null(yref)) {
    if (!is.matrix(xref))
      stop("'xref' must be an object of class 'matrix'",
        call. = FALSE)
    if (!is.matrix(yref))
      stop("'yref' must be an object of class 'matrix'",
        call. = FALSE)
    if (dim(xref)[1] != dim(yref)[1])
      stop("'xref' and 'yref' do not have the same number of rows",
        call. = FALSE)
    if (dim(xref)[2] != dim(xobs)[2])
      stop("'xref' and 'xobs' do not have the same number of columns",
        call. = FALSE)
    if (dim(yref)[2] != dim(yobs)[2])
      stop("'yref' and 'yobs' do not have the same number of columns",
        call. = FALSE)
  } else {
    xref <- xobs
    yref <- yobs
  }
  # matrix transpose for estimation ------
  xobs <- t(xobs)
  yobs <- t(yobs)
  wobs <- t(wobs)
  xref <- t(xref)
  yref <- t(yref)
  # loop for efficiencies estimation ------
  handlers(global = TRUE)
  handlers("progress")
  registerDoFuture()
  if (parallel == TRUE & cores == 1) {
    parallel <- FALSE
  }
  if (parallel == TRUE & cores > 1) {
    plan(multisession, workers = cores)
  } else {
    plan(sequential)
  }
  nobs <- dim(xobs)[2]
  p <- progressor(along = 1:nobs)
  res <- foreach(dmu = 1:nobs, .combine = rbind) %dopar% {
    # dominating sets ------
    yratio <- yobs[, dmu]/yref
    dominatingy <- colMaxs(yratio, value = TRUE) <= 1
    # overall efficiency (crs) ------
    stp1 <- colsums(xref * wobs[, dmu]) * colMaxs(yratio,
      value = TRUE)
    costmin <- min(stp1)
    OE <- costmin/sum(xobs[, dmu] * wobs[, dmu])
    # technical efficiency (vrs) ------
    stp1 <- colMaxs(xref[, dominatingy, drop = FALSE]/xobs[,
      dmu], value = TRUE)
    TE <- stp1[which.min(stp1)]
    # overall technical efficiency (crs) ------
    stp1 <- colMaxs(xref/xobs[, dmu], value = TRUE) * colMaxs(yobs[,
      dmu]/yref, value = TRUE)
    OTE <- stp1[which.min(stp1)]
    # scale efficiency ------
    SCE <- OTE/TE
    # allocative efficiency ------
    AE <- OE/OTE
    p(sprintf("DMU = %g", dmu))
    c(TE = TE, SCE = SCE, OTE = OTE, AE = AE, OE = OE)
  }
  return(as_tibble(res))
}
