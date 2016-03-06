
`passivetotal` is an R package to interface with the [PassiveTotal API](https://api.passivetotal.org/api/docs/)

This has BREAKNG CHANGES since it now only works with version 2 of the API.

You should set `PASSIVETOTAL_USER` & `PASSIVETOTAL_API_KEY` in `.Renviron` or you'll either be prompted for them or will need to pass them to each function manually.

NOTE that all the API functions are wrapped with `memoise::meomoise`, meaning that they cache results. Use the `forget` function to clear the cache for any given function.

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

``` r
library(passivetotal)
library(dplyr)
library(jsonlite)

is_fqdn("rud.is") 
```

    ## [1] TRUE

``` r
is_ipv4("10.10.10.10")
```

    ## [1] TRUE

``` r
toJSON(passive_classification("passivetotal.org"), pretty=TRUE)
```

    ## {
    ##   "everCompromised": [false]
    ## }

``` r
tbl_df(passive_dns("passivetotal.org")$results)
```

    ## Source: local data frame [456 x 7]
    ## 
    ##                                                          recordHash
    ##                                                               (chr)
    ## 1  cc59ff4a1374e277d24662b9f2fc8aa8a268e3c230bb6d36d6d448ef5e0f549b
    ## 2  50109643fa60fdc9b053d1b7c1ea851290a2ef4710105db04dd01c19d0b05389
    ## 3  9534bffb8e7a263578ec272353859480992fc7c13a78e603a4300429818f95fb
    ## 4  7e5c54ad3f17ba299dcff8cff3914d5cda4cda8968da160b01b576b1b10ac44b
    ## 5  a82390ea6eab6b5e58cb89be7842b854f19fab35401d03c5b55f0724d5f24cf8
    ## 6  14bdf749913f4ab17b93427e51ea3d7409415ef72cbf3c99aeea2e99b59f62b8
    ## 7  d30c45b5027f517d40e5f8bd9fd9094b0d639e30cde7401055880023eeb6af3f
    ## 8  4c3ace779880dd77e3a8f480f8b06f9369a406daef53073b948446b42717cf4a
    ## 9  b232f352d8553159326b7947670d7f9c767a44c497b051afee403c76fa24a99c
    ## 10 fe444a87911865bc24bded3baa1e2db7fac92ab928ae5d4f15383edae2f5ac41
    ## ..                                                              ...
    ## Variables not shown: resolve (chr), value (chr), source (chr), lastSeen
    ##   (chr), collected (chr), firstSeen (chr)

``` r
toJSON(passive_subdomains("*.passivetotal.org"), pretty=TRUE)
```

    ## {
    ##   "queryValue": ["*.passivetotal.org"],
    ##   "subdomains": ["www", "nutmeg-beta", "app", "blog", "api", "certs", "n1", "n5", "n6"]
    ## }

``` r
toJSON(passive_unique("passivetotal.org"), pretty=TRUE)
```

    ## {
    ##   "frequency": [
    ##     ["54.153.123.93", "156"],
    ##     ["52.8.228.23", "155"],
    ##     ["45.55.48.88", "5"],
    ##     ["45.55.77.126", "2"],
    ##     ["107.170.89.121", "2"],
    ##     ["104.131.121.205", "2"],
    ##     ["162.243.102.221", "1"]
    ##   ],
    ##   "queryValue": ["passivetotal.org"],
    ##   "total": [7],
    ##   "pager": {},
    ##   "results": ["45.55.77.126", "52.8.228.23", "45.55.48.88", "54.153.123.93", "162.243.102.221", "107.170.89.121", "104.131.121.205"],
    ##   "queryType": ["domain"]
    ## }

``` r
passive_host("passivetotal.org") 
```

    ## Source: local data frame [33 x 5]
    ## 
    ##              category         hostname            lastSeen
    ##                 (chr)            (chr)               (chr)
    ## 1         Ad Exchange passivetotal.org 2016-01-08 05:52:30
    ## 2   Analytics Service passivetotal.org 2016-01-08 05:52:30
    ## 3  JavaScript Library passivetotal.org 2016-01-08 05:52:30
    ## 4    Operating System passivetotal.org 2016-01-08 05:52:42
    ## 5              Search passivetotal.org 2016-01-08 05:52:30
    ## 6              Server passivetotal.org 2016-01-08 05:52:42
    ## 7      Tracking Pixel passivetotal.org 2016-01-04 23:06:11
    ## 8      Tracking Pixel passivetotal.org 2015-12-26 19:18:09
    ## 9      Tracking Pixel passivetotal.org 2016-01-04 23:06:11
    ## 10     Tracking Pixel passivetotal.org 2016-01-08 05:52:30
    ## ..                ...              ...                 ...
    ## Variables not shown: firstSeen (chr), label (chr)

``` r
passive_malware("xxxmobiletubez.com")
```

    ## Source: local data frame [290 x 4]
    ## 
    ##                                                              sample
    ##                                                               (chr)
    ## 1  166da69f873dddb7b334c737dd23ca42554e719fdb15085e6d7b4f1dd2dd279c
    ## 2  88496660bfcc92a5a4346864fc69533363e75eba1503c8df5ebb89053852e0a9
    ## 3  96ba86e86b5a8cce51defc945800ee98ae7e05af9fb22f8b8c90df6682d44acd
    ## 4  7b7eeca21a4aee3768b41b9e194052cbb01835ae3b3503c1d635abbe1193aa5c
    ## 5  bc9e17fe10115222378c93683605648126b7708d9d3fed26e43c61a3b242bef3
    ## 6  b27ba062acf9e3277dc828e8d103bf2b15a6811460286919a913389a15fbe403
    ## 7  f5bc281ee071f6fb0eb8d25f414770fee67e2ea6e02afe53896a2313f6cfe373
    ## 8  0570baef1c1bad499e9c43be657e2cc67eb1bfc8de1f90f2334ab5550142834c
    ## 9  4669c023c88682df7b63ef4772bb0ec0fd611d5a162c7e3af7aa4edd9a90a76a
    ## 10 f77bd764c881e4cabf7833ef70559fda9b14a6079db263f26e5a1229aa8d4407
    ## ..                                                              ...
    ## Variables not shown: source (chr), sourceUrl (chr), collectionDate (chr)

``` r
passive_osint("xxxmobiletubez.com") 
```

    ## $results
    ##   source
    ## 1 RiskIQ
    ##                                                                    sourceUrl
    ## 1 https://www.riskiq.com/blog/riskiq-labs/post/a-brief-encounter-with-slempo
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           inReport
    ## 1 man5hats.ru, rghost.ru, xxxvideotube.org, adobe-flash-player-11.com, jackdojacksgot.ru, alexhost.md, xxxmobiletubez.com, brutaltube4mobile.com, gexmails.com, adobeupdate.org, brutalmobiletubes.com, updateflashplayeer.com, australiamms.com, 176.123.28.128, 179.60.147.21, 181.174.164.25, 185.86.148.188, 195.3.144.90, 216.58.192.14, 216.58.192.46, 37.1.196.207, 37.1.205.155, 37.1.205.200, 46.101.28.84, 5.196.121.148, 74.125.224.2, 74.125.239.102, 74.125.239.104, 74.125.239.110, 74.125.239.128, 74.125.239.132, 74.125.239.134, 74.125.239.136, 74.125.239.32, 74.125.239.36, 74.125.239.37, 74.125.239.38, 74.125.239.39, 74.125.239.40, 74.125.239.41, 74.125.239.46, 74.125.239.98, 94.102.53.184, 95.211.198.23, 185.40.4.99
    ##                                 tags
    ## 1 slempo, crimeware, android, mobile

``` r
toJSON(passive_enrich("passivetotal.org"), pretty=TRUE)
```

    ## {
    ##   "tags": [],
    ##   "subdomains": [],
    ##   "queryValue": ["passivetotal.org"],
    ##   "tld": [".org"],
    ##   "everCompromised": [false],
    ##   "dynamicDns": [false],
    ##   "primaryDomain": ["passivetotal.org"],
    ##   "queryType": ["domain"]
    ## }

``` r
toJSON(passive_ssl_certificate("e9a6647d6aba52dc47b3838c920c9ee59bad7034"), pretty=TRUE)
```

    ## {
    ##   "serialNumber": ["2317683628587350290823564500811277499"],
    ##   "issuerStreetAddress": {},
    ##   "subjectOrganizationUnitName": {},
    ##   "subjectOrganizationName": {},
    ##   "subjectSerialNumber": {},
    ##   "subjectEmailAddress": {},
    ##   "expirationDate": ["Apr 27 23:59:59 2017 GMT"],
    ##   "fingerprint": ["e9:a6:64:7d:6a:ba:52:dc:47:b3:83:8c:92:0c:9e:e5:9b:ad:70:34"],
    ##   "issuerSerialNumber": {},
    ##   "issuerLocalityName": {},
    ##   "issuerGivenName": {},
    ##   "issuerOrganizationName": ["thawte, inc."],
    ##   "issuerCountry": ["us"],
    ##   "subjectCommonName": ["www.passivetotal.org"],
    ##   "sha1": ["e9a6647d6aba52dc47b3838c920c9ee59bad7034"],
    ##   "sslVersion": ["2"],
    ##   "subjectSurname": {},
    ##   "subjectStateOrProvinceName": {},
    ##   "subjectCountry": {},
    ##   "issuerSurname": {},
    ##   "subjectGivenName": {},
    ##   "issuerProvince": {},
    ##   "issuerOrganizationUnitName": ["domain validated ssl"],
    ##   "subjectProvince": {},
    ##   "subjectLocalityName": {},
    ##   "subjectStreetAddress": {},
    ##   "issuerStateOrProvinceName": {},
    ##   "issuerCommonName": ["thawte dv ssl ca - g2"],
    ##   "issueDate": ["Apr 28 00:00:00 2015 GMT"],
    ##   "issuerEmailAddress": {}
    ## }

``` r
toJSON(passive_ssl_history("52.8.228.23"), pretty=TRUE)
```

    ## [
    ##   {
    ##     "sha1": "528ee71c4ad748ece5368f68299048bffdb31c86",
    ##     "firstSeen": "2016-01-25",
    ##     "ipAddresses": ["52.8.228.23"],
    ##     "lastSeen": "2016-02-29"
    ##   },
    ##   {
    ##     "sha1": "e9a6647d6aba52dc47b3838c920c9ee59bad7034",
    ##     "firstSeen": "2015-12-21",
    ##     "ipAddresses": ["52.8.228.23"],
    ##     "lastSeen": "2016-01-18"
    ##   },
    ##   {
    ##     "sha1": "3d7dbaf257520e7d06c092948b7a7ba99199dcdf",
    ##     "firstSeen": "2015-11-09",
    ##     "ipAddresses": ["52.8.228.23"],
    ##     "lastSeen": "2015-11-09"
    ##   },
    ##   {
    ##     "sha1": "96e64014dd4d542b33da8698094fce09098f7c97",
    ##     "firstSeen": "2015-08-31",
    ##     "ipAddresses": ["52.8.228.23"],
    ##     "lastSeen": "2015-10-12"
    ##   }
    ## ]

``` r
toJSON(passive_ssl_search(query="www.passivetotal.org", field="subjectCommonName"), pretty=TRUE)
```

    ## {
    ##   "results": [
    ##     {
    ##       "expirationDate": "Apr 28 23:59:59 2015 GMT",
    ##       "issuerOrganizationName": "thawte, inc.",
    ##       "subjectCommonName": "www.passivetotal.org",
    ##       "issuerCommonName": "thawte dv ssl ca",
    ##       "issueDate": "Apr 28 00:00:00 2014 GMT",
    ##       "subjectOrganizationUnitName": "go to https://www.thawte.com/repository/index.html",
    ##       "fingerprint": "29:21:7e:f0:a2:48:c4:17:f9:95:ec:d5:25:b8:31:07:9a:8b:1b:8e",
    ##       "issuerCountry": "us",
    ##       "sha1": "29217ef0a248c417f995ecd525b831079a8b1b8e",
    ##       "sslVersion": "2",
    ##       "serialNumber": "19322308692400755425805651738750646013",
    ##       "issuerOrganizationUnitName": "domain validated ssl"
    ##     },
    ##     {
    ##       "expirationDate": "Apr 27 23:59:59 2017 GMT",
    ##       "issuerOrganizationName": "thawte, inc.",
    ##       "subjectCommonName": "www.passivetotal.org",
    ##       "issuerCommonName": "thawte dv ssl ca - g2",
    ##       "issueDate": "Apr 28 00:00:00 2015 GMT",
    ##       "fingerprint": "e9:a6:64:7d:6a:ba:52:dc:47:b3:83:8c:92:0c:9e:e5:9b:ad:70:34",
    ##       "issuerCountry": "us",
    ##       "sha1": "e9a6647d6aba52dc47b3838c920c9ee59bad7034",
    ##       "sslVersion": "2",
    ##       "serialNumber": "2317683628587350290823564500811277499",
    ##       "issuerOrganizationUnitName": "domain validated ssl"
    ##     }
    ##   ]
    ## }

``` r
passive_status("passivetotal.org", "compromised")
```

    ## [1] FALSE

``` r
passive_status("passivetotal.org", "dynamic")
```

    ## [1] FALSE

``` r
passive_status("passivetotal.org", "monitor")
```

    ## [1] FALSE

``` r
passive_status("52.8.228.23", "sinkhole")
```

    ## [1] FALSE

``` r
passive_status("52.8.228.23", "s") 
```

    ## [1] FALSE

``` r
passive_tracker_search(query="UA-61048133", type="GoogleAnalyticsAccountNumber") 
```

    ## Source: local data frame [3 x 3]
    ## 
    ##   everBlacklisted alexaRank              hostname
    ##             (lgl)     (int)                 (chr)
    ## 1           FALSE        -1 blog.passivetotal.org
    ## 2           FALSE        -1  www.passivetotal.org
    ## 3           FALSE        -1      passivetotal.org

``` r
passive_tracker("passivetotal.org")
```

    ## Source: local data frame [6 x 5]
    ## 
    ##              lastSeen              hostname                attributeType
    ##                 (chr)                 (chr)                        (chr)
    ## 1 2016-01-26 21:47:45      passivetotal.org GoogleAnalyticsAccountNumber
    ## 2 2016-01-26 21:47:45      passivetotal.org    GoogleAnalyticsTrackingId
    ## 3 2016-01-18 04:31:29  www.passivetotal.org GoogleAnalyticsAccountNumber
    ## 4 2016-01-18 04:31:29  www.passivetotal.org    GoogleAnalyticsTrackingId
    ## 5 2016-01-26 21:48:03 blog.passivetotal.org GoogleAnalyticsAccountNumber
    ## 6 2016-01-26 21:48:03 blog.passivetotal.org    GoogleAnalyticsTrackingId
    ## Variables not shown: firstSeen (chr), attributeValue (chr)

``` r
toJSON(passive_whois("passivetotal.org"), pretty=TRUE)
```

    ## {
    ##   "compact": {
    ##     "city": {
    ##       "raw": ["Chesterbrook"],
    ##       "values": [
    ##         [
    ##           ["Chesterbrook"],
    ##           ["registrant", "admin", "tech"]
    ##         ]
    ##       ]
    ##     },
    ##     "fax": {
    ##       "raw": [],
    ##       "values": []
    ##     },
    ##     "name": {
    ##       "raw": ["Oneandone Private Registration"],
    ##       "values": [
    ##         [
    ##           ["Oneandone Private Registration"],
    ##           ["registrant", "admin", "tech"]
    ##         ]
    ##       ]
    ##     },
    ##     "country": {
    ##       "raw": ["UNITED STATES"],
    ##       "values": [
    ##         [
    ##           ["UNITED STATES"],
    ##           ["registrant", "admin", "tech"]
    ##         ]
    ##       ]
    ##     },
    ##     "telephone": {
    ##       "raw": ["18772064254"],
    ##       "values": [
    ##         [
    ##           ["18772064254"],
    ##           ["registrant", "admin", "tech"]
    ##         ]
    ##       ]
    ##     },
    ##     "state": {
    ##       "raw": ["PA"],
    ##       "values": [
    ##         [
    ##           ["PA"],
    ##           ["registrant", "admin", "tech"]
    ##         ]
    ##       ]
    ##     },
    ##     "street": {
    ##       "raw": ["701 Lee Road Suite 300|ATTN  passivetotal.org"],
    ##       "values": [
    ##         [
    ##           ["701 Lee Road Suite 300|ATTN  passivetotal.org"],
    ##           ["registrant", "admin", "tech"]
    ##         ]
    ##       ]
    ##     },
    ##     "postalCode": {
    ##       "raw": ["19087"],
    ##       "values": [
    ##         [
    ##           ["19087"],
    ##           ["registrant", "admin", "tech"]
    ##         ]
    ##       ]
    ##     },
    ##     "organization": {
    ##       "raw": ["1&1 Internet Inc. - www.1and1.com"],
    ##       "values": [
    ##         [
    ##           ["1&1 Internet Inc. - www.1and1.com"],
    ##           ["registrant", "admin", "tech"]
    ##         ]
    ##       ]
    ##     },
    ##     "email": {
    ##       "raw": ["proxy4655031@1and1-private-registration.com"],
    ##       "values": [
    ##         [
    ##           ["proxy4655031@1and1-private-registration.com"],
    ##           ["registrant", "admin", "tech"]
    ##         ]
    ##       ]
    ##     }
    ##   },
    ##   "registryUpdatedAt": ["2015-04-14"],
    ##   "domain": ["passivetotal.org"],
    ##   "billing": {},
    ##   "zone": {},
    ##   "nameServers": ["NS1.DIGITALOCEAN.COM", "NS2.DIGITALOCEAN.COM", "NS3.DIGITALOCEAN.COM"],
    ##   "registered": ["2014-04-14"],
    ##   "lastLoadedAt": ["2015-12-08"],
    ##   "whoisServer": ["whois.publicinterestregistry.net"],
    ##   "contactEmail": ["proxy4655031@1and1-private-registration.com"],
    ##   "admin": {
    ##     "city": ["Chesterbrook"],
    ##     "name": ["Oneandone Private Registration"],
    ##     "country": ["UNITED STATES"],
    ##     "telephone": ["18772064254"],
    ##     "state": ["PA"],
    ##     "street": ["701 Lee Road Suite 300|ATTN  passivetotal.org"],
    ##     "postalCode": ["19087"],
    ##     "organization": ["1&1 Internet Inc. - www.1and1.com"],
    ##     "email": ["proxy4655031@1and1-private-registration.com"]
    ##   },
    ##   "expiresAt": ["2016-04-14"],
    ##   "registrar": ["1 & 1 Internet AG (R73-LROR)"],
    ##   "tech": {
    ##     "city": ["Chesterbrook"],
    ##     "name": ["Oneandone Private Registration"],
    ##     "country": ["UNITED STATES"],
    ##     "telephone": ["18772064254"],
    ##     "state": ["PA"],
    ##     "street": ["701 Lee Road Suite 300|ATTN  passivetotal.org"],
    ##     "postalCode": ["19087"],
    ##     "organization": ["1&1 Internet Inc. - www.1and1.com"],
    ##     "email": ["proxy4655031@1and1-private-registration.com"]
    ##   },
    ##   "registrant": {
    ##     "city": ["Chesterbrook"],
    ##     "name": ["Oneandone Private Registration"],
    ##     "country": ["UNITED STATES"],
    ##     "telephone": ["18772064254"],
    ##     "state": ["PA"],
    ##     "street": ["701 Lee Road Suite 300|ATTN  passivetotal.org"],
    ##     "postalCode": ["19087"],
    ##     "organization": ["1&1 Internet Inc. - www.1and1.com"],
    ##     "email": ["proxy4655031@1and1-private-registration.com"]
    ##   }
    ## }

``` r
passive_whois_search(query="domains@riskiq.com", field="email") 
```

    ## Source: local data frame [8 x 37]
    ## 
    ##                    contactEmail             domain nameServers registered
    ##                           (chr)              (chr)       (chr)      (chr)
    ## 1            domains@riskiq.com        risk-iq.org    <chr[2]> 2009-05-21
    ## 2            domains@riskiq.com        risk-iq.net    <chr[2]> 2009-05-20
    ## 3            domains@riskiq.com        risk-iq.com    <chr[2]> 2009-05-20
    ## 4            domains@riskiq.com domains@riskiq.com    <chr[2]> 2006-01-11
    ## 5            domains@riskiq.com         riskiq.com    <chr[2]> 2006-01-11
    ## 6            domains@riskiq.com         markiq.com    <chr[2]> 2009-05-19
    ## 7            domains@riskiq.com         markiq.net    <chr[2]> 2009-05-19
    ## 8 RISKIQ.ORG@domainsbyproxy.com         riskiq.org    <chr[2]> 2007-06-08
    ## Variables not shown: lastLoadedAt (chr), whoisServer (chr),
    ##   registryUpdatedAt (chr), expiresAt (chr), registrar (chr), admin.city
    ##   (chr), admin.name (chr), admin.country (chr), admin.telephone (chr),
    ##   admin.state (chr), admin.street (chr), admin.postalCode (chr),
    ##   admin.organization (chr), admin.email (chr), tech.city (chr), tech.name
    ##   (chr), tech.country (chr), tech.telephone (chr), tech.state (chr),
    ##   tech.street (chr), tech.postalCode (chr), tech.organization (chr),
    ##   tech.email (chr), registrant.city (chr), registrant.name (chr),
    ##   registrant.country (chr), registrant.telephone (chr), registrant.state
    ##   (chr), registrant.street (chr), registrant.postalCode (chr),
    ##   registrant.organization (chr), registrant.email (chr), registrant.fax
    ##   (chr)

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
