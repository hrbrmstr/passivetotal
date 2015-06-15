passivetotal is an R package to interface with the [PassiveTotal API](https://www.passivetotal.org/api/docs)

The following functions are implemented:

-   `add_tag` : Add a tag to a domain name or IP address
-   `get_classification` : Get classification for a domain or IP address
-   `get_metadata` : Get metadata about a domain or IP address
-   `get_passive` : Get dynamic status of domain
-   `get_subdomains` : Get subdomains for a domain
-   `get_tags` : Get user tags for a domain or IP address
-   `get_unique` : Get unique resolution information including frequency count
-   `is_dynamic_associated` : Get whether a domain is associated with a dynamic DNS provider
-   `is_on_watchlist` : Get watch status for a domain or IP address
-   `is_sinkhole` : Check sinkhole status of an IP address
-   `passive_api_key` : Get or set `PASSIVETOTAL_API_KEY` value
-   `remove_tag` : Remove a tag fgrom a domain name or IP address
-   `set_classification` : Set a classification for a domain or IP address
-   `set_compromised` : Set `ever_compromised` status for a domain or IP address
-   `set_dynamic_associated` : Set dynamic status of domain
-   `set_sinkhole` : Set sinkhole status of IP address
-   `set_watching` : Set watch status for a domain
-   `was_ever_compromised` : Get whether a site was ever compromised

### News

-   Version 0.1.0 released
-   Version 0.1.1 released : completed documentation; tested with `--as-cran` and fixed errors & warnings

### Installation

``` r
devtools::install_github("hrbrmstr/passivetotal")
```

### Usage

``` r
library(passivetotal)
```

    ## Loading required package: dplyr
    ## 
    ## Attaching package: 'dplyr'
    ## 
    ## The following object is masked from 'package:stats':
    ## 
    ##     filter
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
# current verison
packageVersion("passivetotal")
```

    ## [1] '0.1.1'

``` r
get_metadata("www.passivetotal.com")
```

    ## $ever_compromised
    ## [1] FALSE
    ## 
    ## $tags
    ## list()
    ## 
    ## $dynamic
    ## [1] FALSE
    ## 
    ## $value
    ## [1] "www.passivetotal.com"
    ## 
    ## $subdomains
    ## list()
    ## 
    ## $query_value
    ## [1] "www.passivetotal.com"
    ## 
    ## $tld
    ## [1] ".com"
    ## 
    ## $primaryDomain
    ## [1] "passivetotal.com"
    ## 
    ## $type
    ## [1] "domain"

``` r
get_passive("107.170.89.121")
```

    ## $sources_used
    ## [1] "dnsres"      "virustotal"  "mnemonic"    "domaintools" "pingly"      "kaspersky"   "alienvault" 
    ## 
    ## $records
    ## Source: local data frame [120 x 5]
    ## 
    ##       source          resolve           last_seen          first_seen
    ## 1  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
    ## 2  kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
    ## 3  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
    ## 4  kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
    ## 5  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
    ## 6  kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
    ## 7  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
    ## 8  kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
    ## 9  kaspersky passivetotal.org 2015-06-01 04:42:47 2014-07-08 14:22:46
    ## 10 kaspersky passivetotal.com 2015-06-01 04:42:47 2015-02-04 18:46:30
    ## ..       ...              ...                 ...                 ...
    ## Variables not shown: record_hash (chr)
    ## 
    ## $unique_resolutions
    ##                 domain  n
    ## 1 www.passivetotal.org 22
    ## 2 www.passivetotal.com 19
    ## 3     passivetotal.com 38
    ## 4     passivetotal.org 41
    ## 
    ## $basic_map
    ## Source: local data frame [4 x 7]
    ## 
    ##     primary_domain classification dynamic                value  tld ever_compromised   type
    ## 1 passivetotal.org                  FALSE www.passivetotal.org .org            FALSE domain
    ## 2 passivetotal.com                  FALSE www.passivetotal.com .com            FALSE domain
    ## 3 passivetotal.com                  FALSE     passivetotal.com .com            FALSE domain
    ## 4 passivetotal.org                  FALSE     passivetotal.org .org            FALSE domain
    ## 
    ## $enrichment_map
    ## $enrichment_map$www.passivetotal.org
    ## $enrichment_map$www.passivetotal.org$ever_compromised
    ## [1] FALSE
    ## 
    ## $enrichment_map$www.passivetotal.org$classification
    ## [1] ""
    ## 
    ## $enrichment_map$www.passivetotal.org$tags
    ## list()
    ## 
    ## $enrichment_map$www.passivetotal.org$dynamic
    ## [1] FALSE
    ## 
    ## $enrichment_map$www.passivetotal.org$value
    ## [1] "www.passivetotal.org"
    ## 
    ## $enrichment_map$www.passivetotal.org$subdomains
    ## list()
    ## 
    ## $enrichment_map$www.passivetotal.org$tld
    ## [1] ".org"
    ## 
    ## $enrichment_map$www.passivetotal.org$primaryDomain
    ## [1] "passivetotal.org"
    ## 
    ## $enrichment_map$www.passivetotal.org$type
    ## [1] "domain"
    ## 
    ## 
    ## $enrichment_map$www.passivetotal.com
    ## $enrichment_map$www.passivetotal.com$primaryDomain
    ## [1] "passivetotal.com"
    ## 
    ## $enrichment_map$www.passivetotal.com$classification
    ## [1] ""
    ## 
    ## $enrichment_map$www.passivetotal.com$tags
    ## list()
    ## 
    ## $enrichment_map$www.passivetotal.com$dynamic
    ## [1] FALSE
    ## 
    ## $enrichment_map$www.passivetotal.com$value
    ## [1] "www.passivetotal.com"
    ## 
    ## $enrichment_map$www.passivetotal.com$subdomains
    ## list()
    ## 
    ## $enrichment_map$www.passivetotal.com$tld
    ## [1] ".com"
    ## 
    ## $enrichment_map$www.passivetotal.com$ever_compromised
    ## [1] FALSE
    ## 
    ## $enrichment_map$www.passivetotal.com$type
    ## [1] "domain"
    ## 
    ## 
    ## $enrichment_map$passivetotal.com
    ## $enrichment_map$passivetotal.com$ever_compromised
    ## [1] FALSE
    ## 
    ## $enrichment_map$passivetotal.com$classification
    ## [1] ""
    ## 
    ## $enrichment_map$passivetotal.com$tags
    ## list()
    ## 
    ## $enrichment_map$passivetotal.com$dynamic
    ## [1] FALSE
    ## 
    ## $enrichment_map$passivetotal.com$value
    ## [1] "passivetotal.com"
    ## 
    ## $enrichment_map$passivetotal.com$subdomains
    ## list()
    ## 
    ## $enrichment_map$passivetotal.com$tld
    ## [1] ".com"
    ## 
    ## $enrichment_map$passivetotal.com$primaryDomain
    ## [1] "passivetotal.com"
    ## 
    ## $enrichment_map$passivetotal.com$type
    ## [1] "domain"
    ## 
    ## 
    ## $enrichment_map$passivetotal.org
    ## $enrichment_map$passivetotal.org$ever_compromised
    ## [1] FALSE
    ## 
    ## $enrichment_map$passivetotal.org$classification
    ## [1] ""
    ## 
    ## $enrichment_map$passivetotal.org$tags
    ## list()
    ## 
    ## $enrichment_map$passivetotal.org$dynamic
    ## [1] FALSE
    ## 
    ## $enrichment_map$passivetotal.org$value
    ## [1] "passivetotal.org"
    ## 
    ## $enrichment_map$passivetotal.org$subdomains
    ## list()
    ## 
    ## $enrichment_map$passivetotal.org$tld
    ## [1] ".org"
    ## 
    ## $enrichment_map$passivetotal.org$primaryDomain
    ## [1] "passivetotal.org"
    ## 
    ## $enrichment_map$passivetotal.org$type
    ## [1] "domain"

### Test Results

``` r
library(passivetotal)
library(testthat)

date()
```

    ## [1] "Sun Jun 14 20:41:38 2015"

``` r
test_dir("tests/")
```

    ## basic functionality :
