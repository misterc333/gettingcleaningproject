## Codebook describing the variables, the data, and all transformations performed to clean up the data

# Data source: Human Activity Recognition Using Smartphones Data Set 
(see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Data accessed: March 29, 2020

# Information on the variables: 
- The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
- These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered 
  using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
- Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) 
  using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
- Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals 
  (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated 
  using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
- Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
  fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
  (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from each of these signals that were
produced in this dataset are: 
mean(): Mean value
std(): Standard deviation

Each of these features are normalized and bounded within the values of [-1,1]

Two additional variables provide information on the subject being tested ("subject")
and the type of activity of daily living being evaluated ("activity"):
- Subject: Numeric identifier of the subject who performed the activity. Its range is from 1 to 30.
- Activity: Factor variable with 6 levels: 
  1 WALKING
  2 WALKING_UPSTAIRS
  3 WALKING_DOWNSTAIRS
  4 SITTING
  5 STANDING
  6 LAYING 

# Process for producing tidy dataset from raw data:
1. Downloaded data from url provided and unzipped files into new data folder
2. For each of test and train datasets:
  - Added correct column names using list of features (features.txt)
  - Added subject ID and activity type through column binding of 
    subject and activity type files (e.g., subject_test.txt, y_test)
  - Assigned values to activity variable using activity labels (activity_labels.txt)  
3. Combined train data and test data with a row bind
4. Selected variables of interest for mean (incl. meanFreq()), standard deviation, subject, activity
  (using regular expressions to select out text in variable names)
5. Created data table of average values for each variable by subject and activity
  (using dplyr group_by and summarise_all)
6. Wrote file to disk using write.csv
