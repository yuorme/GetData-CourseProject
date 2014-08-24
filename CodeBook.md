## GetData - Course Project - Code Book



### Study Design

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

### Code Book

The tidy dataset contains 180 observations of 69 variables. A breakdown of this is as follows:  
- **Observations** - 30 subjects measured for 6 different activities  
- **Variables** - 3 metadata variables with 33 measurements of Mean and Standard Deviation respectively.  

####Variable Information  

#####Metadata 

1. "Activity.ID" - integer index corresponding to the descriptive activity name (range: 1 to 6)  
2. "Activity" - factor with 6 levels ("WALKING", "WALKING\_UPSTAIRS", "WALKING\_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")  
3. "Subject.ID" - integer index corresponding to the subject (range: 1 to 30)  

#####Measurement Variables  
See the following appendix for further details documenting the meaning of each of the following measures. All features have been normalized and are bounded between -1 and 1.

**Abbreviations**   
**std** - standard deviation  
**.X .Y .Z** - Denotes tri-axial signals in the X, Y and Z directions.  
**Gyro** - gyroscope measurements  
**Accel** - accelerometer measurements  
**Mag** - magnitude  

4. "timeBodyAccel.mean.X"         
5. "timeBodyAccel.mean.Y"         
6. "timeBodyAccel.mean.Z"         
7. "timeBodyAccel.std.X"          
8. "timeBodyAccel.std.Y"          
9. "timeBodyAccel.std.Z"          
10. "timeGravityAccel.mean.X"      
11. "timeGravityAccel.mean.Y"      
12. "timeGravityAccel.mean.Z"      
13. "timeGravityAccel.std.X"       
14. "timeGravityAccel.std.Y"       
15. "timeGravityAccel.std.Z"       
16. "timeBodyAccelJerk.mean.X"     
17. "timeBodyAccelJerk.mean.Y"     
18. "timeBodyAccelJerk.mean.Z"     
19. "timeBodyAccelJerk.std.X"      
20. "timeBodyAccelJerk.std.Y"      
21. "timeBodyAccelJerk.std.Z"      
22. "timeBodyGyro.mean.X"          
23. "timeBodyGyro.mean.Y"          
24. "timeBodyGyro.mean.Z"          
25. "timeBodyGyro.std.X"           
26. "timeBodyGyro.std.Y"           
27. "timeBodyGyro.std.Z"           
28. "timeBodyGyroJerk.mean.X"      
29. "timeBodyGyroJerk.mean.Y"      
30. "timeBodyGyroJerk.mean.Z"      
31. "timeBodyGyroJerk.std.X"       
32. "timeBodyGyroJerk.std.Y"       
33. "timeBodyGyroJerk.std.Z"       
34. "timeBodyAccelMag.mean"        
35. "timeBodyAccelMag.std"         
36. "timeGravityAccelMag.mean"     
37. "timeGravityAccelMag.std"      
38. "timeBodyAccelJerkMag.mean"    
39. "timeBodyAccelJerkMag.std"     
40. "timeBodyGyroMag.mean"         
41. "timeBodyGyroMag.std"          
42. "timeBodyGyroJerkMag.mean"     
43. "timeBodyGyroJerkMag.std"      
44. "freqBodyAccel.mean.X"         
45. "freqBodyAccel.mean.Y"         
46. "freqBodyAccel.mean.Z"         
47. "freqBodyAccel.std.X"          
48. "freqBodyAccel.std.Y"          
49. "freqBodyAccel.std.Z"          
50. "freqBodyAccelJerk.mean.X"     
51. "freqBodyAccelJerk.mean.Y"     
52. "freqBodyAccelJerk.mean.Z"     
53. "freqBodyAccelJerk.std.X"      
54. "freqBodyAccelJerk.std.Y"      
55. "freqBodyAccelJerk.std.Z"      
56. "freqBodyGyro.mean.X"          
57. "freqBodyGyro.mean.Y"          
58. "freqBodyGyro.mean.Z"          
59. "freqBodyGyro.std.X"           
60. "freqBodyGyro.std.Y"           
61. "freqBodyGyro.std.Z"           
62. "freqBodyAccelMag.mean"        
63. "freqBodyAccelMag.std"         
64. "freqBodyBodyAccelJerkMag.mean"
65. "freqBodyBodyAccelJerkMag.std" 
66. "freqBodyBodyGyroMag.mean"     
67. "freqBodyBodyGyroMag.std"      
68. "freqBodyBodyGyroJerkMag.mean" 
69. "freqBodyBodyGyroJerkMag.std"

### Appendix: UCI HAR Dataset Information

Version 1 of the **Human Activity Recognition Using Smartphones Dataset (HAR)** was obtained from the **UCI Machine Learning Repository (UCI)**. The UCI HAR dataset was submitted by a team from [Smartlab](https://sites.google.com/site/smartlabunige/home) at the University of Genoa in Italy. 

The experiments were carried out with **30 individuals** (19-48 years old) who performed **six different activities**. Measurements were made using the embedded accelerometer and gyroscope on a Samsung Galaxy S II smartphone worn by the individual while performing these activities. The total dataset contained 10,299 observations. This dataset was randomly partitioned into training and test datasets containing 21 and 9 individuals, respectively. 

The dataset uploaded to UCI was processed in a rich variety of ways to generate **561 features**. Briefly, the tri-axial (x,y,z) accelerometer and gyroscope measurements were noise-filtered and then sampled in partially-overlapping, fixed-width sliding windows. Acceleration signals were seperated into **Gravitational** and **Body Motion** componenents using a low-pass filter. **Jerk** signals were obtained using the body linear acceleration and angular velocity derived in time. Some of these signals were further processed with fast Fourier transforms to generate a **Frequency** signal.  Please refer to README.txt and features_info.txt from the UCI HAR Dataset and to the scientific paper [1] for more details. 

The compressed UCI HAR Dataset zip file can be obtained from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (59.7 Mb)

Citations:  
1. [Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012](http://link.springer.com/chapter/10.1007%2F978-3-642-35395-6_30)