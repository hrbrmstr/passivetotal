
is_ip <- function(thing) {
  length(grep("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", thing)) > 0
}

is_fqdn <- function(thing) {
  length(grep("^([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*\\.)+[a-zA-Z]{2,}$", thing)) > 0
}

test_param <- function(thing) {

  if (!(is_ip(thing) | is_fqdn(thing))) {
    stop(sprintf('"%s" does not look like an IPv4 address or FQDN', thing),
         call. = FALSE)
  }

}
