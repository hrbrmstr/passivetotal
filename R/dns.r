#' Get passive DNS data
#'
#' @param query	Query value to use in your request.
#' @param direction optional Pagination direction: \code{next} or \code{previous}
#' @param page optional	Page ID to request
#' @param sources optional Comma seperated list of sources to process with
#' @param start optional Only show data starting from date: \code{YYYY-mm-dd}
#' @param end optional Only show data up to date: \code{YYYY-mm-dd}
#' @param timeout optional Timeout to use on all source requests
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-DNS-GetV2DnsPassiveQuery}
#' @export
#' @family DNS functions
#' @examples \dontrun{
#' passive_dns("passivetotal.org")
#' }
passive_dns <- function(query,
                        direction=c("", "next", "previous"),
                        page=NULL,
                        sources=NULL,
                        start=NULL,
                        end=NULL,
                        timeout=NULL,
                        auth=passive_auth()) {

  params <- list(direction=match.arg(direction, c("", "next", "previous")),
                 page=page,
                 sources=sources,
                 start=start,
                 end=end,
                 timeout=timeout,
                 query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/dns/passive",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Get unique resolutions from passive DNS data
#'
#' @param query	Query value to use in your request.
#' @param direction optional Pagination direction: \code{next} or \code{previous}
#' @param page optional	Page ID to request
#' @param sources optional Comma seperated list of sources to process with
#' @param start optional Only show data starting from date: \code{YYYY-mm-dd}
#' @param end optional Only show data up to date: \code{YYYY-mm-dd}
#' @param timeout optional Timeout to use on all source requests
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-DNS-GetV2DnsPassiveUniqueQuery}
#' @export
#' @family DNS functions
#' @examples \dontrun{
#' passive_unique("passivetotal.org")
#' }
passive_unique <- function(query,
                           direction=c("", "next", "previous"),
                           page=NULL,
                           sources=NULL,
                           start=NULL,
                           end=NULL,
                           timeout=NULL,
                           auth=passive_auth()) {

  params <- list(direction=match.arg(direction, c("", "next", "previous")),
                 page=page,
                 sources=sources,
                 start=start,
                 end=end,
                 timeout=timeout,
                 query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/dns/passive/unique",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

