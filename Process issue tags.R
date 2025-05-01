# Explode lists in the field into separate rows
fullData_tags_exploded <- fullData_consolidated %>%
  separate_rows(issue_tags, sep = ";") %>%
  mutate(issue_tags = trimws(issue_tags))

# Convert issue tags to factors
fullData_tags_exploded <- fullData_tags_exploded %>%
  mutate(issue_tags = as.factor(issue_tags))

# Discover the factors present in the data
allIssueFactors <- fullData_tags_exploded %>%
  pull(issue_tags) %>%
  unique()

# Consolidate back into rows; combine event types into a list of factors
fullData_consolidated <- fullData_tags_exploded %>%
  group_by(
    date,
    locality,
    state,
    location,
    event_type,
    macroevent,
    participants,
    claims_summary,
    valence,
    size_text,
    size_low,
    size_high,
    size_mean,
    size_cat,
    online,
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
  summarize(issue_tags = list(factor(issue_tags, levels = allIssueFactors)), .groups = "drop")

# Move the event_type column to its original position
fullData_consolidated <- fullData_consolidated %>%
  relocate(issue_tags, .before = macroevent)
