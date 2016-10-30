# README - cleaningdataproject.R

## ALL WORK BY VINCENT CHAN, ALL RIGHTS RESERVED
## DATASET BY UNIVERSITY OF CALIFORNIA, IRVINE AND ANY OTHER RESPECTIVE OWNERS

The cleaningdataproject.R script reads in data fro the UCI HAR dataset, combines the data into one table, and reduces the data to only those measurement types that include mean() and std() in their names. The script also adds a factor variable to indicate whether the data comes from the test dataset or the training dataset. The script then creates a second dataset that calculates the mean for each observation type by activity and human subject.

NOTE: FreqMean is excluded from these resultant datasets because the frequency is a different type of observation than the ones we’re interested in.

### Resultant datasets
combined — ‘combined’ gives us a wide table of observations, where each observation includes the human subject, activity, and all measurements related to that observation
combinedagg — ‘combinedagg’ gives us a tall table of mean values by measurement type, for each human subject x activity combination

### Other variables
* activity — key used to identify the activity type from the integer values assigned for activities in the dataset
* features — key used to name measurement type columns; this gives us the order of measurements in the x_tables
* interestind — the indices of the features and x_tables which relate to mean() and std() measurements
* subjtest — the dataset read from subject_test.txt indicating which human subject corresponds to each measurement in xtest
* subjtrain — the dataset read from subject_train.txt indicating which human subject corresponds to each measurement in xtrain
* testdata — combined dataset the test group
* traindata — combined dataset for the train group 
* xtest — the dataset read from X_test.txt reduced to only mean() and std() measurements
* xtrain — the dataset read from X_train.txt reduced to only mean() and std() measurements
* ytest — the dataset read from y_test.txt indicating which activity corresponds to each measurement in xtest
* ytrain — the dataset read from y_train.txt indicating which activity corresponds to each measurement in xtrain

### Working through the code
[2] Set the working directory to the folder in which all the dataset files reside. This location may vary based on user.
[5] Load the reshape2 package, as it is required to use the melt function later on.
[10] Read in the features table.
[13] Search the features table for the indices that contain mean() and std() in the measurement type name.
[16] Read in the activity labels table
[20] Read and store the measurements for the test group. The table is constrained to columns from interestind so that we only grab the measurements for measurement types that end in mean() or std(). Then, read the activity values and subject values for each observation. Repeat this for the train group.
[29] For the two y data frames, take the integer for each observation and replace it with the corresponding factors identifying the activity in words.
[34] Column bind the observations in the test dataset and the train dataset. This merges each line (observation) with its corresponding data from the other tables.
[38] Grab the names of the measurement types from features (using interestind), and apply those to the datasets. The first two columns are subject and activity identifiers, followed by the measurement types, followed by ‘group’, which identifies whether the observation is from the train group or the test group.
[45] Combine the two datasets into one dataset. Store it as ‘combined’
**RESULT 1:** *combined* is the dataset requested through step 4 of this project.
[49] Melt the dataset into a data frame that makes each measurement its own observation. This reduces our data to subject, activity, measurement type, and measurement value. This is less useful for identifying all the measurements for a given moment in time, but it helps us calculate the means below.
[54] Compute the mean for combinations of subject x activity x measurement type. This is stored in combinedagg.
**RESULT 2:** *combinedagg* is the dataset requested in step 5 of this project.
