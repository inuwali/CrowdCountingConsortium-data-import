phase3 <- vroom(
"ccc-phase3-public.tab",
escape_backslash=TRUE,
col_types = cols(
actors = col_character(),
arrests = col_character(),
arrests_any = col_logical(),
chemical_agents = col_logical(),
claims = col_character(),
claims_summary = col_character(),
claims_verbatim = col_character(),
coder = col_character(),
conf = col_logical(),
date = col_date(format = ""),
event_type = col_character(),
fips_code = col_character(),
injuries_crowd = col_character(),
injuries_crowd_any = col_logical(),
injuries_police = col_character(),
injuries_police_any = col_logical(),
issue_tags = col_character(),
issue_tags_summary = col_character(),
issue_tags_verbatim = col_character(),
issues = col_character(),
lat = col_double(),
locality = col_character(),
location = col_character(),
location_detail = col_character(),
lon = col_double(),
macroevent = col_character(),
notables = col_character(),
notes = col_character(),
online = col_logical(),
organizations = col_character(),
participant_casualties_any = col_logical(),
participant_deaths = col_character(),
participant_injuries = col_character(),
participant_measures = col_character(),
participants = col_character(),
police_casualties_any = col_logical(),
police_deaths = col_character(),
police_injuries = col_character(),
police_measures = col_character(),
property_damage = col_character(),
property_damage_any = col_logical(),
resolved_county = col_character(),
resolved_locality = col_character(),
resolved_state = col_character(),
size_cat = col_double(),
size_high = col_double(),
size_low = col_double(),
size_mean = col_double(),
size_text = col_character(),
source_1 = col_character(),
source_2 = col_character(),
source_3 = col_character(),
source_4 = col_character(),
source_5 = col_character(),
source_6 = col_character(),
source_7 = col_character(),
source_8 = col_character(),
source_9 = col_character(),
source_10 = col_character(),
source_11 = col_character(),
source_12 = col_character(),
source_13 = col_character(),
source_14 = col_character(),
source_15 = col_character(),
source_16 = col_character(),
source_17 = col_character(),
source_18 = col_character(),
source_19 = col_character(),
source_20 = col_character(),
source_21 = col_character(),
source_22 = col_character(),
source_23 = col_character(),
source_24 = col_character(),
source_25 = col_character(),
source_26 = col_character(),
source_27 = col_character(),
source_28 = col_character(),
source_29 = col_character(),
source_30 = col_character(),
source1 = col_character(),
source2 = col_character(),
source3 = col_character(),
source4 = col_character(),
source5 = col_character(),
source6 = col_character(),
source7 = col_character(),
source8 = col_character(),
source9 = col_character(),
source10 = col_character(),
source11 = col_character(),
source12 = col_character(),
source13 = col_character(),
source14 = col_character(),
source15 = col_character(),
source16 = col_character(),
source17 = col_character(),
source18 = col_character(),
source19 = col_character(),
source20 = col_character(),
source21 = col_character(),
source22 = col_character(),
source23 = col_character(),
source24 = col_character(),
source25 = col_character(),
source26 = col_character(),
source27 = col_character(),
source28 = col_character(),
source29 = col_character(),
source30 = col_character(),
state = col_character(),
targets = col_character(),
title = col_character(),
type = col_character(),
valence = col_double())
)