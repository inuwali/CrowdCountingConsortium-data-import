# CrowdCountingConsortium-data-import

Instructions and code for cleaning and rationalizing the three phases of [Crowd Counting Consortium][https://ash.harvard.edu/programs/crowd-counting-consortium/] data for use as a unified data set. This data is published as part of Harvard's [Ash Center for Democratic Justice and Innovation][https://ash.harvard.edu].

If you can download the RData files directly from the links below, you may not need the entire contents of this repository; at the time of this writing, the RData download link wasn't working, returning this error:

```
{"status":"ERROR","code":404,"message":"datafile access error: requested optional service (image scaling, format conversion, etc.) could not be performed on this datafile."}
```

The data has already been largely cleaned and is published in three tranches:

- [2017-2020][https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/6OPP7H]
- [2021-2024][https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/9MMYDI]
- [2025-][https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/RI9JFU]

From these links, you can access both data and associated coding guides.

## Issues addressed in this repository

- There are a few minor errors in the data.
- The fields are inconsistent:
    - Deleted fields
    - Added fields
    - Renamed fields
    - Split fields
- The `event_type` field contains variants of equivalent values.

## Contents

### Documentation

`All fields summary.txt` contains comma-separated lists of all fields in each data set.

`Guide to fields by phase.csv` summarizes all fields across the three phases and documents the changes (additions, deletions, etc.)

### Processing

Files are listed in order of use; the end result is a table named `fullData_consolidated` containing rationalized, clean, deduped data with consolidated "event_type"s.

`Cleanup.txt` contains Grep commands to fix errors in each table prior to import.

`Setup.R` contains commands to set up the environment.

`Import phase <n>.R` contain commands to import the data from each file.

`Merge.R` contains commands to rationalize the tables and merge them into a single table.

`Consolidate event types.R` contains coalesce equivalent values in the `event_type` column. For example, "bicycle rally", "bike ride", and "bicycle ride" all become "bike rally".

## References

- The [CCC issue dictionary][https://docs.google.com/document/d/1PHHfppFWOFeRs_fjpP64OBWqwQJB6AydIK9t8AZYR7w/edit?tab=t.0#heading=h.qtkpnhquytv6] lists tags that are searched via regex.