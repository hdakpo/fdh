################################################################################
#                                                                              #
# R functions for the fdh package                                              #
#                                                                              #
################################################################################

#------------------------------------------------------------------------------#
# Revenue maximixation functions (revFun)                                      #
#------------------------------------------------------------------------------#

#' Revenue maximization functions for nonconvex technologies
#'
#' Given a vector of output prices, \code{revFun} estimates the vector of
#' output quantities that maximizes the revenue subject to different returns to
#' scale assumptions.
#'
#' @param xobs a \eqn{K \times N} matrix with \eqn{K} the number of inputs and
#' \eqn{N} the number of decision making units (DMUs) under evaluation.
#' @param yobs a \eqn{Q \times N} matrix with \eqn{Q} the number of outputs and
#' \eqn{N} the number of DMUs under evaluation.
#' @param pobs a \eqn{Q \times N} matrix of output prices.
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
#' All estimations are based on the implicit enumeration algorithm.
#' Let's assume that there are \eqn{1,\cdots, N} decision making units (DMUs).
#' Each DMU uses \eqn{K} inputs to produce \eqn{Q} outputs. The price vector of
#' the \eqn{Q} outputs is also provided (\eqn{\mathbf{p}}). Therefore, the
#' enumeration algorithms to obtain the maximum revenue, and hence the revenue
#' efficiency are detailed next.
#'
#' \itemize{
#' \item{variable returns to scale - \code{'vrs'}}{\deqn{R_{max}
#' \left(\mathbf{p}^\circ,\mathbf{y}^\circ\right)=
#' \displaystyle\max_{\mathbf{x}^\circ \geq \mathbf{x}_n}
#' \left\{\mathbf{p}^\circ \mathbf{y}_n\right\}}}
#'
#' \item{constant returns to scale - \code{'crs'}}{\deqn{R_{max}
#' \left(\mathbf{p}^\circ,\mathbf{y}^\circ\right)=
#' \displaystyle\max_{n=1, \cdots, N} \left\{\displaystyle\min_{k=1, \cdots, K}
#' \left(\frac{x_k^\circ}{x_{kn}}\right) \cdot
#'  \mathbf{p}^\circ \mathbf{y}_n\right\}}}
#'
#' \item{nonincreasing returns to scale - \code{'nirs'}}{\deqn{R_{max}
#' \left(\mathbf{p}^\circ, \mathbf{y}^\circ\right)=
#' \displaystyle\max_{n=1, \cdots, N} \left\{\min \left\{
#' \displaystyle\min_{k=1, \cdots, K}\left(
#' \frac{x_k^\circ}{x_{kn}}\right), 1\right\}
#' \cdot \mathbf{p}^\circ \mathbf{y}_n\right\}}}
#'
#' \item{nondecreasing returns to scale - \code{'ndrs'}}{\deqn{R_{max}
#' \left(\mathbf{p}^\circ, \mathbf{y}^\circ\right)=
#' \displaystyle\max_{\mathbf{x}^\circ \geq \mathbf{x}_n}
#' \left\{\displaystyle\min_{k=1, \cdots, K}\left(
#' \frac{x_k^\circ}{x_{kn}}\right) \cdot
#' \mathbf{p}^\circ \mathbf{y}_n\right\}}}
#' }
#'
#' The revenue efficiency can be obtained as
#'
#' \deqn{RE=\frac{R_{observed}}{R_{max}}}
#'
#' @return \code{revFun} returns a tibble that contains three columns.
#' The first column (\code{'RevEff'}), contains the revenue efficiency scores,
#' the second column (\code{'RevMax'}) contains the maximum revenue and the
#' third column (\code{'Benchmarks'}) contains the benchmark for each evaluated
#' observation.
#'
#' @export
#'
#' @keywords models optimize
#'
#' @examples
#' \dontrun{
#' # variable returns to scale
#' fdh_rev_vrs <- costFun(xobs = as.matrix(usagri[, c('q.capital', 'q.land',
#' 'q.labor', 'q.materials')]),
#' yobs = as.matrix(usagri[, c('q.livestock', 'q.crops', 'q.otherout')]),
#' pobs = as.matrix(usagri[, c('p.livestock', 'p.crops', 'p.otherout')]), rts = 'vrs')
#'
#' # constant returns to scale
#' fdh_rev_crs <- costFun(xobs = as.matrix(usagri[, c('q.capital', 'q.land',
#' 'q.labor', 'q.materials')]),
#' yobs = as.matrix(usagri[, c('q.livestock', 'q.crops', 'q.otherout')]),
#' pobs = as.matrix(usagri[, c('p.livestock', 'p.crops', 'p.otherout')]), rts = 'crs')
#'
#' # nondecreasing returns to scale
#' fdh_rev_ndrs <- costFun(xobs = as.matrix(usagri[, c('q.capital', 'q.land',
#' 'q.labor', 'q.materials')]),
#' yobs = as.matrix(usagri[, c('q.livestock', 'q.crops', 'q.otherout')]),
#' pobs = as.matrix(usagri[, c('p.livestock', 'p.crops', 'p.otherout')]), rts = 'ndrs')
#' }
revFun <- function(xobs, yobs, pobs, xref = NULL, yref = NULL,
  rts = "vrs", parallel = FALSE, cores = availableCores(omit = 1)) {
  if (!is.matrix(xobs))
    stop("'xobs' must be an object of class 'matrix'", call. = FALSE)
  if (!is.matrix(yobs))
    stop("'yobs' must be an object of class 'matrix'", call. = FALSE)
  if (!is.matrix(pobs))
    stop("'pobs' must be an object of class 'matrix'", call. = FALSE)
  if (dim(xobs)[1] != dim(yobs)[1])
    stop("'xobs' and 'yobs' do not have the same number of rows",
      call. = FALSE)
  if (dim(yobs)[1] != dim(pobs)[1])
    stop("'yobs' and 'pobs' do not have the same number of rows",
      call. = FALSE)
  if (dim(yobs)[2] != dim(pobs)[2])
    stop("'yobs' and 'pobs' do not have the same number of columns",
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
  pobs <- t(pobs)
  xref <- t(xref)
  yref <- t(yref)
  # loop for efficiencies estimation ------
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
    res <- foreach(dmu = 1:nobs, .combine = rbind) %dopar%
      {
        # dominating sets ------
        xratio <- xobs[, dmu]/xref
        dominatingx <- colMins(xratio, value = TRUE) >=
          1
        if (rts == "vrs") {
          stp1 <- colsums(yref[, dominatingx, drop = FALSE] *
          pobs[, dmu])
          bench <- which(dominatingx == TRUE)[which.max(stp1)]
          revmax <- max(stp1)
        } else {
          if (rts == "crs") {
          stp1 <- colsums(yref * pobs[, dmu]) * colMins(xratio,
            value = TRUE)
          bench <- which.max(stp1)
          revmax <- max(stp1)
          } else {
          if (rts == "nirs") {
            stp1 <- colsums(yref * pobs[, dmu]) * colMins(rbind(xratio,
            1))
            bench <- which.max(stp1)
            revmax <- max(stp1)
          } else {
            if (rts == "ndrs") {
            stp1 <- colsums(yref[, dominatingx, drop = FALSE] *
              pobs[, dmu]) * colMins(xratio[, dominatingx,
              drop = FALSE])
            bench <- which(dominatingx == TRUE)[which.max(stp1)]
            revmax <- max(stp1)
            }
          }
          }
        }
        reveff <- sum(yobs[, dmu] * pobs[, dmu])/revmax
        p(sprintf("DMU = %g", dmu))
        c(reveff, revmax, bench)
      }
  }, handlers = progressr::handlers("progress"))
  colnames(res) <- c("RevEff", "RevMax", "Benchmarks")
  return(as_tibble(res))
}
