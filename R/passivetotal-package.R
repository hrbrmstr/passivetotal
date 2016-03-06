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
#' @importFrom stringr str_replace
#' @importFrom purrr safely
#' @import jsonlite
NULL
