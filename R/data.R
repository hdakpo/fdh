################################################################################
#                                                                              #
# data examples in fdh package                                                 #
#                                                                              #
################################################################################

#------------------------------------------------------------------------------#
# data list                                                                    #
#         -Data on French Apple producers                                      #
#         -Data on U.S. States agricultural data                               #
#------------------------------------------------------------------------------#

#' French fruit producers, 1984-1986
#'
#' This data set from the R\'eseau d'Information Comptable Agricole (RICA), and
#'  Institut National de la Recherche Agronomique (INRA) contains agriculture's
#'  input and output quantities for 184 French apple producers between 1984 and
#'  1986. Input prices are also provided.
#'
#' @details Further details on the data and the different variables can be found
#' in the reference.
#'
#' @name apple
#' @docType data
#' @format A data frame with 405 observations on the following 10 variables:
#' \describe{
#' \item{Time}{Period of observation: 1984-1986.}
#' \item{ID}{Id of the producer.}
#' \item{K}{Capital (including land).}
#' \item{L}{Labour.}
#' \item{M}{Materials.}
#' \item{Y1Z}{Apples production.}
#' \item{Y2Z}{Alternative products.}
#' \item{PK}{Capital price.}
#' \item{PL}{Labour price.}
#' \item{PM}{Materials price.}
#' }
#'
#' @references
#' Ivaldi, M., Ladoux, N., Ossard, H., & Simioni, M. (1996). Comparing Fourier
#' and translog specifications of multiproduct technology: Evidence from an
#' incomplete panel of French farmers. \emph{Journal of Applied Econometrics},
#' \bold{11}(6), 649-667.
#' doi: 10.1002/(Sici)1099-1255(199611)11:6<649::Aid-Jae416>3.0.Co;2-4
#'
#' @source
#' \url{http://qed.econ.queensu.ca/jae/1996-v11.6/ivaldi-ladoux-ossard-simioni/}
#' @keywords datasets
#' @examples
#' str(apple)
#' summary(apple)
NULL

#' Price indices and implicit quantities of USA farm outputs and inputs by
#' State, 1960-2004
#'
#' This data set from the United States Department of Agriculture (USDA) and its
#' Economic Research Service department contains USA agriculture's input and
#' output quantities along with their respective price indices for 48 States.
#'
#' All quantities are expressed in thousand US$1996 and prices are relative to
#' Alabama 1996 = 1.
#'
#' @details Further details on the data and the different variables can be found
#' in the references.
#'
#' @name usagri
#' @docType data
#' @format A data frame with 2160 observations on the following 40 variables:
#' \describe{
#' \item{States}{48 States of the USA identified with two capital letters.}
#' \item{States.num}{State number.}
#' \item{Years}{Year identification.}
#' \item{p.alloutputs}{Total agricultural outputs' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.alloutputs}{Total agricultural outputs' quantity, in thousand
#' US$1996.}
#' \item{p.livestock}{Livestock and animal products' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.livestock}{Livestock and animal products' quantity, in thousand
#' US$1996.}
#' \item{p.crops}{Crops' relative price (reference is 1 = Alabama 1996).}
#' \item{q.crops}{Crops' quantity, in thousand US$1996.}
#' \item{p.otherout}{Other farm-related productions' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.otherout}{Other farm-related productions' quantity, in thousand
#' US$1996.}
#' \item{p.allinputs}{Total agricultural inputs' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.allinputs}{Total agricultural inputs' quantity, in thousand
#' US$1996.}
#' \item{p.capital}{Capital services (excluding land)' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.capital}{Capital services (excluding land)' quantity, in
#' thousand US$1996.}
#' \item{p.land}{Land service flows' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.land}{Land services' quantity, in thousand US$1996.}
#' \item{p.labor}{Labor services' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.labor}{Labor services' quantity, in thousand US$1996.}
#' \item{p.hlabor}{Hired labor services' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.hlabor}{Hired labor services' quantity, in thousand US$1996.}
#' \item{p.flabor}{Self-employed and unpaid family labor services' relative
#' price (reference is 1 = Alabama 1996).}
#' \item{q.flabor}{Self-employed and unpaid family labor services' quantity,
#' in thousand US$1996.}
#' \item{p.materials}{Total intermediate inputs' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.materials}{Total intermediate input quantity, in thousand US$1996.}
#' \item{p.energy}{Energy relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.energy}{Energy quantity, in thousand US$1996.}
#' \item{p.chemicals}{Agricultural chemicals relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.chemicals}{Agricultural chemicals quantity, in thousand US$1996.}
#' \item{p.fertilizers}{Fertilizers relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.fertilizers}{Fertilizers quantity, in thousand US$1996.}
#' \item{p.pesticides}{Pesticides relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.pesticides}{Pesticides quantity, in thousand US$1996.}
#' \item{p.otherint}{Other intermediate inputs' relative price
#' (reference is 1 = Alabama 1996).}
#' \item{q.otherint}{Other intermediate input quantity, in thousand US$1996.}
#' \item{temp}{State-level average growing season temperature (Fahrenheit).}
#' \item{prec}{Cumulative precipitation (mm).}
#' \item{intra_temp}{Intra-annual (within-year) standard deviations of average
#' daily temperature.}
#' \item{intra_prec}{Intra-annual (within-year) standard deviations of
#' precipitation.}
#' \item{Regions}{USDA ERS farm production regions.}}
#'
#' @references Ball V.E., Gollop F.M., Kelly-Hawke A., and Swinand G.P. (1999),
#' Patterns of state productivity growth in the US farm sector: Linking state
#' and aggregate models. \emph{American Journal of Agricultural Economics},
#' \bold{81}(1], 164--179. \url{https://doi.org/10.2307/1244458}
#'
#' Ball V.E., Hallahan C., and Nehring R. (2004), Convergence of productivity:
#' An analysis of the catch-up hypothesis within a panel of states.
#' \emph{American Journal of Agricultural Economics}, \bold{86}(5), 1315--1321.
#' \url{https://doi.org/10.1111/j.0002-9092.2004.00683.x}
#'
#' Njuki, E., Bravo-Ureta, B. E., and O'Donnell, C. J. (2018), A new look at the
#' decomposition of agricultural productivity growth incorporating weather
#' effects. \emph{PLoS One}, \bold{13}(2), e0192432.
#' \url{https://doi.org/10.1371/journal.pone.0192432}
#'
#' @source
#' \url{http://www.ers.usda.gov/data-products/agricultural-productivity-in-the-us.aspx} \cr
#' \url{https://doi.org/10.1371/journal.pone.0192432.s001}
#' @keywords datasets
#' @examples
#' str(usagri)
#' summary(usagri)
NULL
