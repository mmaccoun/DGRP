####DGRP ANALYSIS
###Created 3/10/2019
###Updated: 4/9/2019

####PURPOSE: process and combine male and female data 
####         female represented in col1 as [1, ] as 0, male represented in [1, ] as 1 
####OUTPUT: a csv file containing data from female and male

library(lattice)
library(ggplot2)
library(caret)

setwd("~/Downloads/DGRP-master")

##############      import and format data      ##############


## get female data 
female = read.table("./dgrp.array.exp.female.txt", quote="\"", comment.char="", header = FALSE)
female = t(female) #row is a sample & one row is sex, [,1] is all the samples, sex is a column = 0 but [,2:] is genes
female[,1] = 0 #change sample names to all 0 for ID as female... now [,1] is all 0 and rest are genes 

female = as.data.frame(female) #values as integers 
dim(female) #368 sampes, 18140 genes measured  
print(female[1:5,1:5])

#print(female[1:5, 1:5])

## get male data 
male = read.table("./dgrp.array.exp.male.txt", quote="\"", comment.char="", header = FALSE)
male = t(male) #row is a sample & one row is sex, [,1] is all the samples, sex is a column = 0 but [,2:] is genes
male[,1] = 1
male = as.data.frame(male)
print(male[1:5,1:5])
dim(male) #369 samples, 18140 genes measured 


## combine to one dataframe 
final = rbind(female,male[2:370,]) #dont include male[1, ] header info from male
write.csv(final, file = "all_data.csv")

