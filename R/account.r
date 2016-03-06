#' Get account details your account.
#'
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @return \code{tbl_df} of account details
#' @param Account functions
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2Account}
#' @export
account_info <- function(auth=passive_auth()) {

  resp <- S_GET("https://api.passivetotal.org/v2/account",
                httr::authenticate(auth$user, auth$key))

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE),
                    stringsAsFactors=FALSE))

}

#' Get history associated with your account.
#'
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @param source optional	Source of the action: \code{web}, \code{api}
#' @param dt optional	Datetime to be used as a filter.
#' @param type optional Type of history: \code{search}, \code{classify}, \code{tag}, \code{watch}
#' @param focus optional Specific value that was used as the focus of the history.
#' @param Account functions
#' @return \code{tbl_df} of account history details
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountHistory}
#' @export
account_history <- function(source=c("", "web", "api"),
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

#' Get notifications that have been posted to your account.
#'
#' @param type optional Type of notifications to get back.
#' @return \code{tbl_df} of account notifications details
#' @param Account functions
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountNotifications}
#' @export
account_notifications <- function(type=NULL, auth=passive_auth()) {

  params <- list(type=type)

  resp <- S_GET("https://api.passivetotal.org/v2/account/notifications",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  tbl_df(data.frame(jsonlite::fromJSON(res, flatten=TRUE)$notifications,
                    stringsAsFactors=FALSE))

}

#' Get details about the organization your account is associated with.
#'
#' @param type optional Type of notifications to get back.
#' @return \code{list} of account organization details
#' @param Account functions
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountOrganization}
#' @export
account_organization <- function(auth=passive_auth()) {

  resp <- S_GET("https://api.passivetotal.org/v2/account/organization",
                httr::authenticate(auth$user, auth$key))

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Get the teamstream for the organization your account is associated with.
#'
#' @param auth \code{list} containing PassiveTotal \code{user} & \code{key}
#' @param source optional	Source of the action: \code{web}, \code{api}
#' @param dt optional	Datetime to be used as a filter.
#' @param type optional Type of history: \code{search}, \code{classify}, \code{tag}, \code{watch}
#' @param focus optional Specific value that was used as the focus of the history.
#' @param Account functions
#' @return \code{tbl_df} of account teamstream details
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountOrganizationTeamstream}
#' @export
account_teamstream <- function(source=c("", "web", "api"),
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

#' Get source details for a specific source.
#'
#' @param source optional Name of the source to pull back.
#' @return \code{list} of account source details
#' @param Account functions
#' @references \url{https://api.passivetotal.org/api/docs/#api-Account-GetV2AccountSourcesSource}
#' @export
account_sources <- function(source=NULL, auth=passive_auth()) {

  params <- list(source=source)

  resp <- S_GET("https://api.passivetotal.org/v2/account/sources",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  tbl_df(jsonlite::fromJSON(res, flatten=TRUE)$sources)

}