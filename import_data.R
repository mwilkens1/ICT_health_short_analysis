library(foreign)

#Importing data
EWCS <- read.spss("data/Step 2 - after_recodes_incl_JQI_2703.sav", to.data.frame=T)

#Getting EU27 weight for 2003
save(EWCS,file="data/EWCS.Rda")