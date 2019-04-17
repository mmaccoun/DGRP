####DGRP ANALYSIS
###Created 3/10/2019
###Updated: 4/9/2019

####PURPOSE: process and combine male and female data 
####         female represented in col1 as [1, ] as 0, male represented in [1, ] as 1 
####OUTPUT: a csv file containing data from female and male

library(lattice)
library(ggplot2)
library(caret)
library(tidyr)

set.seed(100)

setwd("~/Desktop/DGRP")

##############      import and format data      ##############


## get female data 
female = read.table("./dgrp.array.exp.female.txt", quote="\"", comment.char="", header=T,
                    stringsAsFactors= F)
tmp = read.table("./dgrp.array.exp.female.txt", quote="\"", comment.char="", header=F,
                    stringsAsFactors= F)
tmp = t(tmp)
female = t(female) #row is a sample & one row is sex, [,1] is all the samples,
#                   sex is a column = 0 but [,2:] is genes
tmp = as.data.frame(tmp) #matrix to data frame
female = as.data.frame(female)

#toSplit = data.frame(tmp[2:369,1])

###LOOK LATER RUN LATER #########################
colnames(tmp) = tmp[ ]
female[1:10,1:10]
#female = female[-c(1),]  #remove row 
female[1:5,1:5]
dim(female)
################################################

female$sex = "female"
dim(tmp)
female$ID = tmp[,1]
tmp[1:5, 1:5]
dim(tmp)
tmp[1,1] = "null_null:null"
tmp = separate(tmp, col = 1 , c("strain", "rep"), sep = ":") #C stack usage 76776039 is too close to the limit, must find alt way for data
female[1:5,1:5]
female$strain = tmp$strain 
female$rep = tmp$rep

female[-c(1)]
female[1:5, 18140:18144]


## get male data 
male = read.table("./dgrp.array.exp.male.txt", quote="\"", comment.char="", header = T)
male = t(male) #row is a sample & one row is sex, [,1] is all the samples, sex is a column = 0 but [,2:] is genes
tmpM = read.table("./dgrp.array.exp.male.txt", quote="\"", comment.char="", header = F) 
tmpM = t(tmpM)
tmpM = as.data.frame(tmpM) #matrix to data frame
male = as.data.frame(male)

###split up data 
male$sex = "male"
dim(tmpM)
dim(male)
male[1:5,1:5]
tmpM[1:5,1:5]
male$ID = tmpM[,1]
tmpM[1,1] = "null_null:null"
tmpM = separate(tmpM, col = 1 , c("strain", "rep"), sep = ":") #C stack usage 76776039 is too close to the limit, must find alt way for data
male[1:5,1:5]
male$strain = tmpM$strain 
male$rep = tmpM$rep
male[-c(1)]
male[1:5, 18140:18144]
## combine to one dataframe 
dim(male)
dim(female)
dim(final)
final = rbind(female, male) #dont include male[1, ] header info from male
write.csv(final, "./final.csv")


