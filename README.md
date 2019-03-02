# Data_Cleansing_R

Data Source : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Full Descriptions : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Code Work Flow :

1. Read the data first. The data is formated by txt file.
2. Labeled each variable based on feature.txt
3. Replace all the special character by empty character("") for each feature names using gsub function
4. Labeled the target variable based on activity_labels.txt
5. Adding the subject variable from each train and test dataset (subject_test.txt, subject_train.txt)
6. Merges the data set using rbind function (variable name : data)
7. Extract only future that contains mean and std using grep ( i extract one by one, need append to get all variable which contains mean and std
8. Group by multiple columns (subject and activity variable) using summarise function (dplyr library)
9. Write output table using write.table with col.names = TRUE, row.names = FALSE

# The output folder is on the same repositry (output.txt)

# Acknowledge :

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

[2] Coursera getting and cleaning data https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course	

