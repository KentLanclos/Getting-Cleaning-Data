# Getting-Cleaning-Data
Repo for Course 3 Peer Graded Project

The script run_analylsis.R performs the 5 steps listed below:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For Step 1, the relevant data are first read into appropriately named datasets (x, y, subject / train or test) reflecting the files from which the corresponding data is derived. The rbind() and names() commands are then used to row bind and name the train and test datasets for x and y, which are then merged via the cbind() command in the combine_data dataset.

In Step 2, the subset() command is used to select (extract) only the measurements corresponding to the mean and standard deviation, and stored in the select_data dataset.

In Step 3, a function is created to replace the integer values 1-6 for the activities with character labels. The as.factor() command then turns the labels into factors.

In Step 4, descriptive variable names are created, in particular by replacing "shorthand" with explicit names, e.g., 'Acc' is replaced by 'Accelerometer', etc.

Finally, in Step 5, a clean dataset (second.txt) is generated hat contains only the averages for each variable, and the write.table() command is used to create an external file with the corresponding values. This final dataset contains 180 rows corresponding to the measurements for each of the six activities for each of the 30 individuals. 
