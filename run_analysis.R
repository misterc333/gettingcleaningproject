## Final project for getting and cleaning data course

# Download data in local folder
if(!file.exists("data")) {
  dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

adl <- download.file(fileUrl, "./data/adl.zip")

# list files in zip file
unzip("./data/adl.zip", list = TRUE)

# extract all
unzip("./data/adl.zip", "./data/adl.zip")

### 1. Test data formatting
# examine format of test data
test_raw <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
dim(test_raw) # structure is correct with 2947 rows and 561 columns

# add correct column names using list of features (features.txt)
features <- read.table("./data/UCI HAR Dataset/features.txt", 
                       stringsAsFactors = FALSE)
head(features) # feature names of interest in second column

test_clean <- test_raw
colnames(test_clean) <- features$V2
str(test_clean)

# add columns for subject ID and activity
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", 
                           stringsAsFactors = FALSE)
activity_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", 
                            stringsAsFactors = FALSE)

test_clean$subject <- subject_test$V1
test_clean$activity <- activity_test$V1

# assign values to activity using activity labels (activity_labels.txt)
act_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", 
                         stringsAsFactors = FALSE)
test_clean$activity <- factor(test_clean$activity, 
                              levels = act_labels$V1, labels = act_labels$V2)

### 2. Train data formatting  (same process as for test)
# examine format of train data
train_raw <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
dim(train_raw) # same structure as test: 7352 rows and 561 columns

# add correct column names using list of features (features.txt)
train_clean <- train_raw
colnames(train_clean) <- features$V2
str(train_clean)

# add columns for subject ID and activity
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", 
                            stringsAsFactors = FALSE)
activity_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", 
                             stringsAsFactors = FALSE)

train_clean$subject <- subject_train$V1
train_clean$activity <- activity_train$V1

# assign values to activity using activity labels (activity_labels.txt)
train_clean$activity <- factor(train_clean$activity, 
                               levels = act_labels$V1, labels = act_labels$V2)


### bind rows from train data to test data
complete_clean <- rbind(test_clean, train_clean)
str(complete_clean)

### select variables of interest: mean, std (incl. meanFreq()), subject, activity
# regular expression to select
table(grepl("mean()|std()", names(complete_clean))) #79 columns
grep("mean()|std()", names(complete_clean), value = TRUE)

complete_select <- complete_clean[ ,grepl("mean()|std()|subject|activity", 
                                          names(complete_clean))] 
str(complete_select)

### create data table of interest: 
### average for each variable by subject and activity
library(dplyr)
complete_avg <- complete_select %>% 
  group_by(subject, activity) %>% 
  summarise_all(list(avg = mean))
