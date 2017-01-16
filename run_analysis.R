# set the wd
setwd("C:/DataScience/Assignments/Data/UCI HAR Dataset")
# read files
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# merge dataset 'X'
x_all <- rbind(X_train, X_test)

# merge dataset 'y'
y_all <- rbind(y_train, y_test)

# merge dataset 'X'
subject_all <- rbind(subject_train, subject_test)

# read features file
features <- read.table("features.txt")

# use grep to get the coumn number of the features which contains 'std' or 'mean()'
features_mean_std <- grep("std|mean\\(\\)", features$V2)

# create a table with the features we want
x_extract <- x_all[,features_mean_std]

# set the column names
names(x_extract) <- features[features_mean_std, 2]

# read activity labels file
activity_labels <- read.table("activity_labels.txt")

y_all[,1] <- activity_labels[y_all[,1], 2]

names(y_all) <- "activity"


# set with descriptive variable names.


names(subject_all) <- "subject"

# bind data into a single data table
all_data <- cbind(x_extract, y_all, subject_all)


# tidy data set with the average of each variable for each activity and each subject.


library(plyr)

tidy <- ddply(.data = all_data, .variables = c("subject", "activity"), .fun = numcolwise(mean))

write.table(tidy, "tidy.txt", row.names = FALSE)