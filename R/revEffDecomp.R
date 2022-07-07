################################################################################
#                                                                              #
# R functions for the fdh package                                              #
#                                                                              #
################################################################################

#------------------------------------------------------------------------------#
# Revenue efficiency decomposition functions (revEffDecomp)                    #
#------------------------------------------------------------------------------#

#' Revenue efficiency decomposition functions for nonconvex technologies
#'
#' Given a vector of output prices, \code{revEffDecomp} decomposes the overall
#' efficiency (revenue efficiency) into several efficiency components.
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
#'
#' @return \code{revEffDecomp} returns a tibble that contains five columns.
#' The first column (\code{'TE'}), contains the technical efficiency scores
#' obtained under variable returns to scale - vrs, the second column (\code{'SCE'})
#' contains the scale efficiency, the third column (\code{'OTE'} contains the
#' overall technical efficiency obtained under constant returns to scale - crs -
#' the fourth column (\code{'AE'} contains the allocative efficiency, and the
#' fifth column (\code{'OE'}) contains the overall efficiency (cost efficiency)
#' obtained under crs. The following equalities are true:
#' \eqn{OTE = TE \times SCE} and \eqn{OE = AE \times OTE}
#'
#'
#' @export
#'
#' @keywords models optimize
#'
#' @examples
#' \dontrun{
#' fdh_rev_decomp <- revEffDecomp(xobs = as.matrix(usagri[, c('q.capital',
#' 'q.land', 'q.labor', 'q.materials')]),
#' yobs = as.matrix(usagri[, c('q.livestock', 'q.crops', 'q.otherout')]),
#' pobs = as.matrix(usagri[, c('p.livestock', 'p.crops', 'p.otherout')]))
#' }
revEffDecomp <- function(xobs, yobs, pobs, xref = NULL, yref = NULL,
  parallel = FALSE, cores = availableCores(omit = 1)) {
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
    p <- progressr::progressor(along = 1:nobs)
    res <- foreach(dmu = 1:nobs, .combine = rbind) %dopar%
      {
        # dominating sets ------
        xratio <- xobs[, dmu]/xref
        dominatingx <- colMins(xratio, value = TRUE) >=
          1
        # overall efficiency (crs) ------
        stp1 <- colsums(yref * pobs[, dmu]) * colMins(xratio,
          value = TRUE)
        revmax <- max(stp1)
        OE <- sum(yobs[, dmu] * pobs[, dmu])/revmax
        # technical efficiency (vrs) ------
        stp1 <- colMins(yref[, dominatingx, drop = FALSE]/yobs[,
          dmu], value = TRUE)
        TE <- 1/stp1[which.max(stp1)]
        # overall technical efficiency (crs) ------
        stp1 <- colMins(yref/yobs[, dmu], value = TRUE) *
          colMins(xobs[, dmu]/xref, value = TRUE)
        OTE <- 1/stp1[which.max(stp1)]
        # scale efficiency ------
        SCE <- OTE/TE
        # allocative efficiency ------
        AE <- OE/OTE
        p(sprintf("DMU = %g", dmu))
        c(TE = TE, SCE = SCE, OTE = OTE, AE = AE, OE = OE)
      }
  }, handlers = progressr::handlers("progress"))
  return(as_tibble(res))
}
