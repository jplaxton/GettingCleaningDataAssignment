# Getting and Cleaning Data - Course Project
The code expects all the data is present in the current working folder, un-compressed and without names altered.

run_analysis.R contains the R-code to cleanup and build the tidy data set described in the 5 steps outlined in the assignment. The script may be executed in RStudio by sourcing the file.

The R-script `run_analysis.R` executes the following:

1. Load the data labels
2. Loads both the training and test datasets, and assigns data labels
3. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset
4. Merges the two datasets
5. Converts the `activity` and `subject` columns into factors
6. Subsets the merged data frame by searching for "mean" or "std"
7. Cleans up the column names of the final data file
8. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The final result is written to the file `tidy.txt`.

CodeBook.md describes the variables, the data, and any transformations or work that was performed to clean up the data.
