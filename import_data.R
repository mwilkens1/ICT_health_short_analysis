library(foreign)

#Importing data
EQLS <- read.spss("R:/SpssStata/Mathijn/WLB/data/EQLS trend dataset - 4 waves - all countries - with cities.sav", to.data.frame=T)
EQLS_2016 <- read.spss("R:/SpssStata/Mathijn/WLB/data/4th EQLS full dataset with paradata - clean - 7 February 2018.sav", to.data.frame=T)
EWCS <- read.spss("R:/SpssStata/Mathijn/WLB/data/Step 2 - after_recodes_incl_JQI_2703.sav", to.data.frame=T)

#Getting EU27 weight for 2003
EQLS$WCalib_crossnational_EU28[EQLS$Wave=="1st EQLS (2003)"] <- EQLS$Y03_EU28wt[EQLS$Wave=="1st EQLS (2003)"]
EQLS$WCalib_crossnational_EU28[EQLS$Y16_Country=="Turkey"] <- NA

save(EQLS,file="EQLS.Rda")
save(EWCS,file="EWCS.Rda")
save(EQLS_2016,file="EQLS_2016.Rda")

 
