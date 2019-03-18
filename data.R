####DGRP ANALYSIS
###Created 3/10/2019
###Updated: 3/17/2019

####PURPOSE: this file will format the data needed to test and train

library("caret")


setwd("~/Desktop/DGRP")  

##import data 
female = read.table("~/Desktop/DGRP/dgrp.array.exp.female.txt", quote="\"", comment.char="", header = FALSE)
#print(female[1:5,1:5]) #add sex and rep ID columns 
print(set.seed(100))

female = t(female) 
dim(female)
trainXX = female[2:245, 2:18141]
testXX = female[246:369, 2:18141]

#dim(female) #369 18141 


male = read.table("~/Desktop/DGRP/dgrp.array.exp.male.txt", quote="\"", comment.char="", header = FALSE)
male = t(male)
dim(male)
trainXY = male[2:247,2:18141] 
testXY = male[248:370,2:18141]
#dim(male) #370 18141


##add column to ID replicate and sex 
train = rbind(trainXX, trainXY) #combine all male and female (X = sample, Y = gene)
dim(total)
total = as.factor(total[2:739, 2:18141])

trainSet = rbind(trainXX,trainXY)
testSet = rbind(testXX, testXY)
