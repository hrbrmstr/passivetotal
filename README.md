passivetotal is an R package to interface with the [PassiveTotal API](https://www.passivetotal.org/api/docs)

The following functions are implemented:

-   `add_tag` : function (domain\_or\_ip, tag)
-   `get_classification` : function (domain\_or\_ip)
-   `get_metadata` : function (domain\_or\_ip)
-   `get_passive` : function (domain\_or\_ip)
-   `get_subdomains` : function (domain)
-   `get_tags` : function (domain\_or\_ip)
-   `get_unique` : function (domain\_or\_ip)
-   `is_dynamic_associated` : function (domain)
-   `is_on_watchlist` : function (domain\_or\_ip)
-   `is_sinkhole` : function (ip)
-   `passive_api_key` : function (force = FALSE)
-   `remove_tag` : function (domain\_or\_ip, tag)
-   `set_classification` : function (domain\_or\_ip, classification)
-   `set_compromised` : function (domain\_or\_ip, is\_compromised)
-   `set_dynamic_associated` : function (domain\_or\_ip, is\_dynamic)
-   `set_sinkhole` : function (domain\_or\_ip, is\_sinkhole)
-   `set_watching` : function (domain\_or\_ip, is\_watching)
-   `was_ever_compromised` : function (domain\_or\_ip)

### News

-   Version 0.1.0 released

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

    ## [1] '0.1.0'

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
    ## Source: local data frame [108 x 5]
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
    ## 1 www.passivetotal.org 23
    ## 2 www.passivetotal.com 16
    ## 3     passivetotal.com 31
    ## 4     passivetotal.org 38
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

    ## [1] "Wed Jun 10 22:50:35 2015"

``` r
test_dir("tests/")
```

    ## basic functionality :
