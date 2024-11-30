setwd("\\\\econha01/client/CLIENT/1 Consulting/Freddie Mac/Restrictiveness Index/Data/CA/Datasets")
rm(list=ls())
load(file="Parcel_w_Zoning/mont summary.Rda")
load(file="Parcel_w_Zoning/santaclara summary.Rda")
load(file="Parcel_w_Zoning/sand summary.Rda")
load(file="Parcel_w_Zoning/rive summary.Rda")
load(file="Parcel_w_Zoning/sacr summary.Rda")
load(file="Parcel_w_Zoning/oran summary.Rda")
load(file="Parcel_w_Zoning/alam summary.Rda")
load(file="Parcel_w_Zoning/santacruz summary.Rda")
load(file="Parcel_w_Zoning/tula summary.Rda")
load(file="Parcel_w_Zoning/stan summary.Rda")
load(file="Parcel_w_Zoning/sanf summary.Rda")
load(file="Parcel_w_Zoning/kern summary.Rda")
load(file="Parcel_w_Zoning/fres summary.Rda")
load(file="Parcel_w_Zoning/santabarbara summary.Rda")
load(file="Parcel_w_Zoning/sono summary.Rda")
load(file="Parcel_w_Zoning/vent summary.Rda")
load(file="Parcel_w_Zoning/sanb summary.Rda")
load(file="Parcel_w_Zoning/made summary.Rda")
load(file="Parcel_w_Zoning/cont summary.Rda")
load(file="Parcel_w_Zoning/sola summary.Rda")
load(file="Parcel_w_Zoning/sanj summary.Rda")
load(file="Parcel_w_Zoning/eldo summary.Rda")
load(file="Parcel_w_Zoning/humb summary.Rda")
load(file="Parcel_w_Zoning/merc summary.Rda")
load(file="Parcel_w_Zoning/losa summary.Rda")


match_summary <-
  rbind(match_mont_parcel_wz,match_santaclara_parcel_wz,match_sand_parcel_wz,
        match_rive_parcel_wz,match_sacr_parcel_wz,match_oran_parcel_wz,
        match_alam_parcel_wz,match_santacruz_parcel_wz,match_tula_parcel_wz,
        match_stan_parcel_wz,match_sanf_parcel_wz,match_kern_parcel_wz,
        match_fres_parcel_wz,match_santabarbara_parcel_wz,match_sono_parcel_wz,
        match_vent_parcel_wz,match_sanb_parcel_wz,match_made_parcel_wz,
        match_cont_parcel_wz,match_sola_parcel_wz,match_sanj_parcel_wz,
        match_eldo_parcel_wz,match_humb_parcel_wz,match_merc_parcel_wz,
        match_losa_parcel_wz) #221
write_csv(match_summary, file="Zoning Density Data Match to Zoning Shapefile-09122022.csv")

## the following didn't get exported bc string exceeds excel's limit of 32,767 characters##
## if needed for export, use this script to run
CA.zoning_muni<-read_csv(file="Zoning/CA Municipality and Zoning Data Collected-09082022.csv")
match_summary_muni <- match_summary %>% group_by(muni, county) %>% dplyr::summarize(n_district=n(), acre=sum(acre), ZONING1_shp = paste(unique(ZONING1), collapse=", "), n_parcel=sum(totalparcel), n_parcel_matched=sum(z_matched))
writexl::write_xlsx(list(
  "Ordinance"=CA.zoning_muni,
  "Shapefile Joined by Muni"=match_summary_muni),
  "Zoning/CA Municipality and Zoning Data Collected-09122022.xlsx")
# Error: Error in libxlsxwriter: 'String exceeds Excel's limit of 32,767 characters.'
