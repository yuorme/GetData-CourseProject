## GetData - Course Project - Code Book

### UCI HAR Dataset
Version 1 of the **Human Activity Recognition Using Smartphones Dataset (HAR)** was obtained from the **UCI Machine Learning Repository (UCI)**. The UCI HAR dataset was submitted by a team from [Smartlab](https://sites.google.com/site/smartlabunige/home) at the University of Genoa in Italy. 

The experiments were carried out with **30 individuals** (19-48 years old) who performed **six different activities**. Measurements were made using the embedded accelerometer and gyroscope on a Samsung Galaxy S II smartphone worn by the individual while performing these activities. The total dataset contained 10,299 observations. This dataset was randomly partitioned into training and test datasets containing 21 and 9 individuals, respectively. 

The dataset uploaded to UCI was processed in a rich variety of ways to generate **561 features**. Briefly, the tri-axial (x,y,z) accelerometer and gyroscope measurements were noise-filtered and then sampled in partially-overlapping, fixed-width sliding windows. Acceleration signals were seperated into **Gravitational** and **Body Motion** componenents using a low-pass filter. **Jerk** signals were obtained using the body linear acceleration and angular velocity derived in time. Some of these signals were further processed with fast Fourier transforms to generate a **Frequency** signal.  Please refer to README.txt and features_info.txt from the UCI HAR Dataset and to the scientific paper [1] for more details. 

**Note**: Despite the extensive processing already performed on the UCI HAR Dataset, for the purposes of this assignment, **the downloaded UCI HAR zipfile will be treated as raw data**. The compressed UCI HAR Dataset zip file can be obtained from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (59.7 Mb)

Citations:  
1. [Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012](http://link.springer.com/chapter/10.1007%2F978-3-642-35395-6_30)

### Study Design

A brief description of the steps implemented to generate the tidy dataset specified by the assignment guidelines:

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

### Code Book
