Preamble -Introduction:-

The objective of the project is to :-
1. Create one R script called run_analysis.R that does the following. 
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each         measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names. 
6. From the data set in step 4, creates a second, independent tidy data set with the     average of each variable for each activity and each subject.

The purpose of this exercise is to collect, work with, and clean a data set. The objective is to create a clean data set that can be used later for analysis.

The experiment:-
This experiment was performed on the 30 persons aged between 19 to 40. These 30 persons have been numbered 1 to 30 and have been referred as volunteer/subject. Each person was asked to wear smartphone (Samsung Galaxy S II) on their waist.  Each volunteer was asked to perform six activities >>WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

Using smartphone's embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity was captured. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% for the test data. (Some of the technicalities not relevant to the project are ommitted).

The dataset includes the following :-


- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

(the subject data is not specified in README.txt but is provided)

Note:- Based on the discussions on the Coursera discussion forums data on Inertial signals has not been considered for the purpose of average.

Disclaimer:- "grep" function used in the code is considered based on the suggestions given in the Coursera discussion forum.

 Code script details :-

The script run_analysis.R performs the 5 steps described in the course project's definition.

1. Create one R script called run_analysis.R and merge the testing and training data sets:- 


We have to create one R script which we have done called run_analysis.R , and the same is in R. As referred above we have been asked to merge training and testing data.

We have been provided 2 sets of data sets :-

testing data set:-
X_test.txt
y_test.txt
subject_test.txt
Files on interial signals


training data set:-
X_train.txt
y_train.txt
subject_train.txt
Files on interial signals

(The data has been eyeballed on sublime text editior)
 The testing and the training data 3 files each as referred above is read into R by read.table command. 

X_test- 2947 observations of 561 variables.
 y_test- 2947 observations of 1 variable.
subject_test-2947 observations of 1 variable.

X_test- 7352 observations of 561 variables.
 y_test- 7352 observations of 1 variable.
subject_test-7352 observations of 1 variable.




2. Merges the training and the test sets to create one data set.

We have used the rbind command to merge and create one data set of the test and train data.

3. Extracts only the measurements on the mean and standard deviation for each         measurement. 

We have used the grep command for extracting the measurement out of features table. it has the following syntax(sample)

gp<-grep("(mean| sd)", features[,2], ignore.case = T, perl = FALSE, value = FALSE,
+          fixed = FALSE, useBytes = FALSE, invert = FALSE).

Here we match character "mean or sd" in character vector features[,2]. Value=FALSE returns index where "mean or sd" as characters are present.
We then subset the integrated data set (x_data)  based on mean or sd  vector index set returned by grep function.

Based on the coursera discussion board we are only considering 66 values returned by grep function and stored in vector . The 20 values relating to frequency mean (fBodyAcc-meanFreq()-X" "fBodyAcc-meanFreq()-Y" "fBodyAcc-meanFreq()-Z" values etc) are ignored for computing the average.

4. Uses descriptive activity names to name the activities in the data set.

We convert the activities as specified in the y_data ( the merged y test and train data set) from numeric to names.We apply the activity names to the first column of the y_data, as specified in the second column of the activity table.


5. Appropriately labels the data set with descriptive variable names.

We use the name function to name the columns of the data set (x_data). The indices returned by grep are used to shortlist the names in features and the same are applied as column names to the data set.

We rename the columns of the y_data (with name as "Activity") and the subject_data (with name as "Subject") using the name function respectively. 




6. From the data set in step 4, creates a second, independent tidy data set with the     average of each variable for each activity and each subject.

For the final computation of average , we first create one complete data set (Complete data). It has 68 columns- 66 columns against mean and standard deviation variables (as returned by grep function) and subject and activity columns. It has 10299 observations which is the sum of  the observations of the X_test and X_train data set.

Finally we use ddply function of plyr package to find out for each subject and for each of the 6 activities of the subject average values. 

It has the following syntax:-

ddply(.data, .variables, .fun = NULL, ..., .progress = "none",
  .inform = FALSE, .drop = TRUE, .parallel = FALSE, .paropts = NULL)

Here we provide Complete_data as data , and assign subject and activity as variables. We then for function (x)) calculate the column means for each subject and activity.

As is possible the tidy data set has 68 variables as referred above and 180 observations- 30 volunteers and 6 activities per volunteer.

Since the total number of oberservations is 10299 for 30 volunteers and 6 activities per volunteer there shall be app. 57 observations per activity per volunteer. So we are basically taking the average of these 57 observations(for e.g and understanding).


