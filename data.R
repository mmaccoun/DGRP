####DGRP ANALYSIS
###Created 3/10/2019
###Updated: 3/17/2019

####PURPOSE: this file will format the data needed to test and train


setwd("~/Desktop/DGRP")  

##import data 
female = read.table("~/Desktop/DGRP/dgrp.array.exp.female.txt", quote="\"", comment.char="", header = FALSE)
#print(female[1:5,1:5]) #add sex and rep ID columns 
female = t(female) 
#dim(female) #369 18141 


male = read.table("~/Desktop/DGRP/dgrp.array.exp.male.txt", quote="\"", comment.char="", header = FALSE)
male = t(male)
#dim(male) #370 18141


##add column to ID replicate and sex 
total = rbind(female, male) #combine all male and female (X = sample, Y = gene)




