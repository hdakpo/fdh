################################################################################
#                                                                              #
# R functions for the fdh package                                              #
#                                                                              #
################################################################################

#------------------------------------------------------------------------------#
# Scaled vector dominance (dominFun)                                           #
#------------------------------------------------------------------------------#

#' Scaled vector dominance sets
#'
#' \code{dominFun} returns the set of observations that dominate the DMU under
#' evaluation given a specific returns to scale assumption.
#'
#' @param xobs a \eqn{K \times N} matrix with \eqn{K} the number of inputs and
#' \eqn{N} the number of decision making units (DMUs) under evaluation.
#' @param yobs a \eqn{Q \times N} matrix with \eqn{Q} the number of outputs and
#' \eqn{N} the number of DMUs under evaluation.
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
#' @details For the different returns to scale assumptions, we have:
#'
#' \itemize{
#' \item{variable returns to scale - \code{'vrs'}}{\deqn{\left\{
#' \left(\mathbf{x}_n, \mathbf{y}_n\right) | \mathbf{x} \geq
#' \mathbf{x}_n, \mathbf{y} \leq \mathbf{x}_n\right\}}}
#'
#' \item{constant returns to scale - \code{'crs'}}{\deqn{\left\{
#' \left(\mathbf{x}_n, \mathbf{y}_n\right) |
#' \displaystyle\max_{q=1, \cdots, Q}\frac{y_q^\circ}{y_{qn}} \leq
#' \displaystyle\min_{k=1, \cdots, K}\frac{x_k^\circ}{x_{kn}}\right\}}}
#'
#' \item{nonincreasing returns to scale - \code{'nirs'}}{\deqn{\left\{
#' \left(\mathbf{x}_n, \mathbf{y}_n\right) |
#' \displaystyle\max_{q=1, \cdots, Q}\frac{y_q^\circ}{y_{qn}} \leq 1\right\}}}
#'
#' \item{nondecreasing returns to scale - \code{'ndrs'}}{\deqn{\left\{
#' \left(\mathbf{x}_n, \mathbf{y}_n\right) |
#' \displaystyle\min_{k=1, \cdots, K}\frac{x_k^\circ}{x_{kn}} \geq 1\right\}}}
#' }
#'
#' @return \code{dominFun} returns a list that contains for each observation in
#' the original dataset the vector of dominating observations.
#'
#' @references Briec, W., Kerstens, K., & Eeckaut, P. V. (2004). Non-convex
#' technologies and cost functions: Definitions, duality and nonparametric
#' tests of convexity. \emph{Journal of Economics-Zeitschrift Fur Nationalokonomie},
#' \bold{81}(2), 155-192. doi: \url{10.1007/s00712-003-0620-y}
#'
#' Briec, W., & Kerstens, K. (2006). Input, output and graph technical
#' efficiency measures on non-convex FDH models with various scaling laws:
#' An integrated approach based upon implicit enumeration algorithms. \emph{Top},
#' \bold{14}(1), 135-166. doi: \url{10.1007/BF02579006}
#'
#' @export
#'
#' @examples
#' dlist <- dominFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
#' yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]), rts = 'vrs')
dominFun <- function(xobs, yobs, xref = NULL, yref = NULL, rts = "vrs",
  parallel = FALSE, cores = availableCores(omit = 1)) {
  if (!is.matrix(xobs))
    stop("'xobs' must be an object of class 'matrix'", call. = FALSE)
  if (!is.matrix(yobs))
    stop("'yobs' must be an object of class 'matrix'", call. = FALSE)
  if (dim(xobs)[1] != dim(yobs)[1])
    stop("'xobs' and 'yobs' do not have the same number of rows",
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
  xref <- t(xref)
  yref <- t(yref)
  # loop for scale dominance sets ------
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
  progressr::with_progress({
    p <- progressor(along = 1:nobs)
    res <- foreach(dmu = 1:nobs) %dopar% {
      xratio <- xobs[, dmu]/xref
      yratio <- yobs[, dmu]/yref
      if (rts == "vrs") {
        dobs <- (1:nobs)[colMaxs(yratio, value = TRUE) <=
          1 & colMins(xratio, value = TRUE) >= 1]
      } else {
        if (rts == "crs") {
          dobs <- (1:nobs)[colMaxs(yratio, value = TRUE) <=
          colMins(xratio, value = TRUE)]
        } else {
          if (rts == "ndrs") {
          dobs <- (1:nobs)[colMins(xratio, value = TRUE) >=
            1]
          } else {
          if (rts == "nirs") {
            dobs <- (1:nobs)[colMaxs(yratio, value = TRUE) <=
            1]
          }
          }
        }
      }
      p(sprintf("DMU = %g", dmu))
      dobs
    }
  }, handlers = progressr::handlers("progress"))
  return(res)
}
