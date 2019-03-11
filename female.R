####DGRP ANALYSIS
###Created 3/10/2019
###Updated: 3/11/2019
library(pls)
setwd("~/Desktop/DGRP")  
female = read.table("~/Desktop/DGRP/dgrp.array.exp.female.txt", quote="\"", comment.char="", header = FALSE)
female = t(female)
female[1,1] = "sample" #down all X and across all genes 
##modify data table later to separate strain and line 
print(dim(female))
train = data.frame((female[2:250, ])) #train with 249 samples, using all genes
train = unlist(train)
typeof(train)

model = plsr(sample ~ model[ ,2:250], data = train, validation = "LOO")
summary(model)
