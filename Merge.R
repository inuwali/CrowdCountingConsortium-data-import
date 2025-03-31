# Renames fields in phase 1 data to match phase 3.
phase1_prepped <- phase1 %>%
    rename(
        participants = actors,
        claims_summary = claims,
        event_type = type,
        participant_injuries = injuries_crowd,
        participant_casualties_any = injuries_crowd_any,
        police_injuries = injuries_police,
        police_casualties_any = injuries_police_any,
        location = location_detail,
        source1  = source_1,
        source2  = source_2,
        source3  = source_3,
        source4  = source_4,
        source5  = source_5,
        source6  = source_6,
        source7  = source_7,
        source8  = source_8,
        source9  = source_9,
        source10 = source_10,
        source11 = source_11,
        source12 = source_12,
        source13 = source_13,
        source14 = source_14,
        source15 = source_15,
        source16 = source_16,
        source17 = source_17,
        source18 = source_18,
        source19 = source_19,
        source20 = source_20,
        source21 = source_21,
        source22 = source_22,
        source23 = source_23,
        source24 = source_24,
        source25 = source_25,
        source26 = source_26,
        source27 = source_27,
        source28 = source_28,
        source29 = source_29,
        source30 = source_30,
    )

# Merges the `issues` field of phase1 data into the `claims_summary` field.
phase1_prepped$claims_summary <- paste(phase1_prepped$claims_summary, phase1_prepped$issues, sep="; ")

# Deletes the `issues` field of phase 1 post-merge.
phase1_prepped <- phase1_prepped %>%
    select(
        -issues
    )

# Renames fields in phase 2 data to match phase 3 and deletes fields related to issue tags, since they're not present in either of the other two data sets.
phase2_prepped <- phase2 %>%
    rename(
        event_type = type,
        participant_injuries = injuries_crowd,
        participant_casualties_any = injuries_crowd_any,
        police_injuries = injuries_police,
        police_casualties_any = injuries_police_any,
        location = location_detail,
        source1  = source_1,
        source2  = source_2,
        source3  = source_3,
        source4  = source_4,
        source5  = source_5,
        source6  = source_6,
        source7  = source_7,
        source8  = source_8,
        source9  = source_9,
        source10 = source_10,
        source11 = source_11,
        source12 = source_12,
        source13 = source_13,
        source14 = source_14,
        source15 = source_15,
        source16 = source_16,
        source17 = source_17,
        source18 = source_18,
        source19 = source_19,
        source20 = source_20,
        source21 = source_21,
        source22 = source_22,
        source23 = source_23,
        source24 = source_24,
        source25 = source_25,
        source26 = source_26,
        source27 = source_27,
        source28 = source_28,
        source29 = source_29,
        source30 = source_30,
    ) %>%
    select(
        -issue_tags,
        -issue_tags_summary,
        -issue_tags_verbatim
    )

# For naming consistency.
phase3_prepped <- phase3

# Merge tables.
fullData <- bind_rows(phase1_prepped, phase2_prepped, phase3_prepped)

# Remove temp tables.
rm(phase1_prepped, phase2_prepped, phase3_prepped)

# Delete duplicate rows from the data set.
fullData <- unique(fullData)