Programming Assignment for Getting and Cleaning Data Course<br>
Data Science Specialisation by John Hopkins University<br>
by Chan Chee-Foong on 24 Mar 2016<br>

## Assignment Summary
The goal is to prepare tidy data that can be used for later analysis.  We are required to submit: <br>
1) a tidy data set (the average of each variable for each activity and each subject) from the raw data set downloaded<br>
2) a link to a Github repository with the script for performing the analysis<br>
3) a code book called CodeBook.md that describes the variables, the data, and any transformations or work that was performed to clean up the data.<br>
4) a README.md in the repo with the scripts to explains how all of the scripts work and how they are connected.


## Data
For data, please refer to the CodeBook.md.  The document explains where the raw data was downloaded, observations made on the raw data and also how the raw data was prepared into a tidy data set for further analysis.

## R Programming Script
This assignment only contains one R script called <B>run_analysis.R</B>.  Comments are included in the script to explain the process and flow of cleaning up and preparing the tidy data set.  Included in the script are also the steps to analyse the tidy data set and return the average of each variable for each activity and each subject into a output file (tidy.csv) as required by the assignment.

## Output
Refer to the comma delimited file name <B>tidy.csv</B> in this repository.

### Special Notes
As part of the pre and post data cleaning and analysis process, sanity checks are done on the R console to ensure that the raw data are correctly understood and that the final tidy data make sense.  Some sanity checks done are:<br><br>
1. Count and ensure the number of variables in the <B>feature.txt</B> is the same as the number of columns in the training and test data set. Number should be 561.<br>
2. Count and ensure the number of labels in <B>activity_labels.txt</B> tallies with information indicated in the README.txt inside the downloaded data set.  Number should be 6.<br>
3. Count and ensure the number of labels in <B>train/y_train.txt</B> and <B>test/y_test.txt</B> tallies with the number of test records in the training and test data set respectively.<br>
4. Count and ensure the number of labels in <B>train/subject_train.txt</B> and <B>test/subject_test.txt</B> tallies with the number of test records in the training and test data set respectively.<br>
5. Count the unique number of activity labels in <B>train/y_train.txt</B> and <B>test/y_test.txt</B>. Number should be 6.<br>
6. Count the unique number of subject labels in <B>train/subject_train.txt</B> and <B>test/subject_test.txt</B>.  Number should be 30.<br>
7. Count and ensure the number of variables in the required variable list with mean() and std().  Number should be 66.<br>
8. Count and ensure the number of records in the final tidy data set for extraction into tidy.csv.  Number should be 180 (30 subjects x 6 activites).  Number of variables should be 66.  Number of columns should be 68 (66 + subject and activity) <br>


