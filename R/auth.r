#' Get or set PASSIVETOTAL_USER & PASSIVETOTAL_API_KEY values
#'
#' The API wrapper functions in this package all rely on a PassiveTotal API
#' key residing in the environment variables code{PASSIVETOTAL_USER} &
#' \code{PASSIVETOTAL_API_KEY}. The easiest way to accomplish this is to set
#' them in the `.Renviron` file in your home directory.
#'
#' @param force force setting a new PassiveTotal API username & key for the
#'        current environment?
#' @return \code{list} containing the combined PassiveTotal username & API key
#' @export
passive_auth <- function(force=FALSE) {

  user <- Sys.getenv('PASSIVETOTAL_USER')
  key <- Sys.getenv('PASSIVETOTAL_API_KEY')

  if (!(identical(user, "") |
        identical(key, "")) && !force) {
    return(list(user=user, key=key))
  }

  if (!interactive()) {
    stop(paste0("Please set env vars PASSIVETITAL_USER & PASSIVETOTAL_API_KEY ",
                "to your PassiveTotal username & API key", sep="", collapse=""),
                call. = FALSE)
  }

  if (identical(user, "")) {

    message("Couldn't find env var PASSIVETOTAL_USER See ?passive_api_key for more details.")
    message("Please enter your API username (username@yourdomain.com) and press enter:")
    pat <- readline(": ")

    if (identical(pat, "")) {
      stop("PassiveTotal API user id entry failed", call. = FALSE)
    }

    message("Updating PASSIVETOTAL_USER env var to PAT")
    Sys.setenv(PASSIVETOTAL_USER = pat)

  }


  if (identical(key, "")) {

    message("Couldn't find env var PASSIVETOTAL_API_KEY See ?passive_api_key for more details.")
    message("Please enter your API key and press enter:")
    pat <- readline(": ")

    if (identical(pat, "")) {
      stop("PassiveTotal API key entry failed", call. = FALSE)
    }

    message("Updating PASSIVETOTAL_API_KEY env var to PAT")
    Sys.setenv(PASSIVETOTAL_API_KEY = pat)

  }

  user <- Sys.getenv('PASSIVETOTAL_API_KEY')
  key <- Sys.getenv('PASSIVETOTAL_API_KEY')

  return(list(user=user, key=key))

}

