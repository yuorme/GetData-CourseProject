## GetData - Course Project - Code Book

### UCI HAR Dataset
Version 1 of the **Human Activity Recognition Using Smartphones Dataset (HAR)** was obtained from the **UCI Machine Learning Repository (UCI)**. The UCI HAR dataset was submitted by a team from [Smartlab](https://sites.google.com/site/smartlabunige/home) at the University of Genoa in Italy. 

The experiments were carried out with **30 individuals** (19-48 years old) who performed **six different activities**. Measurements were made using the embedded accelerometer and gyroscope on a Samsung Galaxy S II smartphone worn by the individual while performing these activities. The total dataset contained 10,299 observations. This dataset was randomly partitioned into training and test datasets containing 21 and 9 individuals, respectively. 

The dataset uploaded to UCI was processed in a rich variety of ways to generate **561 features**. Briefly, the tri-axial (x,y,z) accelerometer and gyroscope measurements were noise-filtered and then sampled in partially-overlapping, fixed-width sliding windows. Acceleration signals were seperated into **Gravitational** and **Body Motion** componenents using a low-pass filter. **Jerk** signals were obtained using the body linear acceleration and angular velocity derived in time. Some of these signals were further processed with fast Fourier transforms to generate a **Frequency** signal.  Please refer to README.txt and features_info.txt from the UCI HAR Dataset and to the scientific paper [1] for more details. 

**Note**: Despite the extensive processing already performed on the UCI HAR Dataset, for the purposes of this assignment, **the downloaded UCI HAR zipfile will be treated as raw data**. The compressed UCI HAR Dataset zip file can be obtained from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (59.7 Mb)

Citations:  
1. [Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012](http://link.springer.com/chapter/10.1007%2F978-3-642-35395-6_30)

### Study Design

#### 


### Code Book
The UCI HAR dataset was downloaded from the course website. From the included documentation (features_info.txt), the actual raw data from the experiment has already been pre-processed to filter out noise and in some cases Fourier transformed. Subsequently,  measures, including the mean and standard deviation. However, for the purposes of this assignment, the UCI HAR dataset will be treated as raw data.

###
combining the test and train datasets creates duplicate Observation.IDs for 1:2947 (NROWS of the smaller test dataset)