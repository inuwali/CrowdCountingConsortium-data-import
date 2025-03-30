library(dplyr)
library(tidyr)

# Explode lists in the field into separate rows
fullData_events_exploded <- fullData %>%
separate_rows(event_type, sep = ";") %>%
separate_rows(event_type, sep = ",") %>%
mutate(event_type = trimws(event_type))

# Load transformations
event_type_transformations <- read.csv("event_type transformations.csv")

# Transform terms
transformEventTypes <- function(input, transforms) {
  temp <- input
  for (i in seq_len(nrow(transforms))) {
    old <- transforms[i, 1]
    new <- transforms[i, 2]
    temp$event_type <- gsub(paste("^",old,"$", sep = ""), new, temp$event_type)
  }
  return (temp)
}

fullData_events_exploded <- transformEventTypes(fullData_events_exploded, event_type_transformations)

# Explode again; some of the transformations create multiple values
fullData_events_exploded <- fullData_events_exploded %>%
separate_rows(event_type, sep = ";") %>%
mutate(event_type = trimws(event_type))

# Consolidate back into rows with semicolon-separated values
fullData_consolidated <- fullData_events_exploded %>%
  group_by(
    date,
    locality,
    state,
    location,
    online,
    macroevent,
    participants,
    claims_summary,
    valence,
    size_text,
    size_low,
    size_high,
    size_mean,
    size_cat,
    arrests,
    arrests_any,
    participant_injuries,
    participant_casualties_any,
    police_injuries,
    police_casualties_any,
    property_damage,
    property_damage_any,
    chemical_agents,
    source1,
    source2,
    source3,
    source4,
    source5,
    source6,
    source7,
    source8,
    source9,
    source10,
    source11,
    source12,
    source13,
    source14,
    source15,
    source16,
    source17,
    source18,
    source19,
    source20,
    source21,
    source22,
    source23,
    source24,
    source25,
    source26,
    source27,
    source28,
    source29,
    source30,
    notes,
    lat,
    lon,
    resolved_locality,
    resolved_county,
    resolved_state,
    fips_code,
    title,
    organizations,
    claims,
    claims_verbatim,
    participant_measures,
    police_measures,
    participant_deaths,
    police_deaths,
    notables,
    targets,
    conf,
    coder
  ) %>%
  summarise(event_type = paste(event_type, collapse = "; "), .groups = "drop")

# Move the event_type column to its original position
fullData_consolidated <- fullData_consolidated %>%
  relocate(event_type, .before = macroevent)

# Sort results for easier head-to-head comparison
fullData <- sort_by(fullData, ~ date + state + locality + location + participants + claims_summary)
fullData_consolidated <- sort_by(fullData_consolidated, ~ date + state + locality + location + participants + claims_summary)