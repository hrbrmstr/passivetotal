# documentation for these functions are in their memoised versions below

.passive_whois <- function(query, compact=TRUE, auth=passive_auth()) {

  params <- list(query=query,
                 compact_record=compact)

  resp <- S_GET("https://api.passivetotal.org/v2/whois",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

.passive_whois_search <- function(query, field, auth=passive_auth()) {

  params <- list(query=query,
                 field=match.arg(field, valid_whois))

  resp <- S_GET("https://api.passivetotal.org/v2/whois/search",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  dplyr::tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE)$results,
                           stringsAsFactors=FALSE))

}

#' Get WHOIS data for a domain or IP address
#'
#' @param query	Query value to use in your request.
#' @param compact Compress the WHOIS record into a deduplicated format.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{list}
#' @family WHOIS functions
#' @references \url{https://api.passivetotal.org/api/docs/#api-WHOIS-GetV2WhoisQuery}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_whois)} to invalidate the cache for this
#'       function.
#' @export
#' @examples \dontrun{
#' passive_whois("passivetotal.org")
#' }
passive_whois <- memoise::memoise(.passive_whois)


#' Get WHOIS records based on field matching queries.
#'
#' @param query	Query value to use in your request.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @param field WHOIS field to execute the search on: \code{domain},
#'   \code{email}, \code{name}, \code{organization}, \code{address},
#'   \code{phone}, \code{nameserver}
#' @return \code{list}
#' @family WHOIS functions
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_whois_search)} to invalidate the cache for this
#'       function.
#' @references
#'   \url{https://api.passivetotal.org/api/docs/#api-WHOIS-GetV2WhoisQuery}
#' @export
#' @examples \dontrun{
#' passive_whois_search(query="domains@riskiq.com", field="email")
#' }
passive_whois_search <- memoise::memoise(.passive_whois_search)

