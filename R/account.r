# documentation for these functions are in their memoised versions below

.account_teamstream <- function(source=c("", "web", "api"),
                               dt=NULL,
                               type=c("", "search", "classify", "tag", "watch"),
                               focus=NULL,
                               auth=passive_auth()) {

  params <- list(source=match.arg(source, c("", "web", "api")),
                 dt=dt,
                 type=match.arg(type, c("", "search", "classify", "tag", "watch")),
                 focus=focus)

  resp <- S_GET("https://api.passivetotal.org/v2/account/organization/teamstream",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE)$teamstream,
                    stringsAsFactors=FALSE))

}

.account_organization <- function(auth=passive_auth()) {

  resp <- S_GET("https://api.passivetotal.org/v2/account/organization",
                httr::authenticate(auth$user, auth$key))

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

.account_notifications <- function(type=NULL, auth=passive_auth()) {

  params <- list(type=type)

  resp <- S_GET("https://api.passivetotal.org/v2/account/notifications",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE)$notifications,
                    stringsAsFactors=FALSE))

}

.account_history <- function(source=c("", "web", "api"),
                            dt=NULL,
                            type=c("", "search", "classify", "tag", "watch"),
                            focus=NULL,
                            auth=passive_auth()) {

  params <- list(source=match.arg(source, c("", "web", "api")),
                 dt=dt,
                 type=match.arg(type, c("", "search", "classify", "tag", "watch")),
                 focus=focus)

  resp <- S_GET("https://api.passivetotal.org/v2/account/history",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  tbl_df(jsonlite::fromJSON(res, flatten=TRUE)$history)

}

.account_info <- function(auth=passive_auth()) {

  resp <- S_GET("https://api.passivetotal.org/v2/account",
                httr::authenticate(auth$user, auth$key))

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE),
                    stringsAsFactors=FALSE))

}

.account_sources <- function(source=NULL, auth=passive_auth()) {

  params <- list(source=source)

  resp <- S_GET("https://api.passivetotal.org/v2/account/sources",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  tbl_df(jsonlite::fromJSON(res, flatten=TRUE)$sources)

}

#' Get account details your account.
#'
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{tbl_df} of account details
#' @family Account functions
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(account_info)} to invalidate the cache for this
#'       function.
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2Account}
#' @export
account_info <- memoise::memoise(.account_info)

#' Get history associated with your account.
#'
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @param source optional	Source of the action: \code{web}, \code{api}
#' @param dt optional	Datetime to be used as a filter.
#' @param type optional Type of history: \code{search}, \code{classify}, \code{tag}, \code{watch}
#' @param focus optional Specific value that was used as the focus of the history.
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(account_history)} to invalidate the cache for this
#'       function.
#' @family Account functions
#' @return \code{tbl_df} of account history details
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountHistory}
#' @export
account_history <- memoise::memoise(.account_history)

#' Get notifications that have been posted to your account.
#'
#' @param type optional Type of notifications to get back.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{tbl_df} of account notifications details
#' @family Account functions
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(account_notifications)} to invalidate the cache for this
#'       function.
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountNotifications}
#' @export
account_notifications <- memoise::memoise(.account_notifications)

#' Get details about the organization your account is associated with.
#'
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{list} of account organization details
#' @family Account functions
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(account_organization)} to invalidate the cache for this
#'       function.
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountOrganization}
#' @export
account_organization <- memoise::memoise(.account_organization)

#' Get the teamstream for the organization your account is associated with.
#'
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @param source optional	Source of the action: \code{web}, \code{api}
#' @param dt optional	Datetime to be used as a filter.
#' @param type optional Type of history: \code{search}, \code{classify}, \code{tag}, \code{watch}
#' @param focus optional Specific value that was used as the focus of the history.
#' @family Account functions
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(account_teamstream)} to invalidate the cache for this
#'       function.
#' @return \code{tbl_df} of account teamstream details
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountOrganizationTeamstream}
#' @export
account_teamstream <- memoise::memoise(.account_teamstream)

#' Get source details for a specific source.
#'
#' @param source optional Name of the source to pull back.
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{list} of account source details
#' @family Account functions
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountSourcesSource}
#' @note All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
#'       cache results. Call \code{forget(account_sources)} to invalidate the cache for this
#'       function.
#' @export
account_sources <- memoise::memoise(.account_sources)

