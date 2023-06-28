## generating complete crosswalk

library(tidyverse)
library(readxl)
devtools::install_github("Guidowe/occupationcross")
library(occupationcross)


##### Importing data
cnodf <- read_excel("input/crosswalk_oficio_isco.xlsx")
cnodf <- cnodf %>% as.data.frame
cnodf <- cnodf %>% mutate(cno70 = as.numeric(cno70))
isco68_TO_isco88 <- read_excel("input/isco68_TO_isco88.xlsx")
isco68_TO_isco88 <- isco68_TO_isco88 %>% as.data.frame

walk1 <- reclassify_to_isco08(base = isco68_TO_isco88,
                     variable = isco88,
                     classif_origin = "ISCO88",
                     add_skill = T,
                     add_major_groups = T,
                     code_titles = T) 

walk1 <- walk1 %>% mutate(cno70 = as.numeric(cno70))

walk1 <- walk1 %>% mutate(ISCO.08 = case_when(
  isco88 == 5200 ~ '4213',
  isco88 == 7510 ~ '3121',
  TRUE ~ isco88))

merged <- merge(walk1, cnodf, all=TRUE)


merged <- merged %>% select(cno70, ISCO.08, skill_level, major_group, cno70_desc)
merged <- merged %>% rename(isco08 = ISCO.08)

iscodesc <- read_excel("input/crosswalk_oficio_isco.xlsx", 
                                    sheet = "ISCO-08 EN Struct and defin")

iscodesc <- iscodesc %>% filter(Level == 4) %>% select(`ISCO 08 Code`, `Title EN`) %>% rename(isco08 = `ISCO 08 Code`, isco08_desc = `Title EN`)

merged <- merge(merged, iscodesc, all = TRUE)
merged <- merged %>% unique %>% filter(!is.na(cno70))

merged <- merged %>% mutate(isco08_l2 = floor(as.numeric(isco08)/100))
merged <- merged %>% select(isco08, isco08_l2, cno70, isco08_desc, cno70_desc, major_group, skill_level)

# write.csv(merged, 'output/cw_cno70_isco08.csv')
