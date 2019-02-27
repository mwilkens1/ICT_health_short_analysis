library(foreign)

#Importing data
EWCS <- read.spss("data/EWCS_incl_TICTM.sav", to.data.frame=T)

#Getting EU27 weight for 2003
save(EWCS,file="data/EWCS.Rda")
