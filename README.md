# CrowdCountingConsortium-data-import

Instructions and code for cleaning and rationalizing the three phases of [Crowd Counting Consortium][https://ash.harvard.edu/programs/crowd-counting-consortium/] data for use as a unified data set. This data is published as part of Harvard's [Ash Center for Democratic Justice and Innovation][https://ash.harvard.edu].

The data has already been cleaned and is published in three tranches:

- [2017-2020][https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/6OPP7H]
- [2021-2024][https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/9MMYDI]
- [2025-][https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/RI9JFU]

From the links above, you can download both data and associated coding guides.

## Issues addressed in this repository

- There are a few minor errors in the data.
- The fields are inconsistent:
    - Deleted fields
    - Added fields
    - Renamed fields
    - Split fields

## Contents

XX contains Grep commands to fix the errors.

YY contains R commands to import the data from each file, rationalize the tables, merge them into a single table, and export the results.
