## Summarize zoning data from parcel level to block group level

library(tidyverse)
library(mapview)
library(sp)
library(sf)
library(rgdal)
library(stringr)
options(scipen=999)

rm(list=ls())
setwd("\\\\econha01/client/CLIENT/1 Consulting/Freddie Mac/Restrictiveness Index/Data/CA/Datasets")

load(file="Parcel_w_Zoning/sanb.Rda")
load(file="Parcel_w_Zoning/sand.Rda")
load(file="Parcel_w_Zoning/rive.Rda")
load(file="Parcel_w_Zoning/kern.Rda")
load(file="Parcel_w_Zoning/santaclara.Rda")
load(file="Parcel_w_Zoning/alam.Rda")
load(file="Parcel_w_Zoning/fres.Rda")
load(file="Parcel_w_Zoning/oran.Rda")
load(file="Parcel_w_Zoning/sacr.Rda")
load(file="Parcel_w_Zoning/mont.Rda")
load(file="Parcel_w_Zoning/sono.Rda")
load(file="Parcel_w_Zoning/cont.Rda")
load(file="Parcel_w_Zoning/eldo.Rda")
load(file="Parcel_w_Zoning/vent.Rda")
load(file="Parcel_w_Zoning/sanf.Rda")
load(file="Parcel_w_Zoning/tula.Rda")
load(file="Parcel_w_Zoning/sanj.Rda")
load(file="Parcel_w_Zoning/stan.Rda")
load(file="Parcel_w_Zoning/santabarbara.Rda")
load(file="Parcel_w_Zoning/sola.Rda")
load(file="Parcel_w_Zoning/santacruz.Rda")
load(file="Parcel_w_Zoning/merc.Rda")
load(file="Parcel_w_Zoning/made.Rda")
load(file="Parcel_w_Zoning/humb.Rda")
load(file="Parcel_w_Zoning/losa.Rda")
length(unique(sanb_parcel_wz$muni))-1+
  length(unique(sand_parcel_wz$muni))-1+
  length(unique(rive_parcel_wz$muni))-1+
  length(unique(kern_parcel_wz$muni))-1+
  length(unique(santaclara_parcel_wz$muni))-1+
  length(unique(alam_parcel_wz$muni))-1+
  length(unique(fres_parcel_wz$muni))-1+
  length(unique(oran_parcel_wz$muni))-1+
  length(unique(sacr_parcel_wz$muni))-1+
  length(unique(mont_parcel_wz$muni))-1+
  length(unique(sono_parcel_wz$muni))-1+
  length(unique(cont_parcel_wz$muni))-1+
  length(unique(eldo_parcel_wz$muni))-1+
  length(unique(vent_parcel_wz$muni))-1+
  length(unique(sanf_parcel_wz$muni))-1+
  length(unique(tula_parcel_wz$muni))-1+
  length(unique(sanj_parcel_wz$muni))-1+
  length(unique(stan_parcel_wz$muni))-1+
  length(unique(santabarbara_parcel_wz$muni))-1+
  length(unique(sola_parcel_wz$muni))-1+
  length(unique(santacruz_parcel_wz$muni))-1+
  length(unique(merc_parcel_wz$muni))-1+
  length(unique(made_parcel_wz$muni))-1+
  length(unique(humb_parcel_wz$muni))-1+
  length(unique(losa_parcel_wz$muni))-1
# 60 municipalities/ZAs


# load census data for Postgres to join to the parcels
library(tidycensus)
census_api_key("1a9a4573ba63a9ec3f543b0aec1920ed1d9483eb", install = TRUE, overwrite = TRUE)
readRenviron("~/.Renviron")
census.var.19 <- load_variables(2019, "acs5", cache = TRUE)
bg2019 <- get_acs(
  geography = "block group",
  state = "CA",
  #county = c("Bronx","Queens","New York"),
  year=2019,
  variables = c("B01001_001E","B19013_001E","B03002_003E","B25001_001E"),
  geometry = FALSE,
  output="wide") %>%
  transmute(GEOID,
            population=B01001_001E,
            pct_nonhiswhite = (population-B03002_003E)/population,
            hu = B25001_001E)

bg2019_sp <- tigris::block_groups(state="CA", year=2019,class="sf") %>% #st_read("\\\\econha01/client/CLIENT/1 Consulting/Freddie Mac/Restrictiveness Index/Data/AZ/Datasets/Census/tl_2019_30_bg/tl_2019_30_bg.shp") %>%
  left_join(bg2019, by="GEOID") %>%
  mutate(popden = population/(ALAND*0.000247105),
         popden = ifelse(ALAND==0|population==0,0,popden),
         huden = hu/(ALAND*0.000247105),
         huden = ifelse(ALAND==0|hu==0,0,hu)) %>%
  transmute(LANDBG=ALAND, WATERBG=AWATER, GEOID,population, popden,pct_nonhiswhite) %>% 
  st_transform(4326)

bg2019_sp[is.na(bg2019_sp)] <- 0  

summary(bg2019_sp$popden)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.000   5.052  10.938  14.689  18.835 294.465 
bg2019_df <- as.data.frame(bg2019_sp) %>% dplyr::select(-geometry)
sum(bg2019_df$population)#39283497
mean(bg2019_df$popden)#14.68945
# class(bg2019_sp)
# # export this block group shapefile
# st_write(bg2019_sp, dsn="Census/shp",layer="bg2019_sp", driver="ESRI Shapefile")
names(bg2019_sp)
#[1] "LANDBG"          "WATERBG"         "GEOID"           "population"      "popden"          "pct_nonhiswhite" "geometry"  

dataset = list(sanb_parcel_wz,sand_parcel_wz,rive_parcel_wz,kern_parcel_wz,santaclara_parcel_wz,
               alam_parcel_wz,fres_parcel_wz,oran_parcel_wz,sacr_parcel_wz,mont_parcel_wz,
               sono_parcel_wz,cont_parcel_wz,eldo_parcel_wz,vent_parcel_wz,sanf_parcel_wz,
               tula_parcel_wz,sanj_parcel_wz,stan_parcel_wz,santabarbara_parcel_wz,sola_parcel_wz,
               santacruz_parcel_wz,merc_parcel_wz,made_parcel_wz,humb_parcel_wz,losa_parcel_wz)

result = list()
for (i in 1:length(dataset)) {
  x <- dataset[[i]] %>% mutate(MAXDEN.h = ifelse(permit_type=="conditional", NA,MAXDEN.h),
                               MAXDEN.l = ifelse(permit_type=="conditional", NA,MAXDEN.l))
  # x.prj <- st_transform(x,crs=st_crs(bg2019_sp))
  x <- as.data.frame(x)
  y <- left_join(x, bg2019_df, by="GEOID")
  bg <- y %>%  
    filter(!is.na(GEOID)) %>%  # note if this filtered out some data points, that means there are parcel centroids fell outside the county's census block groups (could be due to irregularity, need check)
    group_by(GEOID, county)%>% 
    dplyr::summarize(
      MAXHU.h = sum(as.numeric(MAXDEN.h)*as.numeric(ACRE)/43560, na.rm=T),
      MAXHU.l = sum(as.numeric(MAXDEN.l)*as.numeric(ACRE)/43560, na.rm=T),
      n_parcel.tot = sum(n_parcel),
      n_parcel.prohibited = sum(n_parcel[MAXDEN.h==0 & !is.na(MAXDEN.h)&!is.na(ZONING)]),
      zone.prohibited = paste(unique(ZONING[MAXDEN.h==0 & !is.na(MAXDEN.h)&!is.na(ZONING)]),collapse=","),
      GISMAXHU.h = sum(as.numeric(MAXDEN.h)*as.numeric(GISACRES), na.rm=T),
      GISMAXHU.l = sum(as.numeric(MAXDEN.l)*as.numeric(GISACRES), na.rm=T),
      MAXHD.hmicro = mean(as.numeric(MAXDEN.h), na.rm=T),
      MAXHD.lmicro = mean(as.numeric(MAXDEN.l), na.rm=T),
      landtot_bg = mean(LANDBG*0.000247105, na.rm=T),
      GISlandtot_parcel = sum(GISACRES),
      GISlandsample_parcel = sum(GISACRES[!is.na(MAXDEN.h)]),
      GISlandprohibited_parcel = sum(GISACRES[MAXDEN.h==0 & !is.na(MAXDEN.h)&!is.na(ZONING)]),#GIS calculated
      population = mean(population, na.rm=T),
      popden = mean(popden, na.rm=T)) %>% 
    mutate(MAXHD.hmicro = ifelse(is.nan(MAXHD.hmicro),NA,round(MAXHD.hmicro, 4)),
           MAXHD.lmicro = ifelse(is.nan(MAXHD.lmicro),NA,round(MAXHD.lmicro, 4))) %>% 
    mutate(MAXHD.hmacro = ifelse(is.na(MAXHD.hmicro),NA,round(MAXHU.h/landtot_bg,4)),
           MAXHD.lmacro = ifelse(is.na(MAXHD.lmicro),NA,round(MAXHU.l/landtot_bg,4)),
           GISMAXHD.hmacro = ifelse(is.na(MAXHD.hmicro),NA,round(GISMAXHU.h/landtot_bg,4)),
           GISMAXHD.lmacro = ifelse(is.na(MAXHD.lmicro),NA,round(GISMAXHU.l/landtot_bg,4)),
           MAXHU.h = ifelse(is.na(MAXHD.hmicro)&is.na(MAXHD.hmacro)&is.na(GISMAXHD.hmacro),NA,round(MAXHU.h,2)),
           MAXHU.l = ifelse(is.na(MAXHD.lmicro)&is.na(MAXHD.lmacro)&is.na(GISMAXHD.lmacro),NA,round(MAXHU.l,2)),
           GISMAXHU.h = ifelse(is.na(MAXHD.hmicro)&is.na(MAXHD.hmacro)&is.na(GISMAXHD.hmacro),NA,round(GISMAXHU.h,4)),
           GISMAXHU.l = ifelse(is.na(MAXHD.lmicro)&is.na(MAXHD.lmacro)&is.na(GISMAXHD.lmacro),NA,round(GISMAXHU.l,4))
    ) %>% 
    select(county,GEOID,population,popden,landtot_bg,GISlandtot_parcel,MAXHU.h,MAXHU.l,MAXHD.hmicro,MAXHD.lmicro,MAXHD.hmacro,MAXHD.lmacro,
           GISMAXHU.h,GISMAXHU.l,GISMAXHD.hmacro,GISMAXHD.lmacro)
  
  result[[i]] <- bg # add it to your list
}


CA_summary.bg = do.call(rbind, result) #18427 block groups, 3 counties, 60 zoning authority (842 block groups)
length(unique(CA_summary.bg$county)) #26 counties

n_occur <- data.frame(table(CA_summary.bg$GEOID))
n_occur[n_occur$Freq > 1,]

CA_summary.bg <- CA_summary.bg[order(CA_summary.bg$GEOID, -abs(CA_summary.bg$GISlandtot_parcel) ), ]
CA_summary.bg<- CA_summary.bg[ !duplicated(CA_summary.bg$GEOID), ]  #18200 block groups  
CA_summary.bg <- CA_summary.bg %>% filter(!is.na(county)) #18108
CA_summary.bg <- CA_summary.bg %>% mutate(GISMAXHD.hmacro = ifelse(landtot_bg==0,NA,GISMAXHD.hmacro),
                                          GISMAXHD.lmacro = ifelse(landtot_bg==0,NA,GISMAXHD.lmacro))

length(unique(CA_summary.bg$GEOID))== nrow(CA_summary.bg) #TRUE 576
length(unique(CA_summary.bg$GEOID[!is.na(CA_summary.bg$GEOID)]))/length(unique(bg2019_sp$GEOID)) #78.4% block groups covered
length(unique(CA_summary.bg$GEOID[!is.na(CA_summary.bg$GISMAXHD.hmacro)]))/length(unique(bg2019_sp$GEOID))#50.7%
length(unique(CA_summary.bg$GEOID[!is.na(CA_summary.bg$GISMAXHD.hmacro)&CA_summary.bg$GISMAXHD.hmacro!=0]))/length(unique(bg2019_sp$GEOID)) #49.2%                                                                               
length(unique(CA_summary.bg$county)) #25
length(dataset) #25
sum(CA_summary.bg$population[!is.na(CA_summary.bg$GISMAXHD.hmacro)])/sum(bg2019_df$population) #52% population covered by non-na data
sum(CA_summary.bg$population, na.rm = TRUE)/sum(bg2019_df$population) #80% population covered
names(CA_summary.bg)
unique(CA_summary.bg$county)

# no shapefile, or no ordinance interpreted 

write_csv(CA_summary.bg, file="^BG_SUMMARY/CA_summary.bg-09122022.csv")


### generate map visualization
CA_summary.bg<-read_csv(file="^BG_SUMMARY/CA_summary.bg-09122022.csv")
map <- bg2019_sp %>% left_join(CA_summary.bg %>% mutate(GEOID=as.character(GEOID)) %>% dplyr::select(-population,-popden),by="GEOID") %>% 
  transmute(
    COUNTY=county,
    GEOID,
    ALANDBG=LANDBG*0.000247105,
    AWATERBG=WATERBG*0.000247105,
    APARCEL= GISlandtot_parcel,
    population,popden,pct_nonhiswhite,
    MAXHU.h,
    MAXHU.l,
    MAXHD.hmi=MAXHD.hmicro,
    MAXHD.lmi=MAXHD.lmicro,
    # MAXHD.hma=MAXHD.hmacro,
    # MAXHD.lma=MAXHD.lmacro,
    GISMAXHU.h,GISMAXHU.l,
    GISMAXHD.hma=GISMAXHD.hmacro,
    GISMAXHD.lma=GISMAXHD.lmacro,
    geometry
  )
# pima <- map %>% filter(COUNTY == "Sussex County")
# mapview(pima, zcol = "GISMAXHD.hma", alpha=0.1)
# sum(CA_summary.bg$population[!is.na(CA_summary.bg$GISMAXHD.hmacro)&CA_summary.bg$county=="Sussex County"])/sum(bg2019_df$population[substr(bg2019_df$GEOID, 4,5)==19]) #34.39% population covered by non-na data
# sum(CA_summary.bg$population[CA_summary.bg$county=="Sussex County"],na.rm = TRUE )/sum(bg2019_df$population[substr(bg2019_df$GEOID, 4,5)==19]) #40% population covered

names(map)
st_write(map, dsn="^BG_SUMMARY",layer="map_CAbg0912.shp", driver="ESRI Shapefile")

# map_summary <- map %>% as.data.frame() %>% group_by(county, COUNTYFP) %>% 
#   summarize(n_bg=n(),
#             n_pop = sum(poptot),
#             landacre = sum(ALAND*0.000247105))
# write_csv(map_summary, file="Parcel with Zoning Aggregate to Block Group Match Summary.csv")

library(mapview)
library(htmlwidgets)
# library(phantomjs)
#install(phantomjs)
names(map)
mapviewOptions(fgb=FALSE)
mapview(map, zcol="COUNTY")
mapview(map, zcol="GISMAXHD.hma", at=quantile(map$GISMAXHD.hma[!is.na(map$GISMAXHD.hma)]), probs = seq(0, 1, 0.25))
mapview(map, zcol="MAXHD.hmi", at=quantile(map$MAXHD.hmi[!is.na(map$MAXHD.hmi)], probs = seq(0, 1, 0.25)))
html<-mapview(map, zcol="COUNTY") +
  # mapview(map, zcol="MAXHD.hma", at=quantile(map$MAXHD.hma[!is.na(map$MAXHD.hma)], probs = seq(0, 1, 0.25)))+
  mapview(map, zcol="MAXHD.hmi", at=quantile(map$MAXHD.hmi[!is.na(map$MAXHD.hmi)]), probs = seq(0, 1, 0.25))+
  mapview(map, zcol="GISMAXHD.hma", at=quantile(map$GISMAXHD.hma[!is.na(map$GISMAXHD.hma)]), probs = seq(0, 1, 0.25))
# must create after the mapviewoptions
mapshot(
  html,
  url = paste0(getwd(),"/^BG_SUMMARY/CaliforniaBlockGroupZoningData09122022.html"))





# #############To be exported if needed####################
# ####parcel zoning match rate
# dataset = list(bay, brevard,broward, NMagler, hillsborough, lake, lee,leon,manatee, miamidade, okaloosa, orange, 
#                pasco, sarasota, suAZer,citrus)
# match_zone = list()
# match_county = list()
# for (i in 1:length(dataset)) {
#   x <- dataset[[i]]
#   x <- x %>% as.data.frame() %>% dplyr::select(county,ZONING,z_matched,max_densityhff,ALAND,LND_SQFOOT,-geometry) %>% mutate(z_matched=ifelse(is.na(z_matched),2,z_matched)) 
#   zone <- x %>%  # z_matched is na is no zoning
#     group_by(county,ZONING,z_matched) %>% dplyr::summarize(n_parcel = n(),
#                                                   n_parcel_w_den = length(max_densityhff[!is.na(max_densityhff)]),
#                                                   parcelacre = sum(as.numeric(LND_SQFOOT)/43560, na.rm=T),
#                                                   GISparcelacre = sum(as.numeric(ALAND), na.rm=T),
#                                                   parcelacre_w_den = sum(as.numeric(LND_SQFOOT[!is.na(max_densityhff)])/43560,na.rm=T),
#                                                   GISparcelacre_w_den = sum(as.numeric(ALAND[!is.na(max_densityhff)]),na.rm=T)) %>% 
#     mutate(pct_parcel_w_den = n_parcel_w_den/n_parcel,
#            pct_land_w_den = parcelacre_w_den/parcelacre,
#            GISpct_land_w_den = GISparcelacre_w_den/GISparcelacre
#            ) %>% as.data.frame() #solve the nonconsecutive location 
#   county <- zone %>% group_by(county) %>% summarize(n_parcel0 = sum(n_parcel[z_matched==0]),
#                                                            n_parcel1 = sum(n_parcel[z_matched==1]),
#                                                            n_parcel2 = sum(n_parcel[z_matched==2]),
#                                                            n_parcel_tot = sum(n_parcel),
#                                                            n_parcel_w_den = sum(n_parcel_w_den),
#                                                            parcelacre0 = sum(parcelacre[z_matched==0]),
#                                                            parcelacre1 = sum(parcelacre[z_matched==1]),
#                                                            parcelacre2 = sum(parcelacre[z_matched==2]),
#                                                            parcelacre_tot = sum(parcelacre),
#                                                            parcelacre_w_den = sum(parcelacre_w_den),
#                                                     GISparcelacre0 = sum(GISparcelacre[z_matched==0]),
#                                                     GISparcelacre1 = sum(GISparcelacre[z_matched==1]),
#                                                     GISparcelacre2 = sum(GISparcelacre[z_matched==2]),
#                                                     GISparcelacre_tot = sum(GISparcelacre),
#                                                     GISparcelacre_w_den = sum(GISparcelacre_w_den)) %>%
#     mutate(pct_parcel_w_den = n_parcel_w_den/n_parcel_tot,
#            pct_parcel_matched = n_parcel1/n_parcel_tot,
#            pct_land_w_den = parcelacre_w_den/parcelacre_tot,
#            pct_land_matched = parcelacre1/parcelacre_tot,
#            GISpct_land_w_den = GISparcelacre_w_den/GISparcelacre_tot,
#            GISpct_land_matched = GISparcelacre1/GISparcelacre_tot)
#   # 
#   match_zone[[i]] <- zone
#   match_county[[i]] <- county
# }
# 
# NM_parcel_zone_summary = do.call(rbind, match_zone) #1145 zones #6174 block groups, 16 counties, 22 zoning authority
# NM_parcel_county_summary = do.call(rbind, match_county) #16 counties #6174 block groups, 16 counties, 22 zoning authority
# 
# length(unique(NM_parcel_zone_summary$county))==length(dataset)
# length(unique(NM_parcel_county_summary$county))==length(dataset)
# 
# 
# writexl::write_xlsx(
#   list("Summary by Zone" = NM_parcel_zone_summary,
#        "Summary by County" = NM_parcel_county_summary), 
#   "Zoning Density Data Match to Parcel-04192022.xlsx")
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
