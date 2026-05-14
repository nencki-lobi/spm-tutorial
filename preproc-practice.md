# Introduction to Functional Imaging of the Human Brain
## Hands-on session with SPM - data preprocessing

**Małgorzata Wierzba, PhD** (m.wierzba@nencki.edu.pl)
<br>Laboratory of Emotions Neurobiology
<br>Center of Excellence for Neural Plasticity and Brain Disorders BRAINCITY
<br>Nencki Institute of Experimental Biology, Polish Academy of Sciences

## What will we need?

- [x] Basic knowledge about fMRI data preprocessing
- [x] Software: [SPM 25](https://www.fil.ion.ucl.ac.uk/spm/software/) + [MATLAB](https://www.mathworks.com/products/matlab.html)
- [ ] Data: [CLIMATE BRAIN](https://openneuro.org/datasets/ds005460/versions/2.0.0) dataset

## Software

- [SPM 25](https://www.fil.ion.ucl.ac.uk/spm/software/) is a free and open source software used for the preprocessing and statistical analysis of MRI/fMRI data.
- It requires [MATLAB](https://www.mathworks.com/products/matlab.html) (proprietary software) for which you need a license.
- Extensive documentation and [online tutorials](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/).

**NOTE:** In this class we won't have much time to talk about MATLAB, but you can learn more [here](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/beginners/).

## Data

The [CLIMATE BRAIN](https://openneuro.org/datasets/ds005460/versions/2.0.0) dataset is a collection of questionnaire, behavioural, and neuroimaging data related to climate change.

- Scientific publication: Zaremba et al. (2025) CLIMATE BRAIN - Questionnaires, Tasks and the Neuroimaging Dataset. Scientific Data 12, 726. https://doi.org/10.1038/s41597-025-05038-0
- Data, hosted on OpenNeuro: https://openneuro.org/datasets/ds005460/versions/2.0.0

**NOTE:** The whole dataset contains data from 160 subjects and analysing this data would take too much time! Therefore, we will use data from 2-3 subjects at maximum.

## Setup

1. Copy the `demo-ds005460` directory from the shared materials to your local machine. 
	- As you inspect its contents, you will notice that it contains only a subset of the original dataset.
	- It includes raw, unprocessed data from three subjects: `sub-0212b`, `sub-0212c`, and `sub-0212d`.
	- The original dataset contains data from two experimental tasks, `stories` and `cet`, but we will only use one of them.

```
.
├── dataset_description.json
├── participants.json
├── participants.tsv
├── sub-0212b
│   ├── anat
│   │   ├── sub-0212b_T1w.json
│   │   └── sub-0212b_T1w.nii.gz
│   └── func
│       ├── sub-0212b_task-cet_bold.json
│       ├── sub-0212b_task-cet_bold.nii.gz
│       └── sub-0212b_task-cet_events.tsv
├── sub-0212c
│   ├── anat
│   │   ├── sub-0212c_T1w.json
│   │   └── sub-0212c_T1w.nii.gz
│   └── func
│       ├── sub-0212c_task-cet_bold.json
│       ├── sub-0212c_task-cet_bold.nii.gz
│       └── sub-0212c_task-cet_events.tsv
├── sub-0212d
│   ├── anat
│   │   ├── sub-0212d_T1w.json
│   │   └── sub-0212d_T1w.nii.gz
│   └── func
│       ├── sub-0212d_task-cet_bold.json
│       ├── sub-0212d_task-cet_bold.nii.gz
│       └── sub-0212d_task-cet_events.tsv
└── task-cet_events.json
```

2. Open MATLAB and navigate to the `demo-ds005460` directory (the one you just created on your machine).

3. Start SPM by typing:

```
spm fmri
```

4. Familiarize yourself with SPM's interface. What do you think different buttons do? For instance, what do you think the `Smooth` button does?

5. In the remainder of this class, we will make frequent use of SPM’s batch editor. To open it, click the `Batch` button. The batch editor can be used to build a complete analysis pipeline. We will learn more about it toward the end of the class.

**NOTE:** To keep things simple and save time, we won’t cover all the preprocessing steps. If you’d like to learn more, we recommend going through [SPM’s tutorials](https://www.fil.ion.ucl.ac.uk/spm/docs/tutorials/). Additionally, [Andy's Brain Book](https://andysbrainbook.readthedocs.io/en/latest/#) is a great online resource.

## Let's start!

We will start by preprocessing data from a single subject (e.g., `sub-0212b`). We may use the remaining subjects' data at the end of the class.

## Unpacking the data

For scientific purposes, we typically store MRI/fMRI data in the NIFTI format, i.e. `.nii`. It is also a common practice to use a compressed NIFTI format, i.e. `.nii.gz`. Because MRI datasets can be very large, compression helps reduce storage costs.

Since SPM can only work with uncompressed NIFTI, we need to unzip them first.

1. Use the `Batch` button, then select `BasicIO > File Operations > Gunzip Files`
2. Notice that SPM prompts us for the inputs that need to be provided! This is indicated by the `X` characters.
3. Click on the `File Set`, then `Specify`.
4. Navigate to `sub-0212b`. From `anat` select the anatomical image `sub-0212b_T1w.nii.gz`. From `func` select the functional image `sub-0212b_task-cet_bold.nii.gz`. When you're ready, click `Done`.
5. Click the green "play" button to run this step!
6. Navigate to your files to check whether the `.nii.gz` files were successfully uncompressed into `.nii` files.
7. You can now save your batch (use `File > Save Batch`). It is good practice to give the batch a meaningful name (e.g. `batch_gunzip.mat`) so that you can immediately tell what it does. When you’re ready, close the batch editor window.

## Visual inspection

For visual inspection you can use `Display` (to view a single image) or `Check Reg` (to view multiple images simultanously) buttons. The `Check Reg` module is very useful to inspect if various preprocessing steps were successfuly performed. For instance, we can use it to make sure that our data is in a standard MNI space.

1. Use `Display` to view the `sub-0212b_T1w.nii` image. 
	- This is an anatomical image and it's 3-dimensional.
	- Notice that this image has been defaced to protect the identity of the subject. This is a standard procedure, required by OpenNeuro.
2. Now, use it to view the `sub-0212b_task-cet_bold.nii` image.
	- This is a functional image and it's 4-dimensional.
	- Notice that the functional image has lower spatial resolution than the anatomical image.
3. Now, use `Check Reg` to check the registation of two images:
	- Select the `sub-0212b_T1w.nii` anatomical image.
	- Select the MNI template image. To do that, use the `Prev` path selector to navigate to SPM's `canonical` subdirectory and select the `avg305T1.nii` file.
	- What do you see?

## Realignment

This step can be performed with the `Realign` button. Make sure to select the `Realign (Est & Res)`.

1. SPM again prompts us for the inputs.
2. There is only one input that needs to be provided. Click on `Data`, then `Specify`, then click on `Session` and again `Specify`. 
3. Navigate to `sub-0212b` and to the `func` subdirectory.
4. **Important**: Make sure to select all the functional images! By default SPM only shows you one frame. To change that click on the `Frames` field, replace `1` with `Inf`, the press the `Enter` key.
5. Now, right-click on the right pane and from the context menu select `Select All`. You should see 385 files added. If you're ready, click `Done`. 
6. Notice the all functional images will be registered to the mean functional image (`Register to mean`).
7. You will recognize the resulting output files by the `r` prefix.
8. Make sure that SPM's Graphics window is opened. If it's not, you can bring it back by using the `Display` button again.
9. Click the green "play" button to run this step!
10. The plots show the head motion: translations & rotations!
11. Navigate to your files to see that the following files were created:
	- `rsub-0212b_task-cet_bold.nii` which is the realigned and resliced functional image
	- `meansub-0212b_task-cet_bold.nii` which is the mean functional image
	- `rp_sub-0212b_task-cet_bold.txt` which contains the information about the 6 head motion parameters!
12. Save your batch and close it. 

## Coregistration

This step can be performed with the `Coregister` button. Make sure to select the `Coregister (Est & Res)`.

1. Only two fields need to be filled in: `Fixed Image` and `Moved Image`. The `Fixed Image` will remain stationary. The `Moved Image` will be moved around to match the `Fixed Image`. Typically, we want the functional image to remain stationary. This is because we generally want to avoid modifying it too much.
2. Click on the `Fixed Image` and select a representative of the functional data — the mean functional image (i.e., `meansub-0212b_task-cet_bold.nii`).
3. Click on the `Moved Image` and select the anatomical image (`sub-0212b_T1w.nii`).
4. Click the green "play" button to run this step!
5. Navigate to your files to see that the following files were created:
	- `rsub-0212b_T1w.nii` which is a corregistered and resliced anatomical image.
6. You can use the `Display` button to compare it to the original anatomical image. Compare the voxel size of the two images. What do you notice?
7. Save your batch and close it.

## Segmentation

This step can be performed with the `Segment` button.

1. This step only requires the coregistered anatomical file as input.
2. Click on the `Volumes` then navigate to the `anat` subdirectory and select the `rsub-0212b_T1w.nii` file.
3. Click on the `Save INU Corrected` field and change it from `Save Nothing` to `Save INU Corrected`.
4. Click on the `Deformation Fields` field and change it from `None` to `Forward`.
5. Click the green "play" button to run this step!
6. Navigate to your files to see that the following files were created:
	- `c1rsub-0212b_T1w.nii`, `c2rsub-0212b_T1w.nii`, ... `c5rsub-0212b_T1w.nii`, which correspond to different tissue classes
	- `y_rsub-0212b_T1w.nii`, which represents the deformation field needed for the next step.
7. You can use the `Check Reg` button to view the `c1`, `c2`, ... `c5` images. Do you know what tissues they represent?
8. Save your batch and close it.

## Normalisation

This step can be performed with the `Normalise` button. Make sure to select the `Normalise (Write)`.

1. Click on the `Data`, then `Specify`.
2. Click on the `Deformation Field`, then navigate to the `anat` subdirectory and select the `y_rsub-0212b_T1w.nii`.
3. Click on the `Images to Write`, then navigate to the `func` subdirectory.
4. **Important**: Make sure to select all the realigned funtional images! Click on the `Filter` field and change it to `r.*`. Then click on the `Frames` field, replace `1` with `Inf`, the press the `Enter` key.
5. Now, right-click on the right pane and from the context menu select `Select All`. You should see 385 files added. If you're ready, click `Done`.
6. You will recognize the resulting output files by the `w` prefix.
7. Click the green "play" button to run this step!
8. You can use the `Check Reg` to verify if the normalisation was successful. If you’re not sure how to do that, please go back to the ‘Visual inspection’ section. :)
9. Save your batch and close it.

## Smoothing

Finaly, this step can be performed with the `Smooth` button.

1. This step only requires the normalised functional images as input.
2. Click on the `Images to smooth`, then navigate to the `func` subdirectory.
3. **Important**: Make sure to select all the normalised funtional images! Click on the `Filter` field and change it to `w.*`. Then click on the `Frames` field, replace `1` with `Inf`, the press the `Enter` key.
4. Now, right-click on the right pane and from the context menu select `Select All`. You should see 385 files added. If you're ready, click `Done`.
5. Consider changing the `FWHM` field to `6 6 6`. This is how much you will smooth the data. Typically, we aim for the FWHM that is twice the size of the functional voxel.
6. You will recognize the resulting output files by the `s` prefix.
7. Click the green "play" button to run this step!
8. You can use `Check Reg` to compare the unsmoothed and smoothed images.
9. Save your batch and close it.

## Optional: batch scripting

SPM allows you to automate everything using batch scripting. This is typically done by manually setting up a preprocessing pipeline for a single subject and then using it as a ‘template’ for all subjects. When you have your pipline ready, you can export it to code by selecting `Save > Batch and script` option from the menu.

In the shared materials, you will find two files: `tutorial_batch_preproc_job.m`, which defines the batch, and `tutorial_batch_preproc.m`, which runs it.

1. Open the `tutorial_batch_preproc_job.m` file in SPM using the `Batch` button.
2. Notice that the batch contains all the steps we performed today!
3. Notice that the subject-specific information has been removed and replaced with `X` characters. This information will be filled in when the script is run.
4. Notice that `X` for most od the preprocessing steps are now replaced with the dependencies!
5. Now close SPM and take a look at the code.
6. Open `tutorial_batch_preproc_job.m` directly in MATLAB. Do you recognize which sections of the code correspond to the different preprocessing steps?
7. Next, open the `tutorial_batch_preproc.m` in MATLAB. This script runs the batch (e.g., `tutorial_batch_preproc_job.m`). It can be configured to loop over multiple subjects and, for each one, generate a list of inputs that are passed to the ‘template’ at runtime.
8. The script has been prepared to run over all the three subjects. Since we have already processed the first subject, we only need to run the script for the remaining two subejcts.
9. Edit the code by changing the list of subjects.
10. Save the `tutorial_batch_complete.m` script and then run it, by pressing the green `Run` button in the MATLAB menu!
11. Relax and enjoy the show! 🍿📺
