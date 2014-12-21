Getting-and-Cleaning-Data---Project
===================================
Objective is to create a tidy data set that reflects the average of each variable, for each activity AND each subject.
This entails 4 steps, as outlined below:

STEP 1: MERGE THE TRAINING DATA SET AND THE TEST DATA SET INTO ONE DATA SET

a) Download the zipped folder into the working directory.

b) Read and combine the data sets within the zipped folder:
For the training data set, we should extract (ie unzip from the zipped folder) the subjects' IDs, the activities on which each subject trained for, and the variables measured for each of these activities. These are respectively reflected in the files	subject_train.txt, y_train.txt, and X_train.txt. Analogously, we can extract data from the test data set. In addition, we would want to extract the names of the variables, which are reflected in features.txt.

Then, I used rbind to merge X_train.txt and X_test.txt - this gives me the measurements on all variables, for both training subjects and test subjects (note: the subjects' IDs are not included here yet).

STEP 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION

To identify the "mean" and "std" deviations from the 561 variables, I used the grepl function to identify these strings within the variable names (reflected in the features.txt file). 66 variables were identified; "MeanFreq" was not considered.

Based on these variable names, I extracted the measurement data into a smaller data frame (with 10299 obs and 66 variables), and named it "CombinedData_extract".

STEP 3: LABEL DATA SET WITH DESCRIPTIVE VARIABLES NAMES

I replaced the row names of "CombinedData_extract" with the corresponding variable names as listed in features.txt.

STEP 4: CREATE A SECOND INDEPENDENT TIDY DATA SET, WITH THE AVERAGE OF EACH VARIABLE, FOR EACH ACTIVITY AND EACH SUBJECT.

3 data frames need to be bound together: CombinedData_extract, the Subjects' IDs, and the corresponding Activity. Thereafter, using the functions melt and dcast, we can compute the mean for each ID and each activity.
