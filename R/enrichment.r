#' Enrich the given query with metadata
#'
#' @param query	Query value to use in your request.
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Enrichment-GetV2EnrichmentQuery}
#' @export
#' @family Enrichment functions
#' @examples \dontrun{
#' passive_enrich("passivetotal.org")
#' }
passive_enrich <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/enrichment",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Get malware data
#'
#' @param query	Query value to use in your request.
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Enrichment-GetV2EnrichmentMalwareQuery}
#' @export
#' @family Enrichment functions
#' @examples \dontrun{
#' passive_malware("noorno.com")
#' }
passive_malware <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/enrichment/malware",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Get opensource intelligence data
#'
#' @param query	Query value to use in your request.
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Enrichment-GetV2EnrichmentOsintQuery}
#' @export
#' @family Enrichment functions
#' @examples \dontrun{
#' passive_osint("xxxmobiletubez.com")
#' }
passive_osint <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/enrichment/osint",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Get subdomains using a wildcard query
#'
#' @param query	Query value to use in your request.
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Enrichment-GetV2EnrichmentSubdomains}
#' @export
#' @family Enrichment functions
#' @examples \dontrun{
#' passive_subdomains("*.passivetotal.org")
#' }
passive_subdomains <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/enrichment/subdomains",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}