S_GET <- safely(httr::GET)
S_POST <- safely(httr::POST)

valid_ssl_fields <- c("issuerSurname", "subjectOrganizationName", "issuerCountry",
                      "issuerOrganizationUnitName", "fingerprint",
                      "subjectOrganizationUnitName", "serialNumber",
                      "subjectEmailAddress", "subjectCountry", "issuerGivenName",
                      "subjectCommonName", "issuerCommonName",
                      "issuerStateOrProvinceName", "issuerProvince",
                      "subjectStateOrProvinceName", "sha1", "sslVersion",
                      "subjectStreetAddress", "subjectSerialNumber",
                      "issuerOrganizationName", "subjectSurname",
                      "subjectLocalityName", "issuerStreetAddress",
                      "issuerLocalityName", "subjectGivenName",
                      "subjectProvince", "issuerSerialNumber",
                      "issuerEmailAddress")

valid_trackers <- c("YandexMetricaCounterId", "ClickyId",
                    "GoogleAnalyticsAccountNumber", "NewRelicId",
                    "MixpanelId", "GoogleAnalyticsTrackingId")

valid_classifications <- c("classification", "compromised", "dynamic",
                           "monitor", "sinkhole", "cl", "co", "d", "m", "s")

valid_whois <- c("domain", "email", "name", "organization", "address",
                 "phone", "nameserver")

class_map <- list("classification"="classification",
                  "cl"="classification",
                  "compromised"="ever-compromised",
                  "co"="ever-compromised",
                  "dynamic"="dynamic-dns",
                  "d"="dynamic-dns",
                  "monitor"="monitor",
                  "m"="monitor",
                  "sinkhole"="sinkhole",
                  "s"="sinkhole")

