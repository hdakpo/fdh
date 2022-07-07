################################################################################
#                                                                              #
# R functions for the fdh package                                              #
#                                                                              #
################################################################################

#------------------------------------------------------------------------------#
# Farrell distance functions (distFun)                                         #
#------------------------------------------------------------------------------#

#' Farrell distance functions for nonconvex technologies
#'
#' Input-, Output- and graph-oriented radial efficiency measures are computed
#' assuming nonconvex production technologies.
#'
#' @param xobs a \eqn{K \times N} matrix with \eqn{K} the number of inputs and
#' \eqn{N} the number of decision making units (DMUs) under evaluation.
#' @param yobs a \eqn{Q \times N} matrix with \eqn{Q} the number of outputs and
#' \eqn{N} the number of DMUs under evaluation.
#' @param xref (optional). a  \eqn{K \times N_r} matrix on inputs of DMUs
#' serving as benchmark (or use to define the technology). Default to
#' \code{'xobs'}.
#' @param yref (optional). a  \eqn{Q \times N_r} matrix on outputs of DMUs
#' serving as benchmark (or use to define the technology). Default to
#' \code{'yobs'}.
#' @param rts Character string specifying the returns to scale assumption.
#' The default value is \code{'vrs'} (variable returns to scale). Other possible
#' options are \code{'crs'} (constant returns to scale), \code{'nirs'}
#' (non-increasing returns to scale), or \code{'ndrs'} (non-decreasing returns
#' to scale).
#' @param orientation Character string specifying the orientation.
#' The default value is \code{'out'} for output-orientation. Other possibilities
#' are \code{'in'} for input-orientation, and \code{'graph'} for graph
#' orientation.
#' @param parallel Logical. Allows parallel computation. If \code{FALSE}
#' (default), the estimation is conducted in sequential mode. If \code{TRUE},
#' parallel mode is activated using the number of cores specified in
#' \code{cores}. When the sample size is small, it is recommended to keep the
#' \code{parallel} option to its default value (\code{FALSE}).
#' @param cores Integer. Used only if \code{parallel = TRUE}. It specifies the
#' number of cores to be used for parallel computation. By default,
#' \code{cores = availableCores(omit = 1)}.
#'
#'@details
#' All efficiency measures are computed using implicit enumeration
#' (Briec et al. 2004, Briec and Kerstens 2006). Let's assume that there are
#' \eqn{1,\cdots, N} decision making units (DMUs). Each DMU uses \eqn{K} inputs
#' to produce \eqn{Q} outputs. The enumeration algorithms to obtain the Farrell
#' efficiency scores are detailed next.
#'
#' For the \strong{input orientation} we have the following:
#'
#' \itemize{
#' \item{variable returns to scale - \code{'vrs'}}{\deqn{E_i
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right)=\displaystyle
#' \min_{\mathbf{y}^\circ \leq \mathbf{y}_n} \displaystyle \max_{k=1,\cdots, K}
#' \left\{\frac{x_{kn}}{x_k^\circ}\right\}}}
#'
#' \item{constant returns to scale - \code{'crs'}}{\deqn{E_i
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right) =
#' \displaystyle\min_{n=1, \cdots, N} \left\{\displaystyle\max_{k=1,\cdots, K}
#' \frac{x_{kn}}{x_k^\circ}\cdot\displaystyle\max_{q=1, \cdots, Q}
#' \frac{y_q^\circ}{y_{qn}}\right\}}}
#'
#' \item{nonincreasing returns to scale - \code{'nirs'}}{\deqn{E_i
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right)=
#' \displaystyle\min_{\mathbf{y}^\circ \leq \mathbf{y}_n}
#' \left\{\displaystyle\max_{k=1,\cdots, K}
#' \frac{x_{kn}}{x_k^\circ}\cdot\displaystyle\max_{q=1, \cdots, Q}
#' \frac{y_q^\circ}{y_{qn}}\right\}}}
#'
#' \item{nondecreasing returns to scale - \code{'ndrs'}}{\deqn{E_i
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right)=
#' \displaystyle\min_{n=1, \cdots, N} \left\{\displaystyle\max_{k=1,\cdots, K}
#' \frac{x_{kn}}{x_k^\circ}\cdot \max \left\{\displaystyle\max_{q=1, \cdots, Q}
#' \frac{y_q^\circ}{y_{qn}}, 1\right\}\right\}}}
#' }
#'
#' In the case of the \strong{output orientation}, we have:
#'
#' \itemize{
#' \item{variable returns to scale - \code{'vrs'}}{\deqn{E_o
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right)=
#' \displaystyle\max_{\mathbf{x}^\circ \geq \mathbf{x}_n}
#' \displaystyle\min_{q=1,\cdots, Q}\left\{\frac{y_{qn}}{y_q^\circ}\right\}}}
#'
#' \item{constant returns to scale - \code{'crs'}}{\deqn{E_o
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right) =
#' \displaystyle\max_{n=1, \cdots, N} \left\{\displaystyle\min_{q=1,\cdots, Q}
#' \frac{y_{qn}}{y_q^\circ}\cdot\displaystyle\min_{k=1,
#' \cdots, K}\frac{x_k^\circ}{x_{kn}}\right\}}}
#'
#' \item{nonincreasing returns to scale - \code{'nirs'}}{\deqn{E_o
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right)=
#' \displaystyle\max_{n=1, \cdots, N} \left\{\displaystyle\min_{q=1,\cdots, Q}
#' \frac{y_{qn}}{y_q^\circ}\cdot \min \left\{\displaystyle\min_{k=1,
#' \cdots, K}\frac{x_k^\circ}{x_{kn}}, 1\right\}\right\}}}
#'
#' \item{nondecreasing returns to scale - \code{'ndrs'}}{\deqn{E_o
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right)=
#' \displaystyle\max_{\mathbf{x}^\circ \geq \mathbf{x}_n}
#'  \left\{\displaystyle\min_{q=1,\cdots, Q}
#'  \frac{y_{qn}}{y_q^\circ}\cdot\displaystyle\min_{k=1,
#' \cdots, K}\frac{x_k^\circ}{x_{kn}}\right\}}}
#' }
#'
#' Finally, for the \strong{graph orientation}, let's first define:
#'
#' \deqn{\delta = \left(\displaystyle\max_{q=1, \cdots, Q}
#' \frac{y_q^\circ}{y_{qn}} \cdot \displaystyle\min_{k=1,\cdots, K}
#' \frac{x_k^\circ}{x_{kn}}\right)^{1/2}}
#'
#' The enumeration algorithms summarize as follows:
#'
#'\itemize{
#' \item{variable returns to scale - \code{'vrs'}}{\deqn{E_{GR}
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right)=
#' \displaystyle\min_{n=1, \cdots, N} \left\{\max
#' \left(\displaystyle\max_{k=1,\cdots, K}\frac{x_{kn}}{x_k^\circ},
#' \displaystyle\max_{q=1,\cdots, Q}\frac{y_q^\circ}{y_{qn}}\right)\right\}}}
#'
#' \item{constant returns to scale - \code{'crs'}}{\deqn{E_{GR}
#' \left(\mathbf{x}^\circ, \mathbf{y}^\circ\right) =
#' \displaystyle\min_{n=1, \cdots, N} \left\{\displaystyle\max_{q=1, \cdots, Q}
#' \frac{y_q^\circ}{y_{qn}}\Big/\displaystyle\min_{k=1,\cdots, K}
#' \frac{x_k^\circ}{x_{kn}}\right\}^{1/2}}}
#'
#' \item{nonincreasing returns to scale - \code{'nirs'}}{ \cr
#' -If \eqn{\delta \leq 1} then
#' \deqn{E_{GR}\left(\mathbf{x}^\circ,
#' \mathbf{y}^\circ\right) = \displaystyle\min_{n=1, \cdots, N}
#' \left\{\displaystyle\max_{q=1,\cdots, Q}\frac{y_q^\circ}{y_{qn}}\Big/
#' \displaystyle\min_{k=1,\cdots, K}\frac{x_k^\circ}{x_{kn}}\right\}^{1/2}}
#' -Else
#' \deqn{E_{GR}\left(\mathbf{x}^\circ,
#' \mathbf{y}^\circ\right) = \displaystyle\min_{n=1, \cdots, N}
#' \left\{\max\left[\displaystyle\max_{q=1, \cdots, Q}
#' \frac{y_q^\circ}{y_{qn}}, \left(\displaystyle\min_{k=1,\cdots, K}
#' \frac{x_k^\circ}{x_{kn}}\right)^{-1} \right]\right\}}
#' }
#'
#' \item{nondecreasing returns to scale - \code{'ndrs'}}{ \cr
#' -If \eqn{\delta \geq 1} then
#' \deqn{E_{GR}\left(\mathbf{x}^\circ,
#' \mathbf{y}^\circ\right) = \displaystyle\min_{n=1, \cdots, N}
#' \left\{\displaystyle\max_{q=1, \cdots, Q}\frac{y_q^\circ}{y_{qn}}\Big/
#' \displaystyle\min_{k=1,\cdots, K}\frac{x_k^\circ}{x_{kn}}\right\}^{1/2}}
#' -Else
#' \deqn{E_{GR}\left(\mathbf{x}^\circ,
#' \mathbf{y}^\circ\right) = \displaystyle\min_{n=1, \cdots, N}
#' \left\{\max\left[\displaystyle\max_{q=1, \cdots, Q}
#' \frac{y_q^\circ}{y_{qn}}, \left(\displaystyle\min_{k=1,\cdots, K}
#' \frac{x_k^\circ}{x_{kn}}\right)^{-1} \right]\right\}}}
#' }
#'
#' @return \code{distFun} returns a tibble that contains two columns. The first
#' column (\code{'Efficiencies'}), contains the Farrell efficiency scores,
#' while the second column (\code{'Benchmarks'}) contains the benchmark for
#' each evaluated observation.
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
#' @keywords models optimize
#'
#' @examples
#' # Input orientation - variable returns to scale
#' fdh_in_vrs <- distFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
#' yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]), rts = 'vrs', orientation = 'in')
#'
#' summary(fdh_in_vrs[, 1])
#'
#' # Output orientation - constant returns to scale
#' fdh_out_crs <- distFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
#' yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]), rts = 'crs', orientation = 'out')
#'
#' summary(fdh_out_crs[, 1])
#'
#' # Graph orientation - non-decreasing returns to scale
#' fdh_graph_ndrs <- distFun(xobs = as.matrix(apple[, c('K', 'L', 'M')]),
#' yobs = as.matrix(apple[, c('Y1Z', 'Y2Z')]), rts = 'ndrs', orientation = 'graph')
#'
#' summary(fdh_graph_ndrs[, 1])
distFun <- function(xobs, yobs, xref = NULL, yref = NULL, rts = "vrs",
  orientation = "out", parallel = FALSE, cores = availableCores(omit = 1)) {
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
  orientation <- tolower(orientation)
  if (!(orientation %in% c("out", "in", "graph")))
    stop("Unknown orientation: ", paste(orientation), call. = FALSE)
  # matrix transpose for estimation ------
  xobs <- t(xobs)
  yobs <- t(yobs)
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
    # ratios ------
    xratio <- xobs[, dmu]/xref
    yratio <- yobs[, dmu]/yref
    if (orientation == "in") {
      if (rts == "vrs") {
        dominating <- colMaxs(yratio, value = TRUE) <=
          1
        stp1 <- colMaxs(xref[, dominating, drop = FALSE]/xobs[,
          dmu], value = TRUE)
        bench <- which(dominating == TRUE)[which.min(stp1)]
        eff <- stp1[which.min(stp1)]
      } else {
        if (rts == "crs") {
          stp1 <- colMaxs(xref/xobs[, dmu], value = TRUE) *
          colMaxs(yobs[, dmu]/yref, value = TRUE)
          bench <- which.min(stp1)
          eff <- stp1[bench]
        } else {
          if (rts == "nirs") {
          dominating <- colMaxs(yratio, value = TRUE) <=
            1
          stp1 <- colMaxs(xref[, dominating, drop = FALSE]/xobs[,
            dmu], value = TRUE) * colMaxs(yobs[, dmu]/yref[,
            dominating, drop = FALSE], value = TRUE)
          bench <- which(dominating == TRUE)[which.min(stp1)]
          eff <- stp1[which.min(stp1)]
          } else {
          if (rts == "ndrs") {
            stp1 <- colMaxs(xref/xobs[, dmu], value = TRUE) *
            colMaxs(rbind(yobs[, dmu]/yref, 1), value = TRUE)
            bench <- which.min(stp1)
            eff <- stp1[bench]
          }
          }
        }
      }
    } else {
      if (orientation == "out") {
        if (rts == "vrs") {
          dominating <- colMins(xratio, value = TRUE) >=
          1
          stp1 <- colMins(yref[, dominating, drop = FALSE]/yobs[,
          dmu], value = TRUE)
          bench <- which(dominating == TRUE)[which.max(stp1)]
          eff <- stp1[which.max(stp1)]
        } else {
          if (rts == "crs") {
          stp1 <- colMins(yref/yobs[, dmu], value = TRUE) *
            colMins(xobs[, dmu]/xref, value = TRUE)
          bench <- which.max(stp1)
          eff <- stp1[bench]
          } else {
          if (rts == "ndrs") {
            dominating <- colMins(xratio, value = TRUE) >=
            1
            stp1 <- colMins(yref[, dominating, drop = FALSE]/yobs[,
            dmu], 2, value = TRUE) * colMins(xobs[,
            dmu]/xref[, dominating, drop = FALSE],
            value = TRUE)
            bench <- which(dominating == TRUE)[which.max(stp1)]
            eff <- stp1[which.max(stp1)]
          } else {
            if (rts == "nirs") {
            stp1 <- colMins(yref/yobs[, dmu], value = TRUE) *
              colMins(rbind(xobs[, dmu]/xref, 1),
              value = TRUE)
            bench <- which.max(stp1)
            eff <- stp1[bench]
            }
          }
          }
        }
      } else {
        if (orientation == "graph") {
          if (rts == "vrs") {
          stp1 <- colMaxs(rbind(xref/xobs[, dmu], yobs[,
            dmu]/yref), value = TRUE)
          bench <- which.min(stp1)
          eff <- stp1[bench]
          } else {
          if (rts == "crs") {
            stp1 <- sqrt(colMaxs(yobs[, dmu]/yref,
            value = TRUE)/colMins(xobs[, dmu]/xref,
            value = TRUE))
            bench <- which.min(stp1)
            eff <- stp1[bench]
          } else {
            if (rts == "nirs") {
            delta <- colMins(xobs[, dmu]/xref, value = TRUE) *
              colMaxs(yobs[, dmu]/yref, value = TRUE)
            stp1 <- ifelse(delta <= 1, sqrt(colMaxs(yobs[,
              dmu]/yref, value = TRUE)/colMins(xobs[,
              dmu]/xref, value = TRUE)), colMaxs(rbind(colMaxs(yobs[,
              dmu]/yref, value = TRUE), 1/(colMins(xobs[,
              dmu]/xref, value = TRUE))), value = TRUE))
            bench <- which.min(stp1)
            eff <- stp1[bench]
            } else {
            if (rts == "ndrs") {
              delta <- colMins(xobs[, dmu]/xref,
              value = TRUE) * colMaxs(yobs[, dmu]/yref,
              value = TRUE)
              stp1 <- ifelse(delta >= 1, sqrt(colMaxs(yobs[,
              dmu]/yref, value = TRUE)/colMins(xobs[,
              dmu]/xref, value = TRUE)), colMaxs(rbind(colMaxs(yobs[,
              dmu]/yref, value = TRUE), 1/(colMins(xobs[,
              dmu]/xref, value = TRUE))), value = TRUE))
              bench <- which.min(stp1)
              eff <- stp1[bench]
            }
            }
          }
          }
        }
      }
    }
    p(sprintf("DMU = %g", dmu))
    c(eff, bench)
  }
  colnames(res) <- c("Efficiencies", "Benchmarks")
  return(as_tibble(res))
}
