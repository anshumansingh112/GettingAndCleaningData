Project : Getting and Cleaning Data

The data used in this project is from Human Activity Recognition Using Smartphones Dataset.

Following steps were followed in this project

1. Getting data from the specified source
 
          https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Viewing and understanding data

In this step various files were loaded and the dimensions and other attributes were checked using Dim, str and other functions.

3. Merging data

Data from the following files were merge to build the base data set

    test/subject_test.txt

    test/X_test.txt

    test/y_test.txt


    train/subject_train.txt

    train/X_train.txt

    train/y_train.txt
  
While merging data from the following files was also used 

    features.txt

    activity_labels.txt

4. Extracting subset of variables measuring mean and standard deviation
 
In this step relevant columns which had mean() or std() in their names were extracted out

5. Descriptive names for activities

In this step information from the activity_labels.txt was used to insert descriptive name for the activities

6. Descriptive names for variables

The names of the variables were transformed to provide more elaborate names. Some changes done were - Acc changed to acceleration, t and f changed to timedomain and frequencydomain respectively.

7. Creation of tidy data set

The data was then summarized on subject and activity and exported to tidy.txt

