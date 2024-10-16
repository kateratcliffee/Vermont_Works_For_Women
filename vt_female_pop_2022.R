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

#add new column to table with percent female
vt_females_2022$ratio_f <- vt_females_2022$B01001_026E/vt_females_2022$B01001_001E
vt_females_2022$per_f <- vt_females_2022$ratio_f*100

#new column with just county name 
library(stringr)
vt_females_2022$County <- str_extract(vt_females_2022$NAME, "\\b\\w+ County\\b")

#group median percent female by County
library(dplyr)

females_county_summ <- vt_females_2022 %>%
  group_by(County) %>%
  summarise(Med_Per_Female = median(per_f, na.rm = TRUE))

#make bar chart 
library(ggplot2)
ggplot(females_county_summ, aes(x = County, y = Med_Per_Female)) +
  geom_bar(stat = "identity", fill = "skyblue") +  # 'identity' since y-values are pre-summarized
  labs(
    title = "Females as Percent of Total Population, 2022",
    x = "County",
    y = "Median Percent Female"
  ) +
  theme_minimal() +  # Cleaner theme for the plot
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for readability
