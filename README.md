
`passivetotal` is an R package to interface with the [PassiveTotal API](https://api.passivetotal.org/api/docs/)

This has BREAKNG CHANGES since it now only works with version 2 of the API.

You should set `PASSIVETOTAL_USER` & `PASSIVETOTAL_API_KEY` in `.Renviron` or you'll either be prompted for them or will need to pass them to each function manually.

The following functions are implemented:

-   `account_history`: Get history associated with your account.
-   `account_info`: Get account details your account.
-   `account_notifications`: Get notifications that have been posted to your account.
-   `account_organization`: Get details about the organization your account is associated with.
-   `account_sources`: Get source details for a specific source.
-   `account_teamstream`: Get the teamstream for the organization your account is associated with.
-   `is_compromised`: Get the status of an observable
-   `is_dynamic`: Get the status of an observable
-   `is_fqdn`: Validate that a string looks like a fully qualified domain name
-   `is_ipv4`: Validate that a string is an IPv4 address
-   `is_monitored`: Get the status of an observable
-   `is_sinkhole`: Get the status of an observable
-   `passive_auth`: Get or set `PASSIVETOTAL_USER` & `PASSIVETOTAL_API_KEY` values
-   `passive_classification`: Get the status of a classification domain
-   `passive_dns`: Get passive DNS data
-   `passive_enrich`: Enrich the given query with metadata
-   `passive_host`: Get detailed information about a host
-   `passive_malware`: Get malware data
-   `passive_osint`: Get opensource intelligence data
-   `passive_ssl_certificate`: Get the SSL certificate associated with the SHA-1.
-   `passive_ssl_history`: Get the SSL certificate history associated with an IP address or SHA-1
-   `passive_ssl_search`: Get the SSL certificate associated with the SHA-1.
-   `passive_status`: Get the status of an observable
-   `passive_subdomains`: Get subdomains using a wildcard query
-   `passive_tags`: Get the tags for a query value
-   `passive_tag_search`: Search for items based on tag value
-   `passive_tracker`: Get all tracking codes for a domain or IP address.
-   `passive_tracker_search`: Get hosts matching a specific tracker ID
-   `passive_unique`: Get unique resolutions from passive DNS data
-   `passive_whois`: Get WHOIS data for a domain or IP address
-   `passive_whois_search`: Get WHOIS records based on field matching queries.

### Installation

``` r
devtools::install_github("hrbrmstr/passivetotal")
```

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
