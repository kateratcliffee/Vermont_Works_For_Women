#install packages
install.packages(c("sf", "tigris", "tidycensus"))
# look for pop-up dialogue to agree to istallation

#load packages 
library (sf)
library (tigris)
library (tidycensus)

#query metadata for entire 2022 5-year ACS census data
census2022_metadata <- load_variables (2022, "acs5")
write.csv(x=census2022_metadata, 
          file = "census2022_metadata.csv")
#query and save geography data for tracts
vt_tracts2022 <- tracts(state = "VT", 
                        year = 2022, 
                        cb = TRUE)

st_write (obj = vt_tracts2022,
          dsn = "vt_pop.gpkg",
          layer = "tracts")

#load census key
census_api_key("7f9fe0f583b0c04f100196af6c16c58796014a1f", install = TRUE)
readRenviron("~/.Renviron")

# query and save sex demographics for tracts
## get total population and female population

vt_females_2022 <- get_acs (geography = "block group", 
                            variables = c("B01001_026", "B01001_001"), 
                            year = 2022, 
                            survey = "acs5",
                            state = "VT", 
                            output = "wide" )