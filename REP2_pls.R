####DGRP ANALYSIS
###Created 4/30/2019
###Updated: 4/30/2019

####PURPOSE: using only rep2 of all samples (ensures strains are unique in data)
####         see if PLS-DA model will be able to segregarte sex  of sample using 
##             transcriptome data


library(e1071)
library(caret)
setwd("~/Desktop/DGRP")
set.seed(100)
dat  = read.csv("final.csv", header = T)

#################      partition data for testing and training      ##############
###only use rep 1 samples, remove irrel. data 
rep2_DAT = dat[!(dat$rep==1) , ] ##only use the rep 1 samples 
rep2_DAT = rep2_DAT[, 1 : 18142] #remove ID, strain, rep
rep2_DAT = rep2_DAT[-1, -1 ]

#################      partition data for testing and training      ##############
##split rep 1 samples into train and test sets 

REP2_trainRows = createDataPartition(rep2_DAT$sex, p = 0.66, list = F)
REP2_trainDat = rep2_DAT[REP2_trainRows, ]
REP2_testDat = rep2_DAT[-REP2_trainRows, ]
REP2_testResults = REP2_testDat$sex
REP2_testDat = data.frame(apply(REP2_testDat, 2, function(x) as.numeric(x)))
REP2_Y = REP2_trainDat$sex

#################      create feature matrix      ##############

REP2_Y = REP2_trainDat$sex
REP2_feat.mat = REP2_trainDat[!is.na(REP2_trainDat$sex), ]
#rep1.feat.mat = scale(rep1.feat.mat, center = TRUE, scale = TRUE)
REP2_feat.mat = data.frame(apply(REP2_feat.mat, 2, function(x) as.numeric(x)))

#################      train model      ##############

nfold = 3
control = trainControl(method = "cv", number = nfold, 
                       savePredictions = TRUE, classProbs = TRUE)

REP2_feat.mat$sex = NULL
REP2_train = train(REP2_feat.mat, REP2_Y, method = "pls", preProcess = NULL, 
                   tuneLength = 10, 
                   trControl = control) 
REP2_train #view results 

#################      test model      ##############

REP2_testDat$sex = NULL
REP2_model = predict(REP2_train, newdata = REP2_testDat)
REP2_results = confusionMatrix(data = REP2_model, REP2_testResults)
REP2_results #see comments for output


#################      results      ##############

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



