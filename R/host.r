# documentation for these functions are in their memoised versions below

.passive_tracker <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/host-attributes/trackers",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  dplyr::tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE)$results,
                           stringsAsFactors=FALSE))

}

.passive_host <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/host-attributes/components",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  dplyr::tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE)$results,
                           stringsAsFactors=FALSE))

}

.passive_tracker_search <- function(query, type, auth=passive_auth()) {

  params <- list(query=query,
                 type=match.arg(type, valid_trackers))

  resp <- S_GET("https://api.passivetotal.org/v2/trackers/search",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  dplyr::tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE)$results,
                           stringsAsFactors=FALSE))

}

#' Get detailed information about a host
#'
#' @param query	Query value to use in your request.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{tbl_df}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Host_Attributes}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_host)} to invalidate the cache for this
#'       function.
#' @export
#' @family Host attribute functions
#' @examples \dontrun{
#' passive_host("passivetotal.org")
#' }
passive_host <- memoise::memoise(.passive_host)


#' Get all tracking codes for a domain or IP address.
#'
#' @param query	Query value to use in your request.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{tbl_df}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Host_Attributes-GetV2HostAttributesTrackersQuery}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_tracker)} to invalidate the cache for this
#'       function.
#' @export
#' @family Host attribute functions
#' @examples \dontrun{
#' passive_tracker("passivetotal.org")
#' }
passive_tracker <- memoise::memoise(.passive_tracker)


#' Get hosts matching a specific tracker ID
#'
#' @param query	Query value to use in your request.
#' @param type A valid tracker type to search. One of
#'   \code{YandexMetricaCounterId}, \code{ClickyId},
#'   \code{GoogleAnalyticsAccountNumber}, \code{NewRelicId}, \code{MixpanelId},
#'   \code{GoogleAnalyticsTrackingId}
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{tbl_df}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Host_Attributes-GetV2HostAttributesTrackersQuery}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(passive_tracker_search)} to invalidate the cache for this
#'       function.
#' @export
#' @family Host attribute functions
#' @examples \dontrun{
#' passive_tracker_search(query="UA-49901229", type="GoogleAnalyticsAccountNumber")
#' }
passive_tracker_search <- memoise::memoise(.passive_tracker_search)
