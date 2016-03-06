#' Validate that a string is an IPv4 address
#'
#' Returns \code{FALSE} if \code{x} is not four octet IPv4 address
#'
#' @param x string to test
#' @return \code{logical}
#' @family Utility functions
#' @export
#' @examples
#' is_ipv4("10.10.10.10")
is_ipv4 <- function(x) {
  if (length(grep("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", x)) > 0) {
    return(all(as.numeric(stringr::str_split_fixed(x, "\\.", 4)) < 255))
  } else {
    return(FALSE)
  }
}

#' Validate that a string looks like a fully qualified domain name
#'
#' Returns \code{FALSE} if \code{x} does not "look like" a FQDN
#' @param x string to test
#' @return \code{logical}
#' @family Utility functions
#' @export
#' @examples
#' is_fqdn("rud.is")
is_fqdn <- function(x) {
  length(grep("^([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*\\.)+[a-zA-Z]{2,}$", x)) > 0
}



