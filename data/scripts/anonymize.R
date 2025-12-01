# Script to anonymize Qualtrics data

# Load libraries
library(here)
library(dplyr)
library(tidyverse)

# Load identifiable Qualtrics data
raw_identifiable_pilot_a <-
  here(
    "data", "raw", "identifiable",
    "Psych 251 Replication_November 21, 2025_13.52.csv"
  ) %>%
  read_csv()

raw_identifiable_pilot_b <-
  here(
    "data", "raw", "identifiable",
    "Psych 251 Replication_November 25, 2025_14.47.csv"
  ) %>%
  read_csv()

# Remove identifiable information
raw_pilot_a <- raw_identifiable_pilot_a %>%
  # Get rid of Qualtrics junk
  slice(-1,-2) %>%
  select(
    -any_of(
      c("RecipientLastName", "RecipientFirstName", "RecipientEmail",
        "ExternalDataReference", "ExternalReference", "IPAddress",
        "LocationLatitude", "LocationLongitude", "ResponseId", "PROLIFIC_PID",
        "STUDY_ID", "SESSION_ID")
    )
  ) %>%
  rownames_to_column("sub_id")

raw_pilot_b <- raw_identifiable_pilot_b %>%
  # Get rid of Qualtrics junk
  slice(-1,-2) %>%
  select(
    -any_of(
      c("RecipientLastName", "RecipientFirstName", "RecipientEmail",
        "ExternalDataReference", "ExternalReference", "IPAddress",
        "LocationLatitude", "LocationLongitude", "ResponseId", "PROLIFIC_PID",
        "STUDY_ID", "SESSION_ID")
    )
  ) %>%
  rownames_to_column("sub_id")

# Save anonymized data
raw_pilot_a %>% write_csv(
  here(
    "data", "raw", "anonymous",
    "raw_anon_pilot_a_anon.csv"
  )
)

raw_pilot_b %>% write_csv(
  here(
    "data", "raw", "anonymous",
    "raw_anon_pilot_b_anon.csv"
  )
)
