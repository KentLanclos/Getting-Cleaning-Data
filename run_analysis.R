library(plyr)

###############################################################################
# Step 1
# Merge the training and test data sets to create one data set
###############################################################################

x_train <- read.table("./Proj_Data/train/X_train.txt",header=FALSE)
x_test <- read.table("./Proj_Data/test/X_test.txt",header=FALSE)

y_train <- read.table("./Proj_Data/train/y_train.txt",header=FALSE)
y_test <- read.table("./Proj_Data/test/y_test.txt",header=FALSE)

subject_train <- read.table("./Proj_Data/train/subject_train.txt",header=FALSE)
subject_test <- read.table("./Proj_Data/test/subject_test.txt",header=FALSE)


# create 'y' data set
y_data <- rbind(y_train, y_test)
names(y_data) <- c("activity")

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)
names(subject_data) <- c("subject")

# create 'x' data set
features <- read.table("./Proj_Data/features.txt")
x_data <- rbind(x_train, x_test)
names(x_data)<- features$V2

combine_data <- cbind(x_data,cbind(subject_data,y_data))

###############################################################################
# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################

# get only columns with mean() or std() in their names
select_features <- features$V2[grep("-(mean|std)\\(\\)", features$V2)]
select_names <- c(as.character(select_features), "subject", "activity" )

# subset the desired columns
select_data <- subset(combine_data,select=select_names)

###############################################################################
# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

activity_labels <- read.table("./Proj_Data/activity_labels.txt",header=FALSE)

select_data$activity <- as.character(select_data$activity)
for (i in 1:6){
select_data$activity[select_data$activity == i] <- as.character(activity_labels[i,2])
}

select_data$activity <- as.factor(select_data$activity)

###############################################################################
# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

names(select_data)<-gsub("^t", "time", names(select_data))
names(select_data)<-gsub("^f", "frequency", names(select_data))
names(select_data)<-gsub("Acc", "Accelerometer", names(select_data))
names(select_data)<-gsub("Gyro", "Gyroscope", names(select_data))
names(select_data)<-gsub("Mag", "Magnitude", names(select_data))
names(select_data)<-gsub("BodyBody", "Body", names(select_data))

###############################################################################
# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################
second_data <- aggregate(. ~subject + activity, select_data, mean)
second_data <- second_data[order(second_data$subject,second_data$activity),]
write.table(second_data, file="second_data.txt",row.name=FALSE)