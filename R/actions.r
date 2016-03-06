#' Get the status of a classification domain
#'
#' @param query	Query value to use in your request.
#' @family action functions
#' @references \url{https://api.passivetotal.org/api/docs/#api-Actions}
#' @return \code{list}
#' @export
#' @examples \dontrun{
#' passive_classification("passivetotal.org")
#' }
passive_classification <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/actions/ever-compromised",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Get the status of an observable
#'
#' @param query	Query value to use in your request.
#' @param type status query type. \code{compromised} or \code{c},
#'        \code{dynamic} or \code{d}, \code{monitor} or \code{m},
#'        \code{sinkhole} or \code{s}
#' @return \code{logical}
#' @family action functions
#' @references \url{https://api.passivetotal.org/api/docs/#api-Actions}
#' @export
#' @examples \dontrun{
#' passive_status("passivetotal.org", "compromised")
#' passive_status("passivetotal.org", "c")
#' passive_status("passivetotal.org", "dynamic")
#' passive_status("passivetotal.org", "d")
#' passive_status("passivetotal.org", "monitor")
#' passive_status("passivetotal.org", "m")
#' passive_status("52.8.228.23", "sinkhole")
#' passive_status("52.8.228.23", "s")
#' }
passive_status <- function(query, type, auth=passive_auth()) {

  params <- list(query=query)

  type <- class_map[[match.arg(type, valid_classifications)]]

  resp <- S_GET(sprintf("https://api.passivetotal.org/v2/actions/%s", type),
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  purrr::flatten_lgl(jsonlite::fromJSON(res, flatten=TRUE))

}

#' @rdname passive_status
#' @export
is_sinkhole <- function(query, auth=passive_auth()) {
  passive_status(query, "sinkhole", auth)
}

#' @rdname passive_status
#' @export
is_compromised <- function(query, auth=passive_auth()) {
  passive_status(query, "compromised", auth)
}

#' @rdname passive_status
#' @export
is_monitored <- function(query, auth=passive_auth()) {
  passive_status(query, "monitor", auth)
}

#' @rdname passive_status
#' @export
is_dynamic<- function(query, auth=passive_auth()) {
  passive_status(query, "dynamic", auth)
}

#' Get the tags for a query value
#'
#' @param query	Query value to use in your request.
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Actions-GetV2ActionsTagsQuery}
#' @family action functions
#' @export
#' @examples \dontrun{
#' passive_tags("passivetotal.org")
#' }
passive_tags <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/actions/tags",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}

#' Search for items based on tag value
#'
#' @param query	Query value to use in your request.
#' @return \code{list}
#' @references \url{https://api.passivetotal.org/api/docs/#api-Actions-GetV2ActionsTagsQuery}
#' @family action functions
#' @export
#' @examples \dontrun{
#' passive_tag_search("passivetotal.org")
#' }
passive_tag_search <- function(query, auth=passive_auth()) {

  params <- list(query=query)

  resp <- S_GET("https://api.passivetotal.org/v2/actions/tags/search",
                httr::authenticate(auth$user, auth$key),
                query=params)

  httr::stop_for_status(resp$result)

  res <- httr::content(resp$result, as="text", encoding="UTF-8")

  jsonlite::fromJSON(res, flatten=TRUE)

}