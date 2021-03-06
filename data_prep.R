##################
#Data preparation#
##################

#Subsetting data
#Dataset 'EWCS' created with 'import_data.R'. The analysis will not cover any years before 2000 so that data can be excluded. It will also only cover the EU28 of 2015.

load("data/EWCS.Rda")

EWCS_EU28 <- subset(EWCS, EU_x==1 & as.numeric(wave)>=3)

EWCS_EU28$wave <- droplevels(EWCS_EU28$wave)
EWCS_EU28$countid <- droplevels(EWCS_EU28$countid)


#Recodes

#year
EWCS_EU28$t <- as.numeric(EWCS_EU28$wave)

#yeardummies
d <- as.data.frame(model.matrix( ~ wave - 1, data=EWCS_EU28 ))
colnames(d) <- c("w2000","w2005","w2010","w2015")
EWCS_EU28 <- cbind(EWCS_EU28,d)
rm(d)

#Country
EWCS_EU28$countid <- droplevels(EWCS_EU28$countid)
temp <- as.data.frame(model.matrix( ~ countid - 1, data=EWCS_EU28 ))
names(temp) <- gsub(" ", "_", names(temp))
EWCS_EU28 <- cbind(EWCS_EU28,temp )
rm(temp)

#working with computers
EWCS_EU28$y15_Q30i <- ordered(EWCS_EU28$y15_Q30i, levels=rev(levels(EWCS_EU28$y15_Q30i)))
EWCS_EU28$computer <- as.numeric(EWCS_EU28$y15_Q30i)

#Age
EWCS_EU28$age <- as.numeric(levels(EWCS_EU28$y15_Q2b))[EWCS_EU28$y15_Q2b]

#gender
EWCS_EU28$woman <- as.numeric(EWCS_EU28$y15_Q2a)-1

#ISCO08_1d (2010 & 2005)
EWCS_EU28$y15_isco_08_1 <- factor(EWCS_EU28$y15_isco_08_1, levels=c("Managers","Professionals","Technicians and associate professionals","Clerical support workers","Service and sales workers","Skilled agricultural, forestry and fishery workers","Craft and related trades workers","Plant and machine operators, and assemblers","Elementary occupations","Armed forces occupations"))

EWCS_EU28$ISCO_d1[EWCS_EU28$y15_isco_08_1=="Managers"] <- 1
EWCS_EU28$ISCO_d1[EWCS_EU28$y15_isco_08_1!="Managers"] <- 0
EWCS_EU28$ISCO_d2[EWCS_EU28$y15_isco_08_1=="Professionals"] <- 1
EWCS_EU28$ISCO_d2[EWCS_EU28$y15_isco_08_1!="Professionals"] <- 0
EWCS_EU28$ISCO_d3[EWCS_EU28$y15_isco_08_1=="Technicians and associate professionals"] <- 1
EWCS_EU28$ISCO_d3[EWCS_EU28$y15_isco_08_1!="Technicians and associate professionals"] <- 0
EWCS_EU28$ISCO_d4[EWCS_EU28$y15_isco_08_1=="Clerical support workers"] <- 1
EWCS_EU28$ISCO_d4[EWCS_EU28$y15_isco_08_1!="Clerical support workers"] <- 0
EWCS_EU28$ISCO_d5[EWCS_EU28$y15_isco_08_1=="Service and sales workers"] <- 1
EWCS_EU28$ISCO_d5[EWCS_EU28$y15_isco_08_1!="Service and sales workers"] <- 0
EWCS_EU28$ISCO_d6[EWCS_EU28$y15_isco_08_1=="Skilled agricultural, forestry and fishery workers"] <- 1
EWCS_EU28$ISCO_d6[EWCS_EU28$y15_isco_08_1!="Skilled agricultural, forestry and fishery workers"] <- 0
EWCS_EU28$ISCO_d7[EWCS_EU28$y15_isco_08_1=="Craft and related trades workers"] <- 1
EWCS_EU28$ISCO_d7[EWCS_EU28$y15_isco_08_1!="Craft and related trades workers"] <- 0
EWCS_EU28$ISCO_d8[EWCS_EU28$y15_isco_08_1=="Plant and machine operators, and assemblers"] <- 1
EWCS_EU28$ISCO_d8[EWCS_EU28$y15_isco_08_1!="Plant and machine operators, and assemblers"] <- 0
EWCS_EU28$ISCO_d9[EWCS_EU28$y15_isco_08_1=="Elementary occupations"] <- 1
EWCS_EU28$ISCO_d9[EWCS_EU28$y15_isco_08_1!="Elementary occupations"] <- 0

#NACE10 (2010/2015)
EWCS_EU28$nace_d1  <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[1])
EWCS_EU28$nace_d2  <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[2])
EWCS_EU28$nace_d3  <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[3])
EWCS_EU28$nace_d4  <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[4])
EWCS_EU28$nace_d5  <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[5])
EWCS_EU28$nace_d6  <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[6])
EWCS_EU28$nace_d7  <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[7])
EWCS_EU28$nace_d8  <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[8])
EWCS_EU28$nace_d9  <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[9])
EWCS_EU28$nace_d10 <- as.numeric(EWCS_EU28$nace10==levels(EWCS_EU28$nace10)[10])


#ISCO88 (2000)
#EWCS_EU28$y15_ISCO_88_1
#EWCS_EU28$y15_ISCO_88_2

#Education
EWCS_EU28$edu_low <- as.numeric(EWCS_EU28$education=="primary")
EWCS_EU28$edu_high <- as.numeric(EWCS_EU28$education=="tertiary")

#Frequent disruptive interruptions
EWCS_EU28$freq_dis_int <- as.ordered(EWCS_EU28$freq_dis_int)

#High speed
EWCS_EU28$y15_Q49a <- factor(EWCS_EU28$y15_Q49a, 
                             levels=c("Never                  ",
                                      "Almost never           ",
                                      "Around ¼ of the time   ",
                                      "Around half of the time",
                                      "Around ¾ of the time   ",
                                      "Almost all of the time ",
                                      "All of the time        "), 
                             ordered=TRUE)

#Tight deadlines
EWCS_EU28$y15_Q49b <- factor(EWCS_EU28$y15_Q49b, 
                             levels=c("Never                  ",
                                      "Almost never           ",
                                      "Around ¼ of the time   ",
                                      "Around half of the time",
                                      "Around ¾ of the time   ",
                                      "Almost all of the time ",
                                      "All of the time        "), 
                             ordered=TRUE)

#Not enough time to get the job done
EWCS_EU28$y15_Q61g <- factor(EWCS_EU28$y15_Q61g, 
                             levels=c("Always                       ",
                                      "Most of the time             ",
                                      "Sometimes                    ",
                                      "Rarely                       ",
                                      "Never                        ")
                             , ordered=TRUE)

#Working hours
#totalhour

#Working more than 48 hours
EWCS_EU28$longhour <- ordered(EWCS_EU28$longhour)

#Work in free time
EWCS_EU28$y15_Q46_r <- factor(EWCS_EU28$y15_Q46, 
                              levels=c("Never                        ",
                                       "Less often                   ",
                                       "Several times a month        ",
                                       "Several times a week         ",
                                       "Daily                        ")
                              , ordered=TRUE)

#Hour or two off
EWCS_EU28$y15_Q47 <- ordered(EWCS_EU28$y15_Q47, levels=rev(levels(EWCS_EU28$y15_Q47)))

#Autonomy
EWCS_EU28$y15_Q54a <- factor(EWCS_EU28$y15_Q54a, 
                             levels=c("No                        ",
                                      "Yes                       "), 
                             ordered=TRUE)
EWCS_EU28$y15_Q54b <- factor(EWCS_EU28$y15_Q54b, 
                             levels=c("No                        ",
                                      "Yes                       "), 
                             ordered=TRUE)
EWCS_EU28$y15_Q54c <- factor(EWCS_EU28$y15_Q54c, 
                             levels=c("No                        ",
                                      "Yes                       "), 
                             ordered=TRUE)

EWCS_EU28$y15_Q61e <- factor(EWCS_EU28$y15_Q61e, levels=rev(levels(EWCS_EU28$y15_Q61e)), ordered=TRUE)

#Cognitive dimension
#Solving unforeseen problems
EWCS_EU28$y15_Q53c <- ordered(EWCS_EU28$y15_Q53c, levels=rev(levels(EWCS_EU28$y15_Q53c)))

#Carrying out complex tasks
EWCS_EU28$y15_Q53e <- ordered(EWCS_EU28$y15_Q53e, levels=rev(levels(EWCS_EU28$y15_Q53e)))

#Learning new things
EWCS_EU28$y15_Q53f <- ordered(EWCS_EU28$y15_Q53f, levels=rev(levels(EWCS_EU28$y15_Q53f)))

#apply own ideas
EWCS_EU28$y15_Q61i <- ordered(EWCS_EU28$y15_Q61i, levels=rev(levels(EWCS_EU28$y15_Q61i)))

#Social support
EWCS_EU28$y15_Q61a <- ordered(EWCS_EU28$y15_Q61a, levels=rev(levels(EWCS_EU28$y15_Q61a)))
EWCS_EU28$y15_Q61b <- ordered(EWCS_EU28$y15_Q61b, levels=rev(levels(EWCS_EU28$y15_Q61b)))

EWCS_EU28$SS <- EWCS_EU28$y15_Q61a

#WHO5
EWCS_EU28$y15_Q87a <- ordered(EWCS_EU28$y15_Q87a, levels=rev(levels(EWCS_EU28$y15_Q87a)))
EWCS_EU28$y15_Q87b <- ordered(EWCS_EU28$y15_Q87b, levels=rev(levels(EWCS_EU28$y15_Q87b)))
EWCS_EU28$y15_Q87c <- ordered(EWCS_EU28$y15_Q87c, levels=rev(levels(EWCS_EU28$y15_Q87c)))
EWCS_EU28$y15_Q87d <- ordered(EWCS_EU28$y15_Q87d, levels=rev(levels(EWCS_EU28$y15_Q87d)))
EWCS_EU28$y15_Q87e <- ordered(EWCS_EU28$y15_Q87e, levels=rev(levels(EWCS_EU28$y15_Q87e)))

#health in general
EWCS_EU28$y15_Q75 <- ordered(EWCS_EU28$y15_Q75, levels=rev(levels(EWCS_EU28$y15_Q75)))

#Anxiety
EWCS_EU28$anxiety <- ordered(EWCS_EU28$y15_Q78h_lt, levels=rev(levels(EWCS_EU28$y15_Q78h_lt)))

#Fatigue
EWCS_EU28$fatigue <- ordered(EWCS_EU28$y15_Q78i_lt, levels=rev(levels(EWCS_EU28$y15_Q78i_lt)))

#headache/eyestrain
EWCS_EU28$headeye <- ordered(EWCS_EU28$y15_Q78f_lt, levels=rev(levels(EWCS_EU28$y15_Q78f_lt)))

#Stress
EWCS_EU28$stress  <- ordered(EWCS_EU28$y15_Q61m, levels=rev(levels(EWCS_EU28$y15_Q61m)))

#absenteeism /presenteeism
EWCS_EU28$absenteeism <- ordered(EWCS_EU28$absenteeism)

EWCS_EU28$presenteeism <- ordered(EWCS_EU28$presenteeism)

#Engagement
EWCS_EU28$y15_Q90a <- ordered(EWCS_EU28$y15_Q90a, levels=rev(levels(EWCS_EU28$y15_Q90a )))
EWCS_EU28$y15_Q90b <- ordered(EWCS_EU28$y15_Q90b, levels=rev(levels(EWCS_EU28$y15_Q90b )))
EWCS_EU28$y15_Q90c <- ordered(EWCS_EU28$y15_Q90c, levels=rev(levels(EWCS_EU28$y15_Q90c )))

#Burnout
EWCS_EU28$y15_Q90d <- ordered(EWCS_EU28$y15_Q90d, levels=rev(levels(EWCS_EU28$y15_Q90d )))
EWCS_EU28$y15_Q90e <- ordered(EWCS_EU28$y15_Q90e, levels=rev(levels(EWCS_EU28$y15_Q90e )))
EWCS_EU28$y15_Q90f <- ordered(EWCS_EU28$y15_Q90f, levels=levels(EWCS_EU28$y15_Q90f))

#ICT mobile workers
EWCS_EU28$NoICTmob <- (EWCS_EU28$ICTmob-1)*-1
#alwaysoffice
#alwaysofficeICT
#teleworker
#highmob=1 
#lowmob=1
#AlwaysOfficeSE
#HomeBasedSE
#HighMobSE
#LowMobSE

EWCS_EU28$y15_Q35a <- as.numeric(EWCS_EU28$y15_Q35a)
EWCS_EU28$y15_Q35b <- as.numeric(EWCS_EU28$y15_Q35b)
EWCS_EU28$y15_Q35c <- as.numeric(EWCS_EU28$y15_Q35c)
EWCS_EU28$y15_Q35d <- as.numeric(EWCS_EU28$y15_Q35d)
EWCS_EU28$y15_Q35e <- as.numeric(EWCS_EU28$y15_Q35e)
EWCS_EU28$y15_Q35f <- as.numeric(EWCS_EU28$y15_Q35f)

#Mobility
EWCS_EU28$mob[(EWCS_EU28$y15_Q35b>3 & EWCS_EU28$y15_Q35c>3 & EWCS_EU28$y15_Q35d>3 & EWCS_EU28$y15_Q35e<=3 & EWCS_EU28$y15_Q35f>3) | EWCS_EU28$HomeWorkshop] <- "Homebased telework"
EWCS_EU28$mob[EWCS_EU28$y15_Q35a<5 & (EWCS_EU28$y15_Q35b==5 & EWCS_EU28$y15_Q35c==5 & EWCS_EU28$y15_Q35d==5 & EWCS_EU28$y15_Q35e==5 & EWCS_EU28$y15_Q35f==5)] <- "Always at employers premises"
EWCS_EU28$mob[is.na(EWCS_EU28$mob) & ((EWCS_EU28$daily>=1 | EWCS_EU28$sevweek>=2) | (EWCS_EU28$daily==1 & EWCS_EU28$sevweek>=1))] <- "High mobile"
EWCS_EU28$mob[is.na(EWCS_EU28$mob) & !is.na(EWCS_EU28$y15_Q35a) & !is.na(EWCS_EU28$y15_Q35b) & !is.na(EWCS_EU28$y15_Q35c) & !is.na(EWCS_EU28$y15_Q35d) & !is.na(EWCS_EU28$y15_Q35e) & !is.na(EWCS_EU28$y15_Q35f)] <- "Low mobile"

EWCS_EU28$mob0 <- as.numeric(EWCS_EU28$mob=="Always at employers premises")
EWCS_EU28$mob1 <- as.numeric(EWCS_EU28$mob=="Low mobile")
EWCS_EU28$mob2 <- as.numeric(EWCS_EU28$mob=="High mobile")
EWCS_EU28$mob3 <- as.numeric(EWCS_EU28$mob=="Homebased telework")

#Working time arrangements
EWCS_EU28$wa_set   <- as.numeric(EWCS_EU28$y15_Q42=="They are set by the company / organisation  with no possibility for changes                  ")
EWCS_EU28$wa_fixed <- as.numeric(EWCS_EU28$y15_Q42=="You can choose between several fixed working schedules determined by the company/organisation")
EWCS_EU28$wa_adapt <- as.numeric(EWCS_EU28$y15_Q42=="You can adapt your working hours within certain limits (e.g. flextime)                       ")
EWCS_EU28$wa_self  <- as.numeric(EWCS_EU28$y15_Q42=="Your working hours are entirely determined by yourself                                       ")

#Sleep
EWCS_EU28$y15_Q79a <- ordered(EWCS_EU28$y15_Q79a, rev(levels(EWCS_EU28$y15_Q79a)))
EWCS_EU28$y15_Q79b <- ordered(EWCS_EU28$y15_Q79b, rev(levels(EWCS_EU28$y15_Q79b)))
EWCS_EU28$y15_Q79c <- ordered(EWCS_EU28$y15_Q79c, rev(levels(EWCS_EU28$y15_Q79c)))

save(EWCS_EU28,file="data/EWCS_EU28.Rda")