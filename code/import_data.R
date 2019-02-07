library(foreign)

#Importing data
EWCS <- read.spss("R:/SpssStata/Mathijn/WLB/data/Step 2 - after_recodes_incl_JQI_2703.sav", to.data.frame=T)

#Getting EU27 weight for 2003
save(EWCS,file="EWCS.Rda")