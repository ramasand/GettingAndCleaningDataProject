GettingAndCleaningDataProject
=============================
1.Merges the training and the test sets to create one data set.

*reads test/x_test and train/x_train data from the working directory 

*merges tham.


2.Extracts only the measurements on the mean and standard deviation for each measurement.

*reads the features names

*checks if the  names include "std" or "mean"

*subsets only the data describes "std" or "mean".


3.Uses descriptive activity names to name the activities in the data set

*reads the labels for test and train 

*the function changes the activity names from numeric factors to discraptive factors

*add "label" variable with the acctivities to the subseted data


4.Appropriately labels the data set with descriptive variable names.

*gives more descreptive variable names


5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

*reads the subject names for the train and the test data.

*merges the subject names to the data frame from step 4.

*puts all the mesured lebels in one row and there meserments in anather row called "count"

*calculate the means for each subject at each activity lebel at each mesure label

*write the averrage table in a text file.


CODE BOOK

"label"- Activity labels (walking, walking up, walking down, sitting, and laying)

"subject" - The subject id number

"labels" -The mesures description (g.e. timeBodyAccMean-X, timeBodyStd-S, etc.)

"mean"- The mean of the meserment for spesific subject at spesific activity.
