% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/actions.r
\name{passive_status}
\alias{is_compromised}
\alias{is_dynamic}
\alias{is_monitored}
\alias{is_sinkhole}
\alias{passive_status}
\title{Get the status of an observable}
\usage{
passive_status(query, type, auth = passive_auth())

is_sinkhole(query, auth = passive_auth())

is_compromised(query, auth = passive_auth())

is_monitored(query, auth = passive_auth())

is_dynamic(query, auth = passive_auth())
}
\arguments{
\item{query}{Query value to use in your request.}

\item{type}{status query type. \code{compromised} or \code{c},
\code{dynamic} or \code{d}, \code{monitor} or \code{m},
\code{sinkhole} or \code{s}}

\item{auth}{\code{list} containing PassiveTotal \code{user} & \code{key}}
}
\value{
\code{logical}
}
\description{
Get the status of an observable
}
\note{
All API function in the \code{passivetotal} pacake use \code{memoise::memoise} to
      cache results. Call \code{forget(passive_status)} (etc.) to invalidate the
      cache for this function.
}
\examples{
\dontrun{
passive_status("passivetotal.org", "compromised")
passive_status("passivetotal.org", "c")
passive_status("passivetotal.org", "dynamic")
passive_status("passivetotal.org", "d")
passive_status("passivetotal.org", "monitor")
passive_status("passivetotal.org", "m")
passive_status("52.8.228.23", "sinkhole")
passive_status("52.8.228.23", "s")
}
}
\references{
\url{https://api.passivetotal.org/api/docs/#api-Actions}
}
\seealso{
Other action functions: \code{\link{passive_classification}},
  \code{\link{passive_tag_search}},
  \code{\link{passive_tags}}
}

