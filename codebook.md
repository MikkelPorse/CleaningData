* Codebook.md
This file describes the contents of the tidy dataset produced by run_analysis.R

**Columns

Subject | The ID of the subject whose activity is measured, integer values between 1 and 30
Activity | The name of the activity measured, string value ("LAYING", "SITTING","STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS")

All subsequent columns take numeric values and contain the average of 30 measurements per subject per activity from the original dataset

TIME_* columns describe measurements in the time domain. In the original dataset these columns were prefixed with a 't'
FREQUENCY_* columns describe measurements in the frequency domain. In the original dataset these columns were prefixed with an 'f'

*_mean-columns signify that the column contains an average of averages.
*_std-columns signify that the column contains an average of standard deviations

Apart from the prefix and suffix, the features match up against the features of the original UIC HAR dataset, and the reader is referred to the description supplied here 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones