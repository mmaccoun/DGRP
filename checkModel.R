####DGRP ANALYSIS
###Created 4/19/2019
###Updated: 4/25/2019

##STATUS: in progress 
####PURPOSE: separate data in training and testing sets (2:1)
####         see if PLS-DA model will be able to segregarte sex  of sample using 
##             transcriptome data
##replicates and new strains
##subdivide  data 
##          
####OUTPUT: 

library(e1071)
library(caret)
setwd("~/Desktop/DGRP")
set.seed(100)
###CAN ALSO RANDOMIZE NOVEL GENOMES ENC 
dat  = read.csv("final.csv", header = T)
##set binary for sex 
##maybe unneccissary 
dat[dat$sex == "female"] = 0
dat[dat$sex == "male"] = 1

#create predictor 

#################      partition data for testing and training      ##############
###only use rep 1 samples, remove irrel. data 
rep1_DAT = dat[!(dat$rep==2) , ] ##only use the rep 1 samples 
rep1_DAT = rep1_DAT[, 1 : 18142] #remove ID, strain, rep
rep1_DAT = rep1_DAT[-1, -1 ]
#rep1_DAT = factor(rep1_DAT)
split = createDataPartition(rep1_DAT, p = 0.75, list = F)
trainDat = rep1_DAT[-train, ] #737 obs 
testDat = rep1_DAT[train, ] #277z obs 

dim(trainDat)
dim(rep1_Y)



#################      partition data for testing and training      ##############
rep1_Y = trainDat[!is.na(c(trainDat$sex))] #what to predict
rep1_Y = rep1_Y$sex



#################      create feature matrix      ##############

rep1.feat.mat = trainDat[!is.na(trainDat$sex), 1:18140]
#rep1.feat.mat = scale(rep1.feat.mat, center = TRUE, scale = TRUE)
rep1.feat.mat = as.data.frame(rep1.feat.mat)
dim(rep1.feat.mat)
dim(rep1_Y)
#################      train data      ##############
nfold = 3

train.dr = caret::train(rep1.feat.mat, rep1_Y, method = "pls", preProcess = NULL,
                        tuneLength = 10,
                        trControl = trainControl(method = "cv", number = nfold, 
                                                 savePredictions = TRUE, classProbs = TRUE)) 


#change sex to binary 
nfold = 3

train.dr = caret::train(x = dr.feat.mat, y = y2, method = "pls", preProcess = NULL, 
                        tuneLength = 10,
                        trControl = trainControl(method = "cv", number = nfold, 
                                                 savePredictions = TRUE, classProbs = TRUE))


##Error in check_dims(x = x, y = y) : nrow(x) == n is not TRUE


#set sex to a binary 
trainDat$sex[trainDat$sex=='female'] = 0
trainDat$sex[trainDat$sex=='male'] = 1
testDat$sex[testDat$sex=='female'] = 0
testDat$sex[testDat$sex=='male'] = 1
#set df as factors 
#trainDat = as.data.frame(factor(trainDat))
#testDat = as.data.frame(factor(testDat))
#trainDat = as.data.frame(trainDat)
#testDat = as.data.frame(trainDat)
################  train and test data      ##############
dim(trainDat)
predict = as.data.frame(trainDat[  , 1:18141])
outcome = trainDat$sex
#dim(trainDat)
#trainDat[,1]
#trainDat[1,18136:18141]


## training using CV 
nfold = 3


x = as.factor(predict[1:5,1:5])
x = as.data.frame(x)
x = droplevels(x)
######
typeof(x[1,1])
x = make.names(x)
x = as.factor(x)
x = model.matrix(x, )
typeof(tmpDat[1,1])
x = as.data.frame(as.factor(x))
x = scale(x, center = TRUE, scale = TRUE)
y = c(as.factor(tmpDat[,1]))
typeof(x[5,5])
##Error in check_dims(x = x, y = y) : nrow(x) == n is not TRUE

train.test1 = caret::train( x , x$V5, method = "pls", preProcess = NULL, 
                        tuneLength = 10,
                        trControl = trainControl(method = "cv", number = nfold, savePredictions = TRUE, classProbs = TRUE))


?make.names
####STOP

train.dr
plot(train.dr, ylab = "Accuracy (3-fold CV)", cex.lab = 1.5, cex.axis = 1.25)

train.al = caret::train(x = al.feat.mat, y = y2, method = "pls", preProcess = NULL, 
                        tuneLength = 10,
                        trControl = trainControl(method = "cv", number = nfold, savePredictions = TRUE, classProbs = TRUE))
train.al
plot(train.al, ylab = "Accuracy (3-fold CV)", cex.lab = 1.5, cex.axis = 1.25)




            
                                                                                                    
                                                                                                                                                                                                        
