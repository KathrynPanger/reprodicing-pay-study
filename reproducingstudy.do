***************************************************************
******The Gender Wage Gap and Gender Roles in the 2016 GSS*****
***************************************************************
*	This file is designed to reproduce the findings from 
*	Danice Langdon and Roger Klomegah's 2013 study which used 
*	data from the 2010 General Social Survey to reaffirm the 
*	existence of the wage gap and to determine to what degree
*	women's internalization of gender roles explains variation
*	in women's income (i.e. is responsible for the wage gap). 
*	Here, I use data from the more recent 2016 GSS, recoding  
*	variables to reflect the methodology of the original study   
*	while incoporating the updated census occupational codes   
*	which Landon and Klomegah did not use.
***************************************************************
*Use the 2016 GSS Data*
use "C:\Users\kathr\OneDrive\Documents\code\stata\GSS2016.DTA", clear
****************************************************************

*VARIABLES*

*NOTE: All variables are recoded in order to create a 
*reference group with the value '0.' This is done
*in order to facilitate analysis and interpretation*

*DEPENDENT VARIABLE*

*Dependent variable, respondent's income*
tab rincom06
*Recode this variable to match Langon and Klomegah 2013*
*As their original variable*
gen rincomcat=rincom06
recode rincomcat 1/12 = 0
recode rincomcat 13/15 = 1
recode rincomcat 16/17 = 2
recode rincomcat 18/19 = 3
recode rincomcat 20=4
recode rincomcat 21=5
recode rincomcat 22=6
recode rincomcat 23=7
recode rincomcat 24=8
recode rincomcat 25/26=9

*As a three category variable, low middle high*
gen rincom3=rincom06
recode rincom3 1/17 = 0
recode rincom3 18/22 = 1
recode rincom3 23/25 = 2
*As a dichotomous variable, low = 0 high = 1*
gen rincomdi=rincom06
recode rincomdi 1/18 = 0
recode rincomdi 19/26 = 1

*Independent variables*
*Gender ideology, recoded to make "strongly agree" the reference group*

tab fefam
gen fefamcat = fefam
recode fefamcat 1=0 2=1 3=2 4=3

*Gender ideology, recoded to be a dichotomous variable for logistic regression*
gen fefamddum=fefam
recode fefamdum 1/2=1 3/4=0

*Education Level, changed to match L&K's coding*
tab degree
gen degreelk = degree
recode degreelk 1=0
recode degreelk 2=1
recode degreelk 3=2
recode degreelk 4=3

*Occupation*
*Recodes the occ10 variable to reflect the  23 major groups
*of the 2010 Standard Occupational Classification system. 
*The updated classification is significantly different from 
*the outdated 1980 system that Langdon and Klomegah used*

gen occ10true = occ10
*managers = 1*
recode occ10true 10/499=1
*business and financial*
recode occ10true 500/950=2
*Computer and Math*
recode occ10true 1000/1240=3
*Architecture and Engineering*
recode occ10true 1300/1560=4
*Life, Physical, and Social Science*
recode occ10true 1600/1965=5
*Comunity and Social Service*
recode occ10true 2000/2060=6
*Legal*
recode occ10true 2100/2160=7
*Education, Training, Library*
recode occ10true 2200/2550=8
*arts, design, entertainment, sports, media*
recode occ10true 2600/2960=9
*Healthcare practitioners and technical occupations*
recode occ10true 3000/3540=10
*Healthcare support occupations*
recode occ10true 3600/3655=11
*Protective Service Occupations*
recode occ10true 3700/3955=12
*Food Preparation and Serving Related*
recode occ10true 4000/4160=13
*Building and Grounds Cleaning and Maintenence*
recode occ10true 4200/4250=14
*Personal care and service*
recode occ10true 4300/4650=15
*sales and related*
recode occ10true 4700/4965=16
*office and administrative support*
recode occ10true 5000/5940=17
*farming fishing and forestry*
recode occ10true 6005/6130=18
*Construction and Extraction Occuptations*
recode occ10true 6200/6940=19
*installation, maintenence and repair*
recode occ10true 7000/7630=20
*production occupations*
recode occ10true 7700/8965=21
*Transportation and material moving*
recode occ10true 9000/9750=22
*Military*
recode occ10true 9800/9830=0

*Occupation simplified*
*The new 2010 occupational codes (above) are too numberous for an 
*easily interpretable model, so I have created a simplified
*coding system designed to emulate Landon and Klomegah's model.
*Note that these codes are based on the coder's (my) 
*personal discretion guided as closely as possible by my interpretation
*of the 1980 census codes. This may be substantively problematic until 
*my version receives review and revision. In fact, we can expect that
*these codes will NOT be substantively relevant BECAUSE they are are
*inherently based on an outdated classification system. More research
*is needed to produce a rigorous analysis here, but we will continue
*for now*

gen occ10truncate=occ10true
*Managerial and professsional specialty positions*
recode occ10truncate 1/3 5 8/9 = 1
*Technical, Sales, and Administrative Support Occupations
recode occ10truncate 4/7 10/12 16/17 = 2
*Service Occupations*
recode occ10truncate 13/15=3
*Farm Fish and Forest*
recode occ10truncate 18=4
*Precision, Production, Craft, and Repair*
recode occ10truncate 19/21=5
*Operators, Fabricators, Laborers*
recode occ10truncate 22=6
*note that military is still coded 0*



*****CONTROL VARIABLES****
*Control variables for this analysis include
*gender, age, marital status, race, and religiosity.*

tab sex
gen sexdum=sex
recode sexdum 1=0 2=1

tab age
gen agecat=age
recode agecat 18/29=0 30/39=1 40/49=2 50/59=3 60/69=4 70/500=5

tab marital
gen maritaldum=marital
recode maritaldum 1=0 2/5=1

tab race
gen racecat=race
recode racecat 1=0 2=1 3=2

tab relpersn
gen relpersncat=relpersn
recode relpersncat 1=0 2=1 3=2 4=3
