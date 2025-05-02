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

# Consolidate back into rows; combine issue tags into a list of factors
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

# Assign issue tags to rows that don't have any. This is based on an analysis of the 38 tags devised
# from the code above; will need to change if the tags do.

## NOTES
#
# here are some terms I think may need to be added to the ENTIRE set, not just ones untagged:
#
# journalism
# government
# crime (mainly for republican-valence protests)
#
# There are also a few gray areas:
#
# Should "Juneteenth" get tagged with "racism?"

# Create a list of tag keywords for efficient lookup
tag_keywords <- list(
  'animal rights' = c('animal', 'animals', 'wildlife', 'pets', 'zoo', 'circus', 'hunting', 'vegan', 'vegetarian', 'cruelty', 'sanctuary', 'endangered'),
  'banking and finance' = c('bank', 'banking', 'finance', 'financial', 'loan', 'credit', 'debt', 'mortgage', 'interest rate', 'investment', 'stock market'),
  'civil rights' = c('civil rights', 'human rights', 'equality', 'equal rights', 'voting rights', 'civil liberties', 'protest rights', 'freedom of', 'human trafficking'),
  'corruption' = c('corruption', 'corrupt', 'bribery', 'bribe', 'scandal', 'ethics violation', 'conflict of interest', 'lobbying'),
  'covid' = c('covid', 'coronavirus', 'pandemic', 'vaccine', 'vaccination', 'quarantine', 'lockdown', 'mask'),
  'criminal justice' = c('criminal justice', 'justice system', 'prison', 'jail', 'incarceration', 'parole', 'sentencing', 'bail', 'probation', 'crime'),
  'democracy' = c('democracy', 'democratic', 'voting', 'election', 'ballot', 'poll', 'voter', 'electoral', 'gerrymandering'),
  'development' = c('development', 'infrastructure', 'building', 'construction', 'zoning', 'planning', 'property development'),
  'disability rights' = c('disability', 'disabilities', 'disabled', 'accessibility', 'ada', 'americans with disabilities', 'handicap'),
  'drugs' = c('drug', 'drugs', 'marijuana', 'cannabis', 'opioid', 'heroin', 'cocaine', 'overdose', 'addiction', 'narcotics'),
  'economy' = c('economy', 'economic', 'recession', 'inflation', 'unemployment', 'job', 'jobs', 'wage', 'wages', 'trade', 'deficit', 'price', 'cost'),
  'education' = c('education', 'school', 'university', 'college', 'student', 'teacher', 'professor', 'campus', 'curriculum', 'tuition', 'classroom', 'nea'),
  'energy' = c('energy', 'electricity', 'power plant', 'fossil fuel', 'coal', 'natural gas', 'fracking', 'renewable', 'solar', 'wind', 'nuclear', 'pipeline'),
  'environment' = c('environment', 'environmental', 'climate', 'global warming', 'pollution', 'emissions', 'conservation', 'ecosystem', 'biodiversity'),
  'foreign affairs' = c('foreign', 'international', 'diplomatic', 'diplomacy', 'embassy', 'sanctions', 'treaty', 'affairs', 'global'),
  'free speech' = c('free speech', 'freedom of speech', 'censorship', 'first amendment', 'expression', 'press freedom', 'media freedom'),
  'guns' = c('gun', 'guns', 'firearms', 'second amendment', 'nra', 'shooting', 'rifle', 'handgun', 'gun control'),
  'healthcare' = c('healthcare', 'health care', 'medical', 'medicine', 'hospital', 'doctor', 'nurse', 'patient', 'insurance', 'prescription', 'nih'),
  'housing' = c('housing', 'house', 'apartment', 'rent', 'rental', 'mortgage', 'eviction', 'homeless', 'homelessness', 'affordable housing'),
  'immigration' = c('immigration', 'immigrant', 'migrant', 'refugee', 'asylum', 'border', 'deportation', 'visa', 'citizenship', 'undocumented'),
  'indigenous peoples' = c('indigenous', 'native american', 'first nations', 'american indian', 'tribe', 'tribal', 'reservation', 'aboriginal', 'dakota', 'standing rock'),
  'judiciary' = c('judiciary', 'judge', 'court', 'supreme court', 'justice', 'judicial', 'lawsuit', 'legal', 'ruling', 'verdict', 'appeal'),
  'labor' = c('labor', 'worker', 'employee', 'employer', 'union', 'strike', 'minimum wage', 'wage', 'workplace', 'working conditions', 'benefits'),
  'legislative' = c('legislative', 'legislation', 'legislature', 'congress', 'senator', 'representative', 'bill', 'law', 'statute', 'regulation'),
  'lgbtqia' = c('lgbtq', 'lgbt', 'lgbtqia', 'gay', 'lesbian', 'bisexual', 'transgender', 'queer', 'homosexual', 'sexual orientation', 'gender identity'),
  'military' = c('military', 'armed forces', 'army', 'navy', 'air force', 'marines', 'defense', 'veteran', 'war', 'combat', 'soldier', 'troops'),
  'patriotism' = c('patriot', 'patriotic', 'patriotism', 'flag', 'anthem', 'pledge', 'national', 'country', 'america first', 'american values'),
  'policing' = c('police', 'policing', 'cop', 'officer', 'law enforcement', 'brutality', 'misconduct', 'racial profiling', 'body camera', 'defund'),
  'presidency' = c('president', 'presidency', 'white house', 'oval office', 'executive order', 'administration', 'trump', 'biden', 'obama', 'bush'),
  'racism' = c('racism', 'racist', 'racial', 'discrimination', 'prejudice', 'bigotry', 'white supremacy', 'segregation', 'black lives matter', 'blm'),
  'religion' = c('religion', 'religious', 'faith', 'church', 'mosque', 'synagogue', 'temple', 'christian', 'muslim', 'islam', 'jewish', 'prayer'),
  'reproductive rights' = c('reproductive', 'abortion', 'pro-choice', 'pro-life', 'planned parenthood', 'contraception', 'birth control', 'pregnancy'),
  'science' = c('science', 'scientific', 'research', 'data', 'evidence', 'technology', 'nasa', 'space', 'innovation', 'discovery', 'experiment', 'nih'),
  'sexual violence' = c('sexual assault', 'rape', 'sexual violence', 'sexual harassment', 'domestic violence', 'sex trafficking', 'metoo', 'consent'),
  'sports' = c('sport', 'sports', 'athlete', 'game', 'team', 'player', 'coach', 'league', 'football', 'basketball', 'baseball', 'soccer'),
  'taxes' = c('tax', 'taxes', 'taxation', 'revenue', 'irs', 'deduction', 'income tax', 'property tax', 'sales tax', 'tax cut', 'tax increase'),
  'transportation' = c('transportation', 'transit', 'traffic', 'highway', 'road', 'street', 'car', 'bus', 'train', 'bicycle', 'bicyclist', 'pedestrian'),
  'women\'s rights' = c('women', 'woman', 'gender equality', 'feminism', 'feminist', 'sexism', 'misogyny', 'harassment', 'equal pay')
)

# Specific multi-word phrases to handle, or common mappings to multiple tags
specific_phrases <- list(
  'martin luther king' = c('civil rights', 'racism'),
  'mlk' = c('civil rights', 'racism'),
  'human trafficking' = c('criminal justice', 'sexual violence'),
  'child trafficking' = c('criminal justice', 'sexual violence'),
  'dungeness crab' = c('labor', 'economy'),
  'dakota access pipeline' = c('energy', 'environment', 'indigenous peoples'),
  'racial incidents on campus' = c('education', 'racism'),
  'safer roadways' = c('transportation'),
  'community building' = c('transportation'),
  'milo yiannopoulos' = c('free speech', 'education'),
  'gaza' = c('foreign affairs'),
  'palestine' = c('foreign affairs'),
  'palestinian' = c('foreign affairs'),
  'israel' = c('foreign affairs'),
  'hamas' = c('foreign affairs'),
  'russia' = c('foreign affairs'),
  'ukraine' = c('foreign affairs'),
  'dream act' = c('immigration')
)

# Function to assign tags based on content
assign_tags <- function(text) {
  if (is.na(text) || text == "") return(NA_character_)
  
  text <- tolower(text)
  assigned_tags <- c()
  
  # Check for specific phrases first
  for (phrase in names(specific_phrases)) {
    if (grepl(phrase, text, fixed = TRUE)) {
      assigned_tags <- c(assigned_tags, specific_phrases[[phrase]])
    }
  }
  
  # Then check for keyword matches
  for (tag in names(tag_keywords)) {
    # Only check if we haven't already assigned this tag
    if (!(tag %in% assigned_tags)) {
      keywords <- tag_keywords[[tag]]
      for (keyword in keywords) {
        if (grepl(keyword, text, fixed = TRUE)) {
          assigned_tags <- c(assigned_tags, tag)
          break # Skip remaining keywords once we've found a match
        }
      }
    }
  }
  
  # Handle special edge cases from the examples
  if (grepl("university", text, fixed = TRUE) && grepl("racism", text, fixed = TRUE)) {
    assigned_tags <- c(assigned_tags, "education", "racism")
  }
  
  if (grepl("living conditions", text, fixed = TRUE) && grepl("company", text, fixed = TRUE)) {
    assigned_tags <- c(assigned_tags, "housing", "labor")
  }
  
  # Remove duplicates and join with semicolons
  assigned_tags <- unique(assigned_tags)
  if (length(assigned_tags[[1]]) > 0) {
    return(factor(assigned_tags))
  } else {
    return(NA_character_)
  }
}

# Create an ID column for merging
fullData_consolidated$id = seq.int(nrow(fullData_consolidated))

# Create a separate table for rows without any issue tags; we're not going to alter any other data.
toTag <- fullData_consolidated %>% filter(is.na(issue_tags))

# Assign tags to these rows
toTag <- toTag %>%
  mutate(issue_tags = sapply(claims_summary, assign_tags))

# Integrate back into the full dataset
fullData_taggedIssues <- rows_update(fullData_consolidated, toTag, by = "id") %>% select(-id)
fullData_taggedIssues <- sort_by(fullData_consolidated, ~ date + state + locality + location + participants + claims_summary)
