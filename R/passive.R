#' Get or set PASSIVETOTAL_API_KEY value
#'
#' The API wrapper functions in this package all rely on a PassiveTotal API
#' key residing in the environment variable \code{PASSIVETOTAL_API_KEY}. The
#' easiest way to accomplish this is to set it in the `.Renviron` file in your
#' home directory.
#'
#' @param force Force setting a new PassiveTotal API key for the current environment?
#' @return atomic character vector containing the PassiveTotal API key
#' @export
passive_api_key <- function(force = FALSE) {

  env <- Sys.getenv('PASSIVETOTAL_API_KEY')
  if (!identical(env, "") && !force) return(env)

  if (!interactive()) {
    stop("Please set env var PASSIVETOTAL_API_KEY to your PassiveTotal API key",
      call. = FALSE)
  }

  message("Couldn't find env var PASSIVETOTAL_API_KEY See ?passive_api_key for more details.")
  message("Please enter your API key and press enter:")
  pat <- readline(": ")

  if (identical(pat, "")) {
    stop("PassiveTotal API key entry failed", call. = FALSE)
  }

  message("Updating PASSIVETOTAL_API_KEY env var to PAT")
  Sys.setenv(PASSIVETOTAL_API_KEY = pat)

  pat

}

# METADATA ----------------------------------------------------------------

#' Get metadata about a domain or IP address
#'
#' Metadata describes the item being queried and includes many of the options
#' available inside of the action API calls.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @return list of values
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
#' @examples \dontrun{
#' get_metadata("www.passivetotal.com")
#' $ever_compromised
#' [1] FALSE
#'
#' $tags
#' list()
#'
#' $dynamic
#' [1] FALSE
#'
#' $value
#' [1] "www.passivetotal.com"
#'
#' $subdomains
#' list()
#'
#' $query_value
#' [1] "www.passivetotal.com"
#'
#' $tld
#' [1] ".com"
#'
#' $primaryDomain
#' [1] "passivetotal.com"
#'
#' $type
#' [1] "domain"
#' }
get_metadata <- function(domain_or_ip) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip)
  resp <- GET("https://www.passivetotal.org/api/v1/metadata", query=params)
  stop_for_status(resp)
  tmp <- content(resp, as="parsed")
  return(tmp$results)

}

# PASSIVE -----------------------------------------------------------------

#' Get dynamic status of domain
#'
#' PassiveTotal provides a complete passive DNS picture for a domain or IP
#' address including first/last seen values, deconflicted values, sources used,
#' unique counts and enrichment for all values. In order to save bandwidth,
#' enrichment data is stored in it's own dictionary value and not associated
#' with the records.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @return list
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
#' @examples \dontrun{
#' get_passive("107.170.89.121")
#' ## $sources_used
#' ## [1] "dnsres"      "virustotal"  "mnemonic"    "domaintools" "pingly"
#' ## [6] "kaspersky"   "alienvault"
#' ##
#' ## $records
#' ## Source: local data frame [120 x 5]
#' ##
#' ##       source          resolve           last_seen          first_seen
#' ## 1  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
#' ## 2  kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
#' ## 3  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
#' ## 4  kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
#' ## 5  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
#' ## 6  kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
#' ## 7  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
#' ## 8  kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
#' ## 9  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
#' ## 10 kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
#' ## ..       ...              ...                 ...                 ...
#' ## Variables not shown: record_hash (chr)
#' ##
#' ## $unique_resolutions
#' ##                 domain  n
#' ## 1 www.passivetotal.org 25
#' ## 2 www.passivetotal.com 18
#' ## 3     passivetotal.com 35
#' ## 4     passivetotal.org 42
#' ##
#' ## $basic_map
#' ## Source: local data frame [4 x 7]
#' ##
#' ##     primary_domain classification dynamic                value  tld
#' ## 1 passivetotal.org                  FALSE www.passivetotal.org .org
#' ## 2 passivetotal.com                  FALSE www.passivetotal.com .com
#' ## 3 passivetotal.com                  FALSE     passivetotal.com .com
#' ## 4 passivetotal.org                  FALSE     passivetotal.org .org
#' ## Variables not shown: ever_compromised (lgl), type (chr)
#' ##
#' ## $enrichment_map
#' ## $enrichment_map$www.passivetotal.org
#' ## $enrichment_map$www.passivetotal.org$ever_compromised
#' ## [1] FALSE
#' ##
#' ## $enrichment_map$www.passivetotal.org$classification
#' ## [1] ""
#' ##
#' ## $enrichment_map$www.passivetotal.org$tags
#' ## list()
#' ##
#' ## $enrichment_map$www.passivetotal.org$dynamic
#' ## [1] FALSE
#' ##
#' ## $enrichment_map$www.passivetotal.org$value
#' ## [1] "www.passivetotal.org"
#' ##
#' ## $enrichment_map$www.passivetotal.org$subdomains
#' ## list()
#' ##
#' ## $enrichment_map$www.passivetotal.org$tld
#' ## [1] ".org"
#' ##
#' ## $enrichment_map$www.passivetotal.org$primaryDomain
#' ## [1] "passivetotal.org"
#' ##
#' ## $enrichment_map$www.passivetotal.org$type
#' ## [1] "domain"
#' ##
#' ##
#' ## $enrichment_map$www.passivetotal.com
#' ## $enrichment_map$www.passivetotal.com$primaryDomain
#' ## [1] "passivetotal.com"
#' ##
#' ## $enrichment_map$www.passivetotal.com$classification
#' ## [1] ""
#' ##
#' ## $enrichment_map$www.passivetotal.com$tags
#' ## list()
#' ##
#' ## $enrichment_map$www.passivetotal.com$dynamic
#' ## [1] FALSE
#' ##
#' ## $enrichment_map$www.passivetotal.com$value
#' ## [1] "www.passivetotal.com"
#' ##
#' ## $enrichment_map$www.passivetotal.com$subdomains
#' ## list()
#' ##
#' ## $enrichment_map$www.passivetotal.com$tld
#' ## [1] ".com"
#' ##
#' ## $enrichment_map$www.passivetotal.com$ever_compromised
#' ## [1] FALSE
#' ##
#' ## $enrichment_map$www.passivetotal.com$type
#' ## [1] "domain"
#' ##
#' ##
#' ## $enrichment_map$passivetotal.com
#' ## $enrichment_map$passivetotal.com$ever_compromised
#' ## [1] FALSE
#' ##
#' ## $enrichment_map$passivetotal.com$classification
#' ## [1] ""
#' ##
#' ## $enrichment_map$passivetotal.com$tags
#' ## list()
#' ##
#' ## $enrichment_map$passivetotal.com$dynamic
#' ## [1] FALSE
#' ##
#' ## $enrichment_map$passivetotal.com$value
#' ## [1] "passivetotal.com"
#' ##
#' ## $enrichment_map$passivetotal.com$subdomains
#' ## list()
#' ##
#' ## $enrichment_map$passivetotal.com$tld
#' ## [1] ".com"
#' ##
#' ## $enrichment_map$passivetotal.com$primaryDomain
#' ## [1] "passivetotal.com"
#' ##
#' ## $enrichment_map$passivetotal.com$type
#' ## [1] "domain"
#' ##
#' ##
#' ## $enrichment_map$passivetotal.org
#' ## $enrichment_map$passivetotal.org$ever_compromised
#' ## [1] FALSE
#' ##
#' ## $enrichment_map$passivetotal.org$classification
#' ## [1] ""
#' ##
#' ## $enrichment_map$passivetotal.org$tags
#' ## list()
#' ##
#' ## $enrichment_map$passivetotal.org$dynamic
#' ## [1] FALSE
#' ##
#' ## $enrichment_map$passivetotal.org$value
#' ## [1] "passivetotal.org"
#' ##
#' ## $enrichment_map$passivetotal.org$subdomains
#' ## list()
#' ##
#' ## $enrichment_map$passivetotal.org$tld
#' ## [1] ".org"
#' ##
#' ## $enrichment_map$passivetotal.org$primaryDomain
#' ## [1] "passivetotal.org"
#' ##
#' ## $enrichment_map$passivetotal.org$type
#' ## [1] "domain"
#' }
get_passive <- function(domain_or_ip) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip)
  resp <- GET("https://www.passivetotal.org/api/v1/passive", query=params)
  stop_for_status(resp)
  tmp <- content(resp, as="parsed")

  sources_used <- unlist(tmp$results$sources_used)

  records <- bind_rows(lapply(tmp$results$records, function(x) {

    source <- paste(unlist(x$source), collapse=",")
    data_frame(source=source,
               resolve=x$resolve,
               last_seen=x$lastSeen,
               first_seen=x$firstSeen,
               record_hash=x$recordHash)


  }))

  data.frame(t(as.data.frame(tmp$results$unique_resolutions, stringsAsFactors=FALSE)),
             stringsAsFactors=FALSE) %>%
    add_rownames() %>%
    select(domain=1, n=2) -> unique_resolutions

  enrichment_map <- tmp$results$enrichment_map

  basic_map <- bind_rows(lapply(tmp$results$enrichment_map, function(x) {

    data_frame(primary_domain=x$primaryDomain,
               classification=x$classification,
               dynamic=x$dynamic,
               value=x$value,
               tld=x$tld,
               ever_compromised=x$ever_compromised,
               type=x$type)

  }))

  list(sources_used=sources_used,
       records=records,
       unique_resolutions=unique_resolutions,
       basic_map=basic_map,
       enrichment_map=enrichment_map)

}

# SUBDOMAINS --------------------------------------------------------------

#' Get subdomains for a domain
#'
#' Subdomains provides a comprehensive view of all known subdomains for a
#' registered domain with associated passive DNS information. This call is best
#' used to understand the activity of a particular domain over a period of
#' time. Passive DNS information is only deconflicted at the subdomain level,
#' not across the entire domain.
#'
#' @param domain atomic character vector containing a domain name
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
get_subdomains <- function(domain) {

  test_param(domain)

  params <- list(api_key=passive_api_key(), query=domain)
  resp <- GET("https://www.passivetotal.org/api/v1/subdomains", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")

}

# UNIQUE ------------------------------------------------------------------

#' Get unique resolution information including frequency count
#'
#' Each domain or IP address with results has a unique set of resolving items.
#' This call provides those unique items and a frequency count of how often
#' they show up in sorted order.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @return tbl_df
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
#' @examples \dontrun{
#' get_unique("passivetotal.org")
#' Source: local data frame [3 x 2]
#'
#'                ip n
#' 1  107.170.89.121 2
#' 2 104.131.121.205 1
#' 3 162.243.102.221 1
#' }
get_unique <- function(domain_or_ip) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip)
  resp <- GET("https://www.passivetotal.org/api/v1/unique", query=params)
  stop_for_status(resp)
  tmp <- content(resp, as="parsed")

  data.frame(t(as.data.frame(tmp$results, stringsAsFactors=FALSE)), stringsAsFactors=FALSE) %>%
    add_rownames() %>%
    select_("ip"=1, "n"=2) %>%
    mutate_("ip"=str_replace("ip", "^X", "")) %>%
    tbl_df
}

# CLASSIFICATION ----------------------------------------------------------

#' Get classification for a domain or IP address
#'
#' PassiveTotal uses the notion of classifications to highlight table rows a
#' certain color based on how they have been rated. There are four types of
#' classification: "targeted", "crime", "multiple", or "benign"
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @return tbl_df
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
get_classification <- function(domain_or_ip) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip)
  resp <- GET("https://www.passivetotal.org/api/v1/classification", query=params)
  stop_for_status(resp)
  tmp <- content(resp, as="parsed")

  tmp$results$classification

}

#' Set a classification for a domain or IP address
#'
#' PassiveTotal uses the notion of classifications to highlight table rows a
#' certain color based on how they have been rated. There are four types of
#' classification: "targeted", "crime", "multiple", or "benign"
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @param classification classification to set ("targeted", "crime",
#'        "multiple", or "benign")
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
set_classification <- function(domain_or_ip, classification) {

  test_param(domain_or_ip)

  if (classification %in% c("targeted", "crime", "multiple", "benign")) {
    stop('"classification" must be one of "targeted", "crime", "multiple", or "benign"',
         call.=FALSE)
  }

  params <- list(api_key=passive_api_key(), query=domain_or_ip, classification=classification)
  resp <- POST("https://www.passivetotal.org/api/v1/classification", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")

}

# TAGS --------------------------------------------------------------------

#' Get user tags for a domain or IP address
#'
#' PassiveTotal uses three types of tags (user, global, and temporal) in order
#' to provide context back to the user.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @return tbl_df
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
get_tags <- function(domain_or_ip) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip)
  resp <- GET("https://www.passivetotal.org/api/v1/user/tags", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")
}

#' Add a tag to a domain name or IP address
#'
#' PassiveTotal uses three types of tags (user, global, and temporal) in order
#' to provide context back to the user.
#'
#' @param domain_or_ip a domain or IP address to tag
#' @param tag value used to tag query value. Should only consist of alphanumeric,
#'        underscores and hyphen values
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
add_tag <- function(domain_or_ip, tag) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip, tag=tag)
  resp <- POST("https://www.passivetotal.org/api/v1/user/tag/add", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")
}

#' Remove a tag fgrom a domain name or IP address
#'
#' PassiveTotal uses three types of tags (user, global, and temporal) in order
#' to provide context back to the user.
#'
#' @param domain_or_ip a domain or IP address to tag
#' @param tag value used to tag query value. Should only consist of alphanumeric,
#'        underscores and hyphen values
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
remove_tag <- function(domain_or_ip, tag) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip, tag=tag)
  resp <- POST("https://www.passivetotal.org/api/v1/user/tag/remove", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")
}

# SINKHOLE ----------------------------------------------------------------

#' Check sinkhole status of an IP address
#'
#' PassiveTotal allows users to notate if an IP address is a known sinkhole.
#' These values are shared globally with everyone in the platform.
#'
#' @param ip atomic character vector containing an IP address
#' @return logical
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
is_sinkhole <- function(ip) {

  if (!is_ip(ip)) {
    stop(sprintf('"%s" does not look like an IPv4 address', ip),
         call. = FALSE)
  }

  params <- list(api_key=passive_api_key(), query=ip)
  resp <- GET("https://www.passivetotal.org/api/v1/sinkhole", query=params)
  stop_for_status(resp)
  tmp <- content(resp, as="parsed")

  tmp$results$sinkhole

}

#' Set sinkhole status of IP address
#'
#' PassiveTotal allows users to notate if an IP address is a known sinkhole.
#' These values are shared globally with everyone in the platform.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @param is_sinkhole logical (\code{TRUE} if sinkhole)
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
set_sinkhole <- function(domain_or_ip, is_sinkhole) {

  test_param(domain_or_ip)

  if (typeof(is_sinkhole) != logical) {
    stop('"is_sinkhole" must be either TRUE or FALSE', call.=FALSE)
  }

  params <- list(api_key=passive_api_key(), query=domain_or_ip, sinkhole=is_sinkhole)
  resp <- POST("https://www.passivetotal.org/api/v1/sinkhole", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")
}

# COMPROMISED -------------------------------------------------------------

#' Get whether a site was ever compromised
#'
#' PassiveTotal allows users to notate if a domain or IP address have ever been
#' compromised. These values aid in letting users know that a site may be
#' benign, but it was used in an attack at some point in time.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @return logical
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
was_ever_compromised <- function(domain_or_ip) {

  test_param(domain_or_ip)

  params <- list(passive_api_key(), query=domain_or_ip)
  resp <- GET("https://www.passivetotal.org/api/v1/ever_compromised", query=params)
  stop_for_status(resp)
  tmp <- content(resp, as="parsed")

  tmp$results$sinkhole

}

#' Set ever_compromised status for a domain or IP address
#'
#' PassiveTotal allows users to notate if a domain or IP address have ever been
#' compromised. These values aid in letting users know that a site may be
#' benign, but it was used in an attack at some point in time.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @param is_compromised logical (\code{TRUE} if compromised)
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
set_compromised <- function(domain_or_ip, is_compromised) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip, ever_compromised=is_compromised)
  resp <- POST("https://www.passivetotal.org/api/v1/ever_compromised", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")
}

# DYNAMIC DNS -------------------------------------------------------------

#' Get whether a domain is associated with a dynamic DNS provider
#'
#' PassiveTotal allows users to notate if a domain is associated with a
#' dynamic DNS provider.
#'
#' @param domain atomic character vector containing a domain name
#' @return logical
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
is_dynamic_associated <- function(domain) {


  if (!is_fqdn(domain)) {
    stop(sprintf('"%s" does not look like an FQDN', domain),
         call. = FALSE)
  }

  params <- list(api_key=passive_api_key(), query=domain)
  resp <- GET("https://www.passivetotal.org/api/v1/dynamic", query=params)
  stop_for_status(resp)
  tmp <- content(resp, as="parsed")

  tmp$results$dynamic

}

#' Set dynamic status of domain
#'
#' PassiveTotal allows users to notate if a domain is associated with a
#' dynamic DNS provider.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @param is_dynamic logical \code{TRUE} if dynamic
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
set_dynamic_associated <- function(domain_or_ip, is_dynamic) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip, dynamic=is_dynamic)
  resp <- POST("https://www.passivetotal.org/api/v1/dynamic", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")
}

# WATCHING ----------------------------------------------------------------

#' Get watch status for a domain or IP address
#'
#' PassiveTotal allows users to "watch" domains or IP addresses in order to get
#' notified of any changes.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @return logical
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
is_on_watchlist <- function(domain_or_ip) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip)
  resp <- GET("https://www.passivetotal.org/api/v1/watching", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")

  tmp <- content(resp, as="parsed")

  tmp$results$dynamic

}

#' Set watch status for a domain
#'
#' PassiveTotal allows users to "watch" domains or IP addresses in order to get
#' notified of any changes.
#'
#' @param domain_or_ip atomic character vector containing an IP address or
#'        domain name
#' @param is_watching logical (\code{TRUE} if watching entity)
#' @seealso \href{PassiveTotal API documentation}{https://www.passivetotal.org/api/docs}
#' @export
#' @note PassiveTotal API key must be set in the environment.
#'       See: \code{\link{passive_api_key}} for more details.
set_watching <- function(domain_or_ip, is_watching) {

  test_param(domain_or_ip)

  params <- list(api_key=passive_api_key(), query=domain_or_ip, dynamic=is_watching)
  resp <- POST("https://www.passivetotal.org/api/v1/watching", query=params)
  stop_for_status(resp)
  content(resp, as="parsed")
}

