## R script called run_analysis.R for wearbale computing related to 
## Samsung Galaxy smart phones.

## Reading the data into R (Step1)
#################################################################
library(plyr)

X_train<-read.table("X_train.txt",sep="",header=FALSE)
X_test<-read.table("X_test.txt",sep="",header=FALSE)
y_test<-read.table("y_test.txt",sep="",header=FALSE)
y_train<-read.table("y_train.txt",sep="",header=FALSE)
subject_test<-read.table("subject_test.txt",sep="",header=FALSE)
subject_train<-read.table("subject_train.txt",sep="",header=FALSE)
features<-read.table("features.txt",sep="",header=FALSE)
activity<-read.table("activity_labels.txt",,sep="",header=FALSE)

#################################################################
## Merging the data of testing and training and creating one data set
##(Step2)

x_data<-rbind(X_test,X_train)
y_data<-rbind(y_test,y_train)
subject_data<-rbind(subject_test,subject_train)

#################################################################
## Extracting the data based on mean and standard deviation for each
## observations.(Step 3)

mean_sd_ftures <- grep("(mean|std)\\(\\)", features[, 2],ignore.case=T)
x_data <-x_data[, mean_sd_ftures]


#################################################################
##Use descriptive activity names to name the activities in the 
##data set (Step4)

names(x_data) <- features[mean_sd_ftures, 2]
y_data[, 1] <- activity[y_data[, 1], 2]
names(y_data) <- "Activity"
names(subject_data) <- "Subject"

#################################################################
##Creating a second, independent tidy data set with the
##average of each variable for each activity and each subject.(Step5)

Complete_data <- cbind(x_data, y_data, subject_data)
tidy <- ddply(Complete_data, .(Subject, Activity), function(x) colMeans(x[, 1:66]))
write.table(tidy, "tidy.txt", row.name=FALSE)
