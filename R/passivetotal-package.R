#' Tools for Working with the (Version 2) 'PassiveTotal' API
#'
#' Provides programmatic access to the 'PassiveTotal' API
#' \url{https://www.passivetotal.org/api/docs/} (Version 2) which contains rich
#' information on internet domain names, 'IP' addresses, 'SSL' certificates and
#' 'malware'.
#'
#' You should set `PASSIVETOTAL_USER` & `PASSIVETOTAL_API_KEY` in `.Renviron`
#' or you'll either be prompted for them or will need to pass them to each
#' function manually.
#'
#' @name passivetotal
#' @references \url{https://api.passivetotal.org/api/docs/}
#' @docType package
#' @author Bob Rudis (@@hrbrmstr)
#' @import httr dplyr
#' @importFrom memoise memoise forget
#' @importFrom stringr str_replace
#' @importFrom purrr safely flatten_chr walk
#' @import jsonlite
NULL

#' @name forget
#' @rdname forget
#' @title Flush the cache for a given API function
#' @description By default, \code{passivetotal} API functions cache results using
#'     the \code{memoise} R pacakge. There are times when you need to ensure you
#'     are receiving up-to-date information. By calling \code{forget} with the bare function
#'     name from the \code{passivetotal} package you can invalidate the cache for
#'     that function/API call.
#' @examples \dontrun{
#' forget(passive_dns)
#' }
#' @export
NULL