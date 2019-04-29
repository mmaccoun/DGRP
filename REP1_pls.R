####DGRP ANALYSIS
###Created 4/19/2019
###Updated: 4/28/2019

####PURPOSE: using only rep1 of all samples (ensures strains are unique in data)
####         see if PLS-DA model will be able to segregarte sex  of sample using 
##             transcriptome data


library(e1071)
library(caret)
setwd("~/Desktop/DGRP")
set.seed(100)
###CAN ALSO RANDOMIZE NOVEL GENOMES ENC 
dat  = read.csv("final.csv", header = T)
##set binary for sex 
##maybe unneccissary 

#################      partition data for testing and training      ##############
###only use rep 1 samples, remove irrel. data 
rep1_DAT = dat[!(dat$rep==2) , ] ##only use the rep 1 samples 
rep1_DAT = rep1_DAT[, 1 : 18142] #remove ID, strain, rep
rep1_DAT = rep1_DAT[-1, -1 ]
typeof(rep1_DAT)
dim(trainDat)
dim(rep1_Y)



#################      partition data for testing and training      ##############
##split rep 1 samples into train and test sets 

REP1_trainRows = createDataPartition(rep1_DAT$sex, p = 0.66, list = F)
REP1_trainDat = rep1_DAT[REP1_trainRows, ]
REP1_testDat = rep1_DAT[-REP1_trainRows, ]
REP1_testResults = REP1_testDat$sex
REP1_feat.mat = data.frame(apply(REP1_feat.mat, 2, function(x) as.numeric(x)))
REP1_testDat = data.frame(apply(REP1_testDat, 2, function(x) as.numeric(x)))
REP1_Y = REP1_trainDat$sex

#################      create feature matrix      ##############

REP1_Y = REP1_trainDat$sex
REP1_feat.mat = trainDat[!is.na(trainDat$sex), ]
#rep1.feat.mat = scale(rep1.feat.mat, center = TRUE, scale = TRUE)
REP1_feat.mat = as.data.frame(REP1_feat.mat)

#################      train model      ##############

nfold = 3
control = trainControl(method = "cv", number = nfold, 
                       savePredictions = TRUE, classProbs = TRUE)

REP1_feat.mat$sex = NULL
REP1_train = train(REP1_feat.mat, REP1_Y, method = "pls", preProcess = NULL, 
                        tuneLength = 10, 
                        trControl = control) 
REP1_train #view results 

#################      test model      ##############

REP1_testDat$sex = NULL
REP1_model = predict(REP1_train, newdata = REP1_testDat)
REP1_results = confusionMatrix(data = REP1_model, REP1_testResults)
REP1_results #see comments for output

#Confusion Matrix and Statistics

#Reference
#Prediction female male
#female     62    0
#male        0   62

#Accuracy : 1          
#95% CI : (0.9707, 1)
#No Information Rate : 0.5        
#P-Value [Acc > NIR] : < 2.2e-16  

#Kappa : 1          
#Mcnemar's Test P-Value : NA         
                                     
#            Sensitivity : 1.0        
#            Specificity : 1.0        
#         Pos Pred Value : 1.0        
#         Neg Pred Value : 1.0        
#             Prevalence : 0.5        
#         Detection Rate : 0.5        
#   Detection Prevalence : 0.5        
#      Balanced Accuracy : 1.0        
                                     
#       'Positive' Class : female  


