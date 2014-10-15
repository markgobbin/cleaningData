#Code book
This data set contains measurements of accelerometer and gyroscope 3-axial raw signals

The first two columns are "Subject" and "Activity". The subject is a participant in the study numbered 1 to 30. The activity is a label specifying whether someone was walking, standing, sitting, etc.

All the columns after those two are the means taken of means and standard deviations of the following accelerometer data features:

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

Note that I have decided that entries like "angle(Z,gravityMean)" should not be included. It seems irrelevant because it is an angle variable, and doesn't include standard deviation as specified in the assignment. Also I intentionally did not include entries like "fBodyAccJerk-meanFreq()-Y" because the meanFreq doesn't include standard deviation and is a separate measurement. Only entries with literally "mean()" or "std()" are included.

In my approach I have put the tables together and named the columns first, and only then did I extract the mean and std columns.

After this I used melt from the package reshape2, and dcast the data using the formula Subject+Activity~Feature.