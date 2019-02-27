* Encoding: UTF-8.
**** PROPOSED CLASIFICATION SELF-EMPLOYED

GET  FILE='R:\SpssStata\Mathijn\ICT_health_short_analysis\data\Step 2 - after_recodes_incl_JQI_2703.sav'.

do if wave=6.

    * ICT mobile.
    compute ICTmob=y15_Q30i<=2 & (y15_Q35b<=4 or y15_Q35c<=4 or y15_Q35d<=4 or y15_Q35e<=4  or y15_Q35f<=4).
    
    do if ICTmob=1.
    count daily=y15_Q35b,y15_Q35c,y15_Q35d,y15_Q35e,y15_Q35f(1).
    count sevweek=y15_Q35b,y15_Q35c,y15_Q35d, y15_Q35e,y15_Q35f(2).
    end if.
    
    recode y15_q36 (777,888=0) (else=copy) into TrTime.
    * HomeWorkshop - These workers work only from home/employer premises (no commute) or the employers premises are equal to home due to no commute (there are no observations with Q36 = 0).
    compute HomeWorkshop = (y15_Q35a<=4 & (y15_Q35b=5 | missing(y15_Q35b)) & (y15_Q35c=5 | missing(y15_Q35c)) & (y15_Q35d=5 | missing(y15_Q35d)) & y15_Q35e<=4 & (y15_Q35f=5 | missing(y15_Q35f)) & (TrTime=0)) | 
    (y15_Q35a<=3 & (y15_Q35b=5 | missing(y15_Q35b)) & (y15_Q35c=5 | missing(y15_Q35c)) & (y15_Q35d=5 | missing(y15_Q35d)) & (y15_Q35e=5 | missing(y15_Q35e)) & (y15_Q35f=5 | missing(y15_Q35f)) & (TrTime=0)).
    
    * Always Office - conditions: selfemployed & all premises except EmplPrem&Home = never/DK/refusal. 
    compute AlwaysOfficeSE= emp_stat<=2 & y15_Q35a<5 & (y15_Q35b=5 & y15_Q35c=5 & y15_Q35d=5 & y15_Q35e=5 & y15_Q35f=5). 
    
    * Home-based self-employed, conditions: Self-employed & user of ICT & work at Home several times/month or more & has to be working less often in other places (excl. employer premises ).
    compute HomeBasedSE= emp_stat<=2 & y15_Q30i<=2 & ((y15_Q35e<=3 & y15_Q35b>3 & y15_Q35c>3 & y15_Q35d>3 & y15_Q35f>3) | HomeWorkshop=1).
    
    * High mobile self-employed, conditions: self-employed, user of ICT, not home-based SE, measures of high mobility.
    compute HighMobSE= emp_stat<=2 & y15_Q30i<=2 & HomeBasedSE=0 & (daily>=1 or sevweek>=2).
    
    * Low-mobile self-employed - conditions: self-employed, user of ICT, not a teleworking SE, not high mobile SE, not with unknown premises.
    compute LowMobSE= emp_stat<=2 & y15_Q30i<=2 & HomeBasedSE=0 & HighMobSE=0. 
    
    
    **** COPIED CLASIFICATION EMPLOYEES (plus added emp_stat specification for employeed = 3,4,5).
    
    compute alwaysoffice=(emp_stat=3 | emp_stat=4 | emp_stat=5) & y15_Q35a<5 & (y15_Q35b=5 & y15_Q35c=5 & y15_Q35d=5 & y15_Q35e=5 & y15_Q35f=5).
    compute alwaysofficeICT=(emp_stat=3 | emp_stat=4 | emp_stat=5) & y15_Q35a<5 & (y15_Q35b=5 & y15_Q35c=5 & y15_Q35d=5 & y15_Q35e=5 & y15_Q35f=5) & y15_Q30i<=2.
    compute teleworker=(emp_stat=3 | emp_stat=4 | emp_stat=5) & y15_Q30i<=2 & (y15_Q35b>3 and y15_Q35c>3 and y15_Q35d>3 and y15_Q35e<=3 and y15_Q35f>3).
    compute highmob=(emp_stat=3 | emp_stat=4 | emp_stat=5) & y15_Q30i<=2 & teleworker=0 & (daily>=1 or (sevweek>=2) or (daily=1 & sevweek>=1)).
    compute lowmob=(emp_stat=3 | emp_stat=4 | emp_stat=5) & y15_Q30i<=2 & teleworker=0 & highmob=0.
    
    
    **** MERGED VARIABLE CATEGORIZING ICT/M EMPLOYEES AND SELF-EMPLOYED.
    if ICTmob=0 cat_ictmob=0.
    if alwaysoffice=1 cat_ictmob=1.
    if alwaysofficeICT=1 cat_ictmob=2.
    if teleworker=1 cat_ictmob=3.
    if highmob=1 cat_ictmob=4.
    if lowmob=1 cat_ictmob=5.
    if AlwaysOfficeSE=1 cat_ictmob=6.
    if HomeBasedSE=1 cat_ictmob=7.
    if HighMobSE=1 cat_ictmob=8.
    if LowMobSE=1 cat_ictmob=9.
    
    
    variable labels cat_ictmob 'ICT mobile employees & self-employed'.
    value labels cat_ictmob 
    0 'Other'
    1 'Always at employers premise w/o ICT, employee'
    2 'Always at employers premise with ICT, employee'
    3 'Home-based teleworker, employee'
    4 'High mobile T/ICTM, employee'
    5 'Occasional T/ICTM, employee'
    6 'Always Office, self-employed'
    7 'Home-based ICT, self-employed'
    8 'High mobile ICT, self-employed'
    9 'Low-mobile ICT, self-employed'.
    
    **** NEWLY CREATED VARIABLES.
    recode cat_ictmob (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7,8,9=7) (else = SYSMIS) into TICTM.
    value labels TICTM
    1 'Always at employers premise w/o ICT, employee'
    2 'Always at employers premise with ICT, employee'
    3 'Home-based teleworker, employee'
    4 'High mobile T/ICTM, employee'
    5 'Occasional T/ICTM, employee'
    6 'Self-employed'
    7 'Self-employed T/ICTM'.
    
    
    **** NEWLY CREATED VARIABLES.
    recode cat_ictmob (1=1) (2=2) (3=3) (4=4) (5=5) (6=6) (7,8,9=7) (0=8) (else = SYSMIS) into TICTM2.
    value labels TICTM2
    1 'Always at employers premise w/o ICT, employee'
    2 'Always at employers premise with ICT, employee'
    3 'Home-based teleworker, employee'
    4 'High mobile T/ICTM, employee'
    5 'Occasional T/ICTM, employee'
    6 'Self-employed'
    7 'Self-employed T/ICTM'
    8 'Other'.

end if.

freq cat_ictmob.

save outfile = 'R:\SpssStata\Mathijn\ICT_health_short_analysis\data\EWCS_incl_TICTM.sav'.
