#####################
#### load common ####
#####################

# load required libraries
library(plyr)

# unzip the files
setwd("~/coursera/lectures/3-GettingCleaningData/CourseProject")
unzip("getdata-projectfiles-UCI HAR Dataset.zip", overwrite=FALSE)

# load common metadata
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                       col.names=c("Activity.ID", "Activity"))
features <- read.table("./UCI HAR Dataset/features.txt")

# extract column names from features dataframe
x_colnames <- features$V2 

##############################
#### loading test dataset ####
##############################

# load raw test data
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                     col.names="Activity.ID")
subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                        col.names="Subject.ID")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                     colClasses="numeric", 
                     col.names=x_colnames) # uses x_colnames from features.txt

# merge subject and activity files for the test dataset with activity annotations
Observation.ID <- 1:NROW(subj_test) #observation index
temp <- cbind(Observation.ID, subj_test, y_test)
temp2 <- merge(temp, activity) # merge re-arranges Observation ID order
temp2 <- arrange(temp2, Observation.ID) # sorts by Observation ID
test <- cbind(temp2, x_test) # appends x_test columns

# remove all temporary and/or unmerged dataframes
rm(temp, temp2, x_test, subj_test, y_test) 

###############################
#### loading train dataset ####
###############################

# load raw train data
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                     col.names="Activity.ID")
subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                        col.names="Subject.ID")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                     colClasses="numeric", 
                     col.names=x_colnames) # uses x_colnames from features.txt

# merge subject and activity files for the train dataset with activity annotations
Observation.ID <- 1:NROW(subj_train) #observation index
temp <- cbind(Observation.ID, subj_train, y_train)
temp2 <- merge(temp, activity) # merge re-arranges Observation ID order
temp2 <- arrange(temp2, Observation.ID) # sorts by Observation ID
train <- cbind(temp2, x_train) # appends x_train columns

# remove all temporary and/or unmerged dataframes
rm(temp, temp2, x_train, subj_train, y_train) 

#######################################
#### merge train and test datasets ####
#######################################

combined <- rbind(test, train)
rm(test, train, Observation.ID, x_colnames)

##########################################################
#### Extract mean and standard deviation measurements ####
##########################################################

# uses grepl to extract only columns containing mean and standard deviation
combined <- combined[(grepl(".mean(\\.+)", names(combined)) |   # purposely excludes 'meanFreq' measure
                      grepl(".std(\\.+)", names(combined)) |    
                      names(combined) == "Activity.ID" |
                      names(combined) == "Observation.ID" |
                      names(combined) == "Subject.ID" |
                      names(combined) == "Activity")] 

# make column titles more human readable
names(combined) <- gsub("(\\.+)", ".", names(combined)) # Removes excess periods
names(combined) <- gsub("(\\.+)$", "", names(combined)) # removes trailing periods
names(combined) <- gsub("^t", "time", names(combined)) # replace leading t with time
names(combined) <- gsub("^f", "freq", names(combined)) # replace leading f with freq - frequency
names(combined) <- gsub("Acc", "Accel", names(combined)) # compromise between Acc and Accelerometer which is too long

######################################################
#### average each measure by activity and subject ####
######################################################

# removes the Observation.ID column as it's no longer useful
combined$Observation.ID <- NULL

#uses ddply and colwise from the plyr package to generate summary dataframe with mean by activity and subject over all measurement columns
tidy <- ddply(combined, c("Activity.ID", "Activity", "Subject.ID"), colwise(mean))

#writes tidy dataframe to a space-delimited text file
write.table(tidy, file="tidy.txt", sep=" ", row.name=FALSE)