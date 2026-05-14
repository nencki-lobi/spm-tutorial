# Introduction to Functional Imaging of the Human Brain
## Hands-on session with SPM - statistical data analysis

**Małgorzata Wierzba, PhD** (m.wierzba@nencki.edu.pl)
<br>Laboratory of Emotions Neurobiology
<br>Center of Excellence for Neural Plasticity and Brain Disorders BRAINCITY
<br>Nencki Institute of Experimental Biology, Polish Academy of Sciences

## Setup

1. Copy the `demo-ds005460-with-derivatives` directory from the shared materials to your local machine. 
	- It is a subset of the original dataset, containing data from three subjects: `sub-0312f`, `sub-1512e`, and `sub-2811d`.
	- However, besides raw data, it now also contains preprocessed data in the `derivatives/fmriprep` subdirectory.

```
.
├── dataset_description.json
├── derivatives
│   └── fmriprep
│       ├── sub-0312f
│       │   └── func
│       │       ├── sub-0312f_task-cet_desc-confounds_timeseries.json
│       │       ├── sub-0312f_task-cet_desc-confounds_timeseries.tsv
│       │       ├── sub-0312f_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.json
│       │       └── sub-0312f_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz
│       ├── sub-1512e
│       │   └── func
│       │       ├── sub-1512e_task-cet_desc-confounds_timeseries.json
│       │       ├── sub-1512e_task-cet_desc-confounds_timeseries.tsv
│       │       ├── sub-1512e_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.json
│       │       └── sub-1512e_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz
│       └── sub-2811d
│           └── func
│               ├── sub-2811d_task-cet_desc-confounds_timeseries.json
│               ├── sub-2811d_task-cet_desc-confounds_timeseries.tsv
│               ├── sub-2811d_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.json
│               └── sub-2811d_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz
├── participants.json
├── participants.tsv
├── sub-0312f
│   ├── anat
│   └── func
├── sub-1512e
│   ├── anat
│   └── func
├── sub-2811d
│   ├── anat
│   └── func
└── task-cet_events.json
```

2. Open MATLAB and navigate to the `demo-ds005460-with-derivatives` directory (the one you just created on your machine).

3. Start SPM by typing:

```
spm fmri
```

## Wait, what just happened?!

In the CLIMATE BRAIN dataset, data preprocessing was performed using [fMRIPrep](https://fmriprep.org) rather than SPM. While the general logic is similar, there are some differences between these software packages.

- One important difference is that they use different naming conventions for the output files. In particular, fMRIPrep follows the so called [Brain Imaging Data Structure (BIDS)](https://bids.neuroimaging.io) format.
- BIDS is a common standard for naming files and directories. For instance:
	- Raw data are located in the root directory of the dataset, while derived data are stored in the `derivatives` subdirectory. In particular, `derivatives/fmriprep` contains fMRIPrep output *derived* from the raw data.
	- Data for each subject are placed in subdirectories named `sub-<label>`, where string `<label>` is substituted with the unique identifier of each subject, e.g. `sub-0312f`, `sub-1512e`, `sub-2811d`.
	- `anat` contains anatomical data, while `func` contains functional data.
	- ... and so on! (for the full BIDS specification, go [here](https://bids-specification.readthedocs.io))
- Such consistent way to organize neuroimaging datasets makes it easy to understand and share data across research groups and institutions.
- This is why BIDS is now widely adopted by the scientific community, and making your data BIDS-compliant is sometimes even a requirement. For instance, [OpenNeuro](https://openneuro.org) allows users to host neuroimaging data for free, as long as it is BIDS-formatted.

1. Navigate to the `demo-ds005460-with-derivatives` directory. The files that you see in the `derivatives/fmriprep` are selected fMRIPrep outputs.
	- These files are both sufficient and necessary to proceed with the statistical analysis of fMRI data.
	- All intermediate and auxiliary files have been removed.
2. All files are organized according to BIDS. 
	- Look at the name of this file: `sub-1512e_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz`.
	- Try to guess what it is just by looking at its name and its location in the directory structure.

## Let's start!

We will start by performing the subject-level analysis (i.e., *first-level analysis*) separately for each subject. We will start with `sub-1512e` and then follow by processing the remaining subjects' data. If we have time, we will proceed to the group-level analysis (i.e., *second-level analysis*).

### But before we start...

Some important things to keep in mind about fMRIPrep:

- All NIfTI images produced by fMRIPrep are compressed (i.e., `.nii.gz` format).
- By default, fMRIPrep does not perform smoothing because some analyses require unsmoothed data.
- fMRIPrep stores head-motion parameters (translations and rotations) in a large TSV file together with other confounds.

Therefore, there is still some preprocessing left to do before we can move on to the statistical analysis. This will be covered in the following sections, so be patient!

## Unpacking the data

**IMPORTANT:** All NIfTI images produced by fMRIPrep are compressed (i.e., `.nii.gz` format).

Since SPM can only work with uncompressed NIFTI, we need to unzip them first.

1. Use the `Batch` button, then select `BasicIO > File Operations > Gunzip Files`
2. Click on the `File Set`, then `Specify`.
3. Navigate to `derivatives/fmriprep/sub-1512e`. From `func` select the preprocessed functional image `sub-1512e_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz`. When you're ready, click `Done`.
4. Click the green "play" button to run this step!
5. Navigate to your files to check whether the `.nii.gz` file was successfully uncompressed into a `.nii` file.
6. Save your batch (if needed) and close it.

## Smoothing

**IMPORTANT:** By default, fMRIPrep does not perform smoothing because some analyses require unsmoothed data.

The type of analysis we are planning to perform requires that the data be smoothed.

1. Use the `Smooth` button.
2. Click on the `Images to smooth`, then navigate to the `derivatives/fmriprep/sub-1512e/func` subdirectory.
3. **Important**: Make sure to select all the preprocessed funtional images! Click on the `Frames` field, replace `1` with `Inf`, the press the `Enter` key.
4. Now, right-click on the right pane and from the context menu select `Select All`. You should see 385 files added. If you're ready, click `Done`.
5. Change the `FWHM` field to `6 6 6`.
6. Click the green "play" button to run this step!
7. Navigate to your files to check if the smoothing was sucessful. You will recognize the resulting output file by the `s` prefix.
8. Save your batch (if needed) and close it.

## Extracting head motion parameters

**IMPORTANT:** fMRIPrep stores head-motion parameters (translations and rotations) in a large TSV file together with other confounds.

For our analysis, we will only need six motion parameters, formatted in a way that SPM can use (i.e., a `.txt` file without a header).

1. fMRIPrep stores head-motion parameters in the `sub-1512e_task-cet_desc-confounds_timeseries.tsv` file. Open this file in any text editor and try to locate the six motion parameters. Can you recognize them by name?
2. Close SPM for now.
3. In MATLAB, navigate to the root directory of your dataset, e.g. `demo-ds005460-with-derivatives`.
4. In MATLAB, click `New Script`, then copy and paste the following code snippet:

```
subjects = {'sub-0312f', 'sub-1512e', 'sub-2811d'};

for s = 1:3
	sub = subjects{s};

	input = fullfile('./derivatives/fmriprep', sub, 'func', [sub, '_task-cet_desc-confounds_timeseries.tsv']);
	output = fullfile('./derivatives/fmriprep', sub, "func", [sub, '_motion_parameters.txt']);

	T = readtable(input, "FileType", "text", "Delimiter", "\t");
	cols = ["trans_x", "trans_y", "trans_z", "rot_x", "rot_y", "rot_z"];
	writematrix(T{:,cols}, output, "Delimiter", "tab");
end
```

5. Give it a name (e.g., `extract_motion_parameters.m`) and save it in your user-specific `MATLAB` directory. You should be able to find this directory in your home directory, it will look like this: `~/Documents/MATLAB`.
6. Run the script!
7. Navigate to your files to see if the `sub-1512e_motion_parameters.txt` file was indeed created. It will be in the `derivatives/fmriprep/sub-1512e/func` subdirectory.
8. In fact, the script extracted motion parameters for all three subjects. You can verify that the motion parameter files were created in the other subjects’ directories as well.
9. Clear MATLAB workspace, before going back to SPM. To do that, type this in the MATLAB console:

```
clear all
```

9. Go back to SPM:

```
spm fmri
```

## First-level analysis

We are almost ready to start the first-level analysis.

### But before we start...

Before we can start fMRI data analysis, we need to know the experimental task that was performed in the scanner. In particular:

- What conditions (experimental, control) was the subject exposed to while performing the task?
- For each condition, we need to know exactly:
	- When it occurred (onsets)?
	- How long it lasted (durations)?

Here, we will analyse data from the **Carbon Emission Task (CET)**, which involves participants making a series of decisions between receiving a monetary bonus (a self-interest choice) and retiring carbon emission certificates (a climate-friendly choice).

1. Go to the [CLIMATE BRAIN publication](https://www.nature.com/articles/s41597-025-05038-0) and read the description of the CET task. Make sure to take a look at `Figure 3`. This will help you understand the difference between "CET" (experimental condition) and "dummy" (control condition).
2. Navigate to your files and in the raw data look for the `sub-1512e_task-cet_events.tsv` file.
	- The file will be located in the `demo-ds005460-with-derivatives/sub-1512e/func` subdirectory.
	- Open this file in any text editor.
3. As you can see from the contents of this file, all trials can generally be divided into `CET` and `dummy`.
4. Note that the `onset` and `duration` columns provide information about the onset and duration of each trial, respectively (in seconds).	
	- Onsets for the `CET` trials are:
	```
	5.7918
	20.8334
	51.1668
	66.9674
	83.2502
	99.5425
	130.6259
	147.4176
	162.9592
	193.0510
	208.3343
	224.8760
	256.7088
	273.0094
	306.5838
	322.8761
	338.1678
	354.7095
	387.7924
	403.3346
	418.8763
	451.9591
	467.2514
	498.3342
	514.8764
	530.6765
	546.4682
	578.3099
	593.3432
	609.8848
	640.7183
	657.5100
	689.8428
	705.1434
	736.9851
	753.7768
	```
	- Onsets for the `dummy` trials are:
	```
	36.1257
	114.5836
	178.0009
	240.9177
	290.0422
	371.7596
	435.1674
	483.2931
	561.5098
	625.6761
	674.3011
	721.4434
	```
	- Both `CET` and `dummy` trials have a duration of `10` seconds.

Now, we can finally start the first-level analysis!

### Model specification

1. Use the `Specify 1st-level` button.
2. Click on `Directory`.
	- Here, we need to provide the directory where we want SPM to save the first-level results.
	- Navigate to your files. Inside the `derivatives` directory, create a new `results` subdirectory, and within this directory, create a subject-specific folder named `sub-1512e`.
	- The same can be achived by running this command in the MATLAB console:
	```
	mkdir derivatives/results/sub-1512e
	```
	- At the end, your directory structure should look like this: `demo-ds005460-with-derivatives/derivatives/results/sub-1512e`.
	- Go back to SPM and select this newly created directory.
3. Specify `Units for design` as `Seconds`.
4. Specify `Interscan interval` as `2`.
	- This refers to the repetition time (TR), which is the time required to acquire a single functional volume.
	- In our case, the TR is 2 seconds. You can verify this information in the `sub-1512e_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.json` file, by opening it in any text editor.
5. Click on `Data & Design`, then `New: Subject/Session`.
6. Click on `Scans`, then `Specify`, then navigate to the `derivatives/fmriprep/sub-1512e/func` subdirectory.
7. **Important**: Make sure to select all the smoothed funtional images! Click on the `Filter` field and change it to `ss.*`. Then click on the `Frames` field, replace `1` with `Inf`, then press the `Enter` key.
8. Now, right-click on the right pane and from the context menu select `Select All`. You should see 385 files added. If you're ready, click `Done`.
9. Click on `Conditions`:
	- Here we need to specify any conditions (experimental, control) that the subject was exposed to while performing the task.
	- As discussed above, we have two conditions (`CET` and `dummy`). Therefore we click `New: Condition` twice.
	- For each condition, specify `Name`, `Onsets`, and `Durations`. If in doubt, refer to the "But before we start..." section above.
10. Click on `Multiple regressors`, then `Specify`. Navigate to `derivatives/fmriprep/sub-1512e/func` subdirectory and select the `sub-1512e_motion_parameters.txt` file, containing motion parameters.
11. Click the green "play" button to run this step!
12. Take a look at the output and review your experimental design! Do you know what different columns correspond to? Is this a block design or an event-related design?
13. Save your batch, but **don't close it** this time!

### Model estimation

1. While in the batch editor, select `SPM > Stats > Model estimation`.
2. Click on `Model estimation`, then `Select SPM.mat` and this time `Dependency` instead of `Specify`.
3. Choose the only available option on the list, `fMRI model specification`.
4. Click the green "play" button to run **both steps**!
	- SPM will issue a warning and ask if you want to overwrite the existing model. Confirm by clicking `Continue` (we do this only for educational purposes).
5. Save changes to your batch, but **don't close it** this time!

### Contrast definition

1. While in the batch editor, select `SPM > Stats > Contrast Manager`.
2. Click on `Contrast Manager`, then `Select SPM.mat` and this time `Dependency` instead of `Specify`.
3. From the list of available dependencies, choose `Model estimation`.
4. Click on `Contrast Sessions` and then `New: T-contrast`.
	- Specify `Name` as `CET vs dummy`.
	- Specify `Weights vector` as `[1 -1]`.
5. Click on `Contrast Sessions` again and then `New: T-contrast`
	- Specify `Name` as `dummy vs CET`.
	- Specify `Weights vector` as `[-1 1]`.
6. Change `Delete existing contrasts` to `Yes`.
7. Click the green "play" button to run **all steps**!
	- SPM will issue a warning again, proceed by clicking `Continue` (we do this only for educational purposes).
8. Save changes to your batch and close it. :)

### Viewing and thresholding results

1. In the main SPM menu, use the `Results` button and navigate to the SPM model you have just created, i.e. `derivatives/results/sub-1512e/SPM.mat`.
2. Select the contrast you'd like to view, e.g. `CET vs dummy`, then click `Done`.
3. Don't apply any masking.
4. For your p value adjustment choose `FWE`, then confirm that you want to use the threshold of `0.05`.
5. Repeat steps 1-3, but this time choose `none` instead of `FWE`. Also, use the threshold of `0.001` and extent threshold of `0`.
6. What do you see?
	- Are the results the same or different from what you see in the [CLIMATE BRAIN publication](https://www.nature.com/articles/s41597-025-05038-0)?
	- Try to navigate to coordinates `x = -6`, `y = 26` and `z = 37`, just to make sure.
	- Discuss your ideas with the tutor.

### Results table

The results table provides cluster-level and peak-level statistics.

1. Take a closer look at the results table.
	- For each cluster, it provides the cluster size (`kE`) and p-values, adjusted using different methods.
	- For each cluster, it shows 3 local peaks, that are more than 8 mm apart.
	- For each peak, it provides the T statistics and p-values, adjusted using different methods.
	- Also, for each peak it gives you the `[x, y, z]` coordinates, i.e. its location in the MNI space.

### Atlas labeling

You can also view the results in a graphical form, overlaid on a brain template.

1. While in SPM's `Results` window, use the  `Overlays` selector.
2. Select `Sections`, then use the `Prev` path selector to navigate to `spm25/canonical` subdirectory.
3. Choose `single_subj_T1.nii` as a template.
4. Move the coursor around to view different clusters.
5. Right-click on the image and from the context menu select: `Display > Labels > Neuromorphometrics`.
6. What brain regions do the visible clusters represent?

### Exporting the results

We will now learn how to export the results to a NIfTI file. This file can then be opened in any NIfTI viewer (e.g. MRIcron).

1. While in SPM's `Results` window, use the  `Save` selector.
2. Choose `Thresholded SPM` and provide a meaningful name for your output file, e.g. `CET-vs-dummy` or `dummy-vs-CET`.
3. Navigate to your files, find the file that you just created and try opening it in MRIcron.

## Second-level analysis

### But before we start...

Before we can proceed to the second level analysis, all the above steps need to be repeated for the remaining subjects.

Any survivors left...? 

### Wait, what about batch scripting?

In the shared materials, you will find two files: `tutorial_batch_glm_job.m`, which defines the batch, and `tutorial_batch_glm.m`, which runs it.

1. Open the `tutorial_batch_glm_job.m` file in SPM using the `Batch` button.
2. Notice that the batch contains all the steps we performed today!
3. Notice that the subject-specific information has been removed and replaced with `X` characters. When we run the script, `X` characters will be replaced with the following:
	- a preprocessed functional image, i.e. `sub-<label>_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz`
	- a directory name for the subject-specific results, i.e. `./derivatives/results/sub-<label>`
	- a file containing motion parameters, i.e. `sub-<label>_motion_parameters.txt`
4. Now close SPM and open the `tutorial_batch_glm.m` directly in MATLAB. This script is has been prepared to run over all the three subjects. Since we have already processed the first subject, we only need to run the script for the remaining two subejcts, i.e. `sub-0312f` and `sub-2811d`.
5. Edit the code by changing the list of subjects.
6. Save the `tutorial_batch_glm.m` script and then run it, by pressing the green `Run` button in the MATLAB menu!
7. Relax and enjoy the show! 🍿📺
8. When it's done, clear MATLAB workspace, and then go back to SPM.

```
clear all
spm fmri
```

9. Don't forget to look at the results for `sub-0312f` and `sub-2811d`! Are they similar or completely different?

Now, we are ready to start the second-level analysis!

### Model specification

1. Use the `Specify 2nd-level` button.
2. Click on `Directory`.
	- Here, we need to provide the directory where we want SPM to save the second-level results.
	- Navigate to your files, in the `derivatives/results` directory create a new `group` subdirectory.
	- At the end, your directory structure should look like this `demo-ds005460-with-derivatives/derivatives/results/group`.
	- Go back to SPM and select this newly created directory.
3. Click on `Design` and notice that at this point we can choose from many different types of analysis, such as one-sample t-test, paired t-test or ANOVA. In this case, we select the defaut option, i.e. one-sample t-test.
4. Click on `Scans`, navigate to `derivatives/results`, then to each subject's results subdirectory and select `con_0001.nii` image for each subject. In total, you should have three files selected. These images represent the `CET vs dummy` contrasts we've seen earlier!
5. Save your batch, but **don’t close it**!

### Model estimation

1. While in the batch editor, select `SPM > Stats > Model estimation`.
2. Click on `Model estimation`, then `Select SPM.mat` and this time `Dependency` instead of `Specify`.
3. Choose the only available option on the list, `Factorial design specification`.
4. Save changes to your batch, but **don’t close it** this time!

### Contrast definition

1. While in the batch editor, select `SPM > Stats > Contrast Manager`.
2. Click on `Contrast Manager`, then `Select SPM.mat` and this time `Dependency` instead of `Specify`.
3. From the list of available dependencies, choose `Model estimation`.
4. Click on `Contrast Sessions` and then `New: T-contrast`.
	- Specify `Name` as `Group: CET vs dummy`.
	- Specify `Weights vector` as `1`.
5. Click the green “play” button to run all steps!
6. Save changes to your batch and close it.
7. Use the `Results` button to view the group results, you already know all the steps! :)

## Yes, but...

The group results are somewhat disappointing, as they look nothing like those presented in the CLIMATE BRAIN publication.

1. Was this something you expected?
2. Discuss your ideas with the tutor.

## That's it!

Congratulations, you have just completed your first fMRI data analysis!
