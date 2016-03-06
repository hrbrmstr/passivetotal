# documentation for these functions are in their memoised versions below

.passive_osint <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/enrichment/osint",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

.passive_malware <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/enrichment/malware",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  dplyr::tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE)$results,
                           stringsAsFactors=FALSE))

}

.passive_enrich <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/enrichment",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

.passive_subdomains <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/enrichment/subdomains",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Enrich the given query with metadata
#'
#' @param query	Query value to use in your request.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{list}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_enrich)} to invalidate the cache for this
#'       function.
#' @references \url{https://api.passivetotal.org/api/docs/#api-Enrichment-GetV2EnrichmentQuery}
#' @export
#' @family Enrichment functions
#' @examples \dontrun{
#' passive_enrich("passivetotal.org")
#' }
passive_enrich <- memoise::memoise(.passive_enrich)


#' Get malware data
#'
#' @param query	Query value to use in your request.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{list}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_malware)} to invalidate the cache for this
#'       function.
#' @references \url{https://api.passivetotal.org/api/docs/#api-Enrichment-GetV2EnrichmentMalwareQuery}
#' @export
#' @family Enrichment functions
#' @examples \dontrun{
#' passive_malware("noorno.com")
#' }
passive_malware <- memoise::memoise(.passive_malware)

#' Get opensource intelligence data
#'
#' @param query	Query value to use in your request.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{list}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_osint)} to invalidate the cache for this
#'       function.
#' @references \url{https://api.passivetotal.org/api/docs/#api-Enrichment-GetV2EnrichmentOsintQuery}
#' @export
#' @family Enrichment functions
#' @examples \dontrun{
#' passive_osint("xxxmobiletubez.com")
#' }
passive_osint <- memoise::memoise(.passive_osint)

#' Get subdomains using a wildcard query
#'
#' @param query	Query value to use in your request.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{list}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_subdomains)} to invalidate the cache for this
#'       function.
#' @references \url{https://api.passivetotal.org/api/docs/#api-Enrichment-GetV2EnrichmentSubdomains}
#' @export
#' @family Enrichment functions
#' @examples \dontrun{
#' passive_subdomains("*.passivetotal.org")
#' }
passive_subdomains <- memoise::memoise(.passive_subdomains)
