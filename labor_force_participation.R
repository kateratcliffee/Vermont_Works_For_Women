#labor force participation by gender and age 
#getting started
library(ggplot2)
library(tidyverse)
library(tidycensus)
library(stringr)

#focusing on table Table B23001: Sex by Age by Employment Status for Population 16yrs+

#MALE
#Variables we need: 
  #B23001_002 --> total male 16+
  #B23001_003--> est. male in labor force 16-19
  #B23001_010 --> total male 20-21
  #B23001_011 --> male 20-21 employed 
  #B23001_017 --> total male 22-24
  #B23001_018 --> est. employed male 22-24
  #B23001_024 --> total male 25-29
  #B23001_025 --> employed male 25-29
  #B23001_031 --> total male 30-34
  #B23001_032 --> employed male 30-34
  #B23001_038 --> total male 35-44
  #B23001_039 -->employed m 35-44
  #B23001_045 --> total male 45-54
  #B23001_046 --> est. male employed 45-54
  #B23001_052 --> total male 55-59
  #B23001_053 --> est. employed male 55-59
  #B23001_059 --> total male 60-61
  #B23001_060 --> est. employed 60-61
  #B23001_066 --> total male 62-64
  #B23001_067 --> est. employed male 62-64
  #B23001_073 --> total male 65-69
  #B23001_074 --> est. employed male 65-69
  #B23001_078 --> total male 70-74
  #B23001_079 --> est. employed male 70-74
  #B23001_083 --> total m 75 and over
  #B23001_084 --> est. employed male 75 and over


#read in .csv file from censusreporter
#library(readr)
#acs2022_5yr_B23001_14000US50007002303 <- read_csv("~/Desktop/acs2022_5yr_B23001_14000US50007002303/acs2022_5yr_B23001_14000US50007002303.csv")
#View(acs2022_5yr_B23001_14000US50007002303)

#rename
#labor_force_data <- acs2022_5yr_B23001_14000US50007002303 
#rm(acs2022_5yr_B23001_14000US50007002303)

labor_force_part <- get_acs (geography = "state", 
                            variables = c("B23001_001", "B23001_002","B23001_003", "B23001_010", 
                                          "B23001_011","B23001_017", "B23001_018", "B23001_024", 
                                          "B23001_025", "B23001_031", "B23001_032", "B23001_038",
                                          "B23001_039", "B23001_045", "B23001_046", "B23001_052", 
                                          "B23001_053", "B23001_059", "B23001_060", "B23001_066", 
                                          "B23001_067", "B23001_073", 
                                          "B23001_074", "B23001_078", "B23001_079", "B23001_083", 
                                          "B23001_084"),
                            year = 2022, 
                            survey = "acs5",
                            state = "VT", 
                            output = "wide" )

#add new columns with ratio and percent of males in labor force by age group
labor_force_part$per_m_1619 <- (labor_force_part$B23001_003E/labor_force_part$B23001_002E) * 100
labor_force_part$per_m_2021 <- (labor_force_part$B23001_011E/labor_force_part$B23001_010E) * 100
labor_force_part$per_m_2224 <- (labor_force_part$B23001_018E/labor_force_part$B23001_017E) * 100
labor_force_part$per_m_2529 <- (labor_force_part$B23001_025E/labor_force_part$B23001_024E) * 100
labor_force_part$per_m_3034 <- (labor_force_part$B23001_032E/labor_force_part$B23001_031E) * 100
labor_force_part$per_m_3544 <- (labor_force_part$B23001_039E/labor_force_part$B23001_038E) * 100
labor_force_part$per_m_4554 <- (labor_force_part$B23001_046E/labor_force_part$B23001_045E) * 100
labor_force_part$per_m_5559 <- (labor_force_part$B23001_053E/labor_force_part$B23001_052E) * 100
labor_force_part$per_m_6061 <- (labor_force_part$B23001_060E/labor_force_part$B23001_059E) * 100
labor_force_part$per_m_6264 <- (labor_force_part$B23001_067E/labor_force_part$B23001_066E) * 100
labor_force_part$per_m_6569 <- (labor_force_part$B23001_074E/labor_force_part$B23001_073E) * 100
labor_force_part$per_m_7074 <- (labor_force_part$B23001_079E/labor_force_part$B23001_078E) * 100
labor_force_part$per_m_75up <- (labor_force_part$B23001_084E/labor_force_part$B23001_083E) * 100

#repeat for FEMALES
#Variables needed (not updated for females)
  #B23001_002 --> total male 16+
  #B23001_003--> est. male in labor force 16-19
  #B23001_010 --> total male 20-21
  #B23001_011 --> male 20-21 employed 
  #B23001_017 --> total male 22-24
  #B23001_018 --> est. employed male 22-24
  #B23001_024 --> total male 25-29
  #B23001_025 --> employed male 25-29
  #B23001_031 --> total male 30-34
  #B23001_032 --> employed male 30-34
  #B23001_038 --> total male 35-44
  #B23001_039 -->employed m 35-44
  #B23001_045 --> total male 45-54
  #B23001_046 --> est. male employed 45-54
  #B23001_052 --> total male 55-59
  #B23001_053 --> est. employed male 55-59
  #B23001_059 --> total male 60-61
  #B23001_060 --> est. employed 60-61
  #B23001_066 --> total male 62-64
  #B23001_067 --> est. employed male 62-64
  #B23001_073 --> total male 65-69
  #B23001_074 --> est. employed male 65-69
  #B23001_078 --> total male 70-74
  #B23001_079 --> est. employed male 70-74
  #B23001_083 --> total m 75 and over
  #B23001_084 --> est. employed male 75 and over
  

  
laborforce_female <- get_acs (geography = "state", 
                               variables = c("B23001_088", "B23001_089","B23001_090", "B23001_096", 
                                             "B23001_097","B23001_103", "B23001_104", "B23001_110", 
                                             "B23001_111", "B23001_117", "B23001_118", "B23001_124",
                                             "B23001_125", "B23001_131", "B23001_132", "B23001_138", 
                                             "B23001_139", "B23001_145", "B23001_146", "B23001_152", 
                                             "B23001_153", "B23001_159", 
                                             "B23001_160", "B23001_164", "B23001_165", "B23001_169", 
                                             "B23001_170"),
                               year = 2022, 
                               survey = "acs5",
                               state = "VT", 
                               output = "wide")

#add new columns with ratio and percent of males in labor force by age group
laborforce_female$per_f_1619 <- (laborforce_female$B23001_090E/laborforce_female$B23001_089E) * 100
laborforce_female$per_f_2021 <- (laborforce_female$B23001_097E/laborforce_female$B23001_096E) * 100
laborforce_female$per_f_2224 <- (laborforce_female$B23001_104E/laborforce_female$B23001_103E) * 100
laborforce_female$per_f_2529 <- (laborforce_female$B23001_111E/laborforce_female$B23001_110E) * 100
laborforce_female$per_f_3034 <- (laborforce_female$B23001_118E/laborforce_female$B23001_117E) * 100
laborforce_female$per_f_3544 <- (laborforce_female$B23001_125E/laborforce_female$B23001_124E) * 100
laborforce_female$per_f_4554 <- (laborforce_female$B23001_132E/laborforce_female$B23001_131E) * 100
laborforce_female$per_f_5559 <- (laborforce_female$B23001_139E/laborforce_female$B23001_138E) * 100
laborforce_female$per_f_6061 <- (laborforce_female$B23001_146E/laborforce_female$B23001_145E) * 100
laborforce_female$per_f_6264 <- (laborforce_female$B23001_153E/laborforce_female$B23001_152E) * 100
laborforce_female$per_f_6569 <- (laborforce_female$B23001_160E/laborforce_female$B23001_159E) * 100
laborforce_female$per_f_7074 <- (laborforce_female$B23001_165E/laborforce_female$B23001_164E) * 100
laborforce_female$per_f_75up <- (laborforce_female$B23001_170E/laborforce_female$B23001_169E) * 100

#save labor_force_part and laborforce_female to excel spreadsheet 
write.csv(labor_force_part, "labor_force_data.csv", row.names = FALSE)
write.csv(laborforce_female, "female_labor_force_data.csv", row.names = FALSE)

  

