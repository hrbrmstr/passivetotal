# documentation for these functions are in their memoised versions below

.passive_ssl_certificate <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/ssl-certificate",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

.passive_ssl_history <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/ssl-certificate/history",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE)$results,
                    stringsAsFactors=FALSE))

}

.passive_ssl_search <- function(query, field, auth=passive_auth()) {

  params <- list(query=query,
                 field=match.arg(field, valid_ssl_fields))

  resp <- S_GET("https://api.passivetotal.org/v2/ssl-certificate/search",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Get the SSL certificate history associated with an IP address or SHA-1
#'
#' @param query	Query value to use in your request.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{tbl_df}
#' @references \url{https://api.passivetotal.org/api/docs/#api-SSL_Certificates-GetV2SslCertificateHistoryQuery}
#' @family SSL functions
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_ssl_history)} to invalidate the cache for this
#'       function.
#' @export
#' @examples \dontrun{
#' passive_ssl_history("52.8.228.23")
#' }
passive_ssl_history <- memoise::memoise(.passive_ssl_history)


#' Get the SSL certificate associated with the SHA-1.
#'
#' @param query	Query value to use in your request.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-SSL_Certificates-GetV2SslCertificateQuery}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_ssl_certificate)} to invalidate the cache for this
#'       function.
#' @family SSL functions
#' @export
#' @examples \dontrun{
#' passive_ssl_certificate("e9a6647d6aba52dc47b3838c920c9ee59bad7034")
#' }
passive_ssl_certificate <- memoise::memoise(.passive_ssl_certificate)

#' Get the SSL certificate associated with the SHA-1.
#'
#' @param query	Query value to use in your request.
#' @param field Field to search against: \code{issuerSurname},
#'   \code{subjectOrganizationName}, \code{issuerCountry},
#'   \code{issuerOrganizationUnitName}, \code{fingerprint},
#'   \code{subjectOrganizationUnitName}, \code{serialNumber},
#'   \code{subjectEmailAddress}, \code{subjectCountry}, \code{issuerGivenName},
#'   \code{subjectCommonName}, \code{issuerCommonName},
#'   \code{issuerStateOrProvinceName}, \code{issuerProvince},
#'   \code{subjectStateOrProvinceName}, \code{sha1}, \code{sslVersion},
#'   \code{subjectStreetAddress}, \code{subjectSerialNumber},
#'   \code{issuerOrganizationName}, \code{subjectSurname},
#'   \code{subjectLocalityName}, \code{issuerStreetAddress},
#'   \code{issuerLocalityName}, \code{subjectGivenName}, \code{subjectProvince},
#'   \code{issuerSerialNumber}, \code{issuerEmailAddress}
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{list}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_ssl_search)} to invalidate the cache for this
#'       function.
#' @references
#'   \url{https://api.passivetotal.org/api/docs/#api-SSL_Certificates-GetV2SslCertificateSearchQueryField}
#' @family SSL functions
#' @export
#' @examples \dontrun{
#' passive_ssl_search(query="www.passivetotal.org", field="subjectCommonName")
#' }
passive_ssl_search <- memoise::memoise(.passive_ssl_search)
