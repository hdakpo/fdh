################################################################################
#                                                                              #
# R functions for the fdh package                                              #
#                                                                              #
################################################################################

#------------------------------------------------------------------------------#
# Cost minimization functions (costFun)                                        #
#------------------------------------------------------------------------------#

#' Cost minimization functions for nonconvex technologies
#'
#' Given a vector of input prices, \code{costFun} estimates the vector of
#' input quantities that minimizes the cost subject to different returns to
#' scale assumptions.
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
#' @param rts Character string specifying the returns to scale assumption.
#' The default value is \code{'vrs'} (variable returns to scale). Other possible
#' options are \code{'crs'} (constant returns to scale), \code{'nirs'}
#' (non-increasing returns to scale), or \code{'ndrs'} (non-decreasing returns
#' to scale).
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
#' (Briec et al. 2004). Let's assume that there are
#' \eqn{1,\cdots, N} decision making units (DMUs). Each DMU uses \eqn{K} inputs
#' to produce \eqn{Q} outputs. The price vector of the \eqn{K} inputs is also
#' provided (\eqn{\mathbf{w}}). Therefore, the enumeration algorithms to obtain
#' the minimum cost, and hence the cost efficiency are detailed next.
#'
#' \itemize{
#' \item{variable returns to scale - \code{'vrs'}}{\deqn{C_{min}\left(\mathbf{w}^\circ,
#' \mathbf{y}^\circ\right)=\underset{\mathbf{y}^\circ \leq \mathbf{y}_n}{\min}
#' \left\{\mathbf{w}^\circ \mathbf{x}_n\right\}}}
#'
#' \item{constant returns to scale - \code{'crs'}}{\deqn{C_{min}\left(\mathbf{w}^\circ,
#' \mathbf{y}^\circ\right)=\underset{n=1, \cdots, N}{\min}
#' \left\{\underset{q=1, \cdots, Q}{\max}\left(\frac{y_q^\circ}{y_{qn}}\right) \cdot
#' \mathbf{w}^\circ \mathbf{x}_n\right\}}}
#'
#' \item{nonincreasing returns to scale - \code{'nirs'}}{\deqn{C_{min}\left(\mathbf{w}^\circ,
#' \mathbf{y}^\circ\right)=\underset{\mathbf{y}^\circ \leq \mathbf{y}_n}{\min}
#' \left\{\underset{q=1, \cdots, Q}{\max}\left(\frac{y_q^\circ}{y_{qn}}\right) \cdot
#' \mathbf{w}^\circ \mathbf{x}_n\right\}}}
#'
#' \item{nondecreasing returns to scale - \code{'ndrs'}}{\deqn{C_{min}\left(\mathbf{w}^\circ,
#' \mathbf{y}^\circ\right)=\underset{n=1, \cdots, N}{\min}
#' \left\{\max \left\{\underset{q=1, \cdots, Q}{\max}\left(\frac{y_q^\circ}{y_{qn}}\right), 1\right\}
#' \cdot \mathbf{w}^\circ \mathbf{x}_n\right\}}}
#' }
#'
#' The cost efficiency can be obtained as
#'
#' \deqn{CE=\frac{C_{min}}{C_{observed}}}
#'
#' @return \code{costFun} returns a tibble that contains three columns.
#' The first column (\code{'CostEff'}), contains the cost efficiency scores,
#' the second column (\code{'CostMin'}) contains the minimum cost and the third
#' column (\code{'Benchmarks'}) contains the benchmark for each evaluated
#' observation.
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
#' # variable returns to scale
#' fdh_cost_vrs <- costFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
#' yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]),
#' wobs = as.matrix(apple[, c('PK', 'PL', 'PM')]), rts = 'vrs')
#'
#' # constant returns to scale
#' fdh_cost_crs <- costFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
#' yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]),
#' wobs = as.matrix(apple[, c('PK', 'PL', 'PM')]), rts = 'crs')
#'
#' # nonincreasing returns to scale
#' fdh_cost_nirs <- costFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
#' yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]),
#' wobs = as.matrix(apple[, c('PK', 'PL', 'PM')]), rts = 'nirs')
costFun <- function(xobs, yobs, wobs, xref = NULL, yref = NULL,
  rts = "vrs", parallel = FALSE, cores = availableCores(omit = 1)) {
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
  rts <- tolower(rts)
  if (!(rts %in% c("vrs", "crs", "nirs", "ndrs")))
    stop("Unknown scale of returns: ", paste(rts), call. = FALSE)
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
    if (rts == "vrs") {
      stp1 <- colsums(xref[, dominatingy, drop = FALSE] *
        wobs[, dmu])
      bench <- which(dominatingy == TRUE)[which.min(stp1)]
      costmin <- min(stp1)
    } else {
      if (rts == "crs") {
        stp1 <- colsums(xref * wobs[, dmu]) * colMaxs(yratio,
          value = TRUE)
        bench <- which.min(stp1)
        costmin <- min(stp1)
      } else {
        if (rts == "nirs") {
          stp1 <- colsums(xref[, dominatingy, drop = FALSE] *
          wobs[, dmu]) * colMaxs(yratio[, dominatingy,
          drop = FALSE])
          bench <- which(dominatingy == TRUE)[which.min(stp1)]
          costmin <- min(stp1)
        } else {
          if (rts == "ndrs") {
          stp1 <- colsums(xref * wobs[, dmu]) * colMaxs(rbind(yratio,
            1))
          bench <- which.min(stp1)
          costmin <- min(stp1)
          }
        }
      }
    }
    costeff <- costmin/sum(xobs[, dmu] * wobs[, dmu])
    p(sprintf("DMU = %g", dmu))
    c(costeff, costmin, bench)
  }
  colnames(res) <- c("CostEff", "CostMin", "Benchmarks")
  return(as_tibble(res))
}
