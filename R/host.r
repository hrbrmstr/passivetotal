#' Get detailed information about a host
#'
#' @param query	Query value to use in your request.
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Host_Attributes}
#' @export
#' @family Host attribute functions
#' @examples \dontrun{
#' passive_host("passivetotal.org")
#' }
passive_host <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/host-attributes/components",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Get all tracking codes for a domain or IP address.
#'
#' @param query	Query value to use in your request.
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Host_Attributes-GetV2HostAttributesTrackersQuery}
#' @export
#' @family Host attribute functions
#' @examples \dontrun{
#' passive_tracker("passivetotal.org")
#' }
passive_tracker <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/host-attributes/trackers",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Get hosts matching a specific tracker ID
#'
#' @param query	Query value to use in your request.
#' @param type A valid tracker type to search. One of
#'   \code{YandexMetricaCounterId}, \code{ClickyId},
#'   \code{GoogleAnalyticsAccountNumber}, \code{NewRelicId}, \code{MixpanelId},
#'   \code{GoogleAnalyticsTrackingId}
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Host_Attributes-GetV2HostAttributesTrackersQuery}
#' @export
#' @family Host attribute functions
#' @examples \dontrun{
#' passive_tracker_search(query="UA-49901229", type="GoogleAnalyticsAccountNumber")
#' }
passive_tracker_search <- function(query, auth=passive_auth()) {

  params <- list(query=query,
                 type=match.arg(type, valid_trackers))

  resp <- S_GET("https://api.passivetotal.org/v2/host-attributes/trackers",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}