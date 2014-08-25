### GetData - Course Project

The purpose of the project is to demonstrate our ability to collect, clean and manipulate a complex dataset. The **Human Activity Recognition Using Smartphones Dataset (HAR)** was obtained from the **UCI Machine Learning Repository (UCI)** and utilized as the raw data.

In addition to this Readme.md, this repository contains:  
1. **run_analysis.R** - R script which takes the compressed UCI HAR dataset as input and outputs a tidy data table according to project guidelines (see Code Book for more details). My implementation makes use of the [plyr package](http://cran.r-project.org/web/packages/plyr/index.html) which may need to be installed.  
2. **CodeBook.md** - Code book containing information about the measurements, data and transformations  
3. **tidy.txt** - A space-delimited text file containing the output of run_analysis.R. Can be read into R using the read.table command.

**Note**: This repository does not contain the compressed UCI HAR Dataset zip file which can be obtained from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (59.7 Mb)

### run_analysis.R Overview

The following is a brief description of `run_analysis.R` which describes the steps I've implemented to generate the tidy dataset specified by the assignment guidelines. 

**Note**: Despite the extensive processing already performed on the UCI HAR Dataset, for the purposes of this assignment, **the downloaded UCI HAR zipfile will be treated as raw data**. 

##### Load Common/Metadata Files  
1. Unzip the compressed UCI HAR archive using `unzip`  
2. Load the common metadata files (activity_labels.txt and features.txt) into R dataframes  using `read.table`  
3. Create a character vector of 561 column names from features.txt for use in labeling x\_test.txt and x\_train.txt  

##### Load Test Dataset  
1. Load raw test data (y\_test, subject\_test, and x\_test) using `read.table` 
2. Create an Observation Index (integer vector of 1 to `NROWS`)  
3. Creates a temp dataframe by combining Observation.ID, y\_test, and subject\_test using `cbind`  
4. Merges activity_labels with temp using Activity.ID as the key using `merge` - this messes up the Observation.ID Order  
5. Re-sorts the temp dataframe by Observation Index using `arrange` in the plyr package 
6. Combines temp dataframe with x_test using `cbind` to generate the test dataset with human-readable activity and feature annotations  

##### Load Train Dataset and Combine Train and Merged
Repeat steps 1-6 listed above in the **Load Test Dataset** section for the train dataset. Then create a **'combined'** dataframe from the train and test datasets using `rbind`    

##### Extract only Measurement Mean and Standard Deviations
1. Subset 'combined' using `grepl` to match column names containing either "mean" or "std" - deliberately omitted "meanFreq"" observations as I'm unsure if these are calculated in the same way as "mean"   
2. Keep all metadata columns by including subject/activity/observation indices, and activity name in the subset  

##### Improve readability of Variable Names
Use `gsub` to enhance the human readability of column names  
- remove extra periods "." introduced by read.table  
- remove trailing periods "."  
- replace leading "t" with "time"  
- replace leading "f" with "freq"  
- replace leading "Acc" with "Accel"  

##### Generating Tidy Dataset Output
1. Remove Observation Index as it is no longer useful  
2. Use `ddply` and `colwise` in plyr to calculate mean across all measurement columns by activity and subject
3. Use `write.table` to generate a space-delimited text file containing the tidy dataset.