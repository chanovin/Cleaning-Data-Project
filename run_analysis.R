## set the correct working directory
## setwd("")
## load packages required:
## reshape2 required for 'melt'
library(reshape2)

## READ IN THE DATA

## read the table explaining what each column of data is
features <- read.table("features.txt")
## determine which features we want and store their index values
## these are features that include the terms "mean()" or "std()"
interestind <- grep("mean\\(\\)|std\\(\\)",features[,2])

## read the table explaining the activity labels
activity <- read.table("activity_labels.txt")

## read and store the txt files; keep only the columns in the x_tables that
## correspond to our terms of interest
xtest <- read.table("test/X_test.txt")[,interestind]
ytest <- read.table("test/y_test.txt")
subjtest <- read.table("test/subject_test.txt")
xtrain <- read.table("train/X_train.txt")[,interestind]
ytrain <- read.table("train/y_train.txt")
subjtrain <- read.table("train/subject_train.txt")

## DATA CLEANING - READABILITY

## convert activity labels into factors in ytest and ytrain
ytest <- activity[as.numeric(ytest[,1]),2]
ytrain <- activity[as.numeric(ytrain[,1]),2]

## combine the data into sets for the test data and train data
testdata <- cbind(subjtest,ytest,xtest,"test")
traindata <- cbind(subjtrain,ytrain,xtrain,"train")

## label the x_table columns using the 'features' dataframe
names(testdata) <- c("subject","activity",as.character(features[interestind,2]),"group")
names(traindata) <- c("subject","activity",as.character(features[interestind,2]),"group")

## DATA CLEANING - COMBINING & RESHAPING DATA

## combine the datasets
## !!this gives us the data required for step 4 in the assignment!!
combined<-rbind(testdata,traindata)

## melt the combined dataset into a tall shape
## with a variable for measurement type and a corresponding value variable
combinedmelt <- melt(combined,id=c("subject","activity"),
                     measure.vars=as.character(names(combined)[3:68]))
## use the aggregate function to compute means for each combination of
## measurement type, subject, and activity
## !!this gives us the data set required for step 5 in the assignment!!
combinedagg <- aggregate(value~subject+activity+variable,combinedmelt,mean)
## write the file as required
write.table(combinedagg,"combinedagg.txt",row.names=FALSE)