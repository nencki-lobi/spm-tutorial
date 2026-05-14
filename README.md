# SPM tutorial

This repository contains SPM tutorial materials that may be useful for teaching students, either as part of an organized course or for individual study.

The materials are divided into two chapters:

1. [Data preprocessing](https://github.com/nencki-lobi/spm-tutorial/blob/main/preproc-practice.md)
2. [Statistical data analysis](https://github.com/nencki-lobi/spm-tutorial/blob/main/glm-practice.md)

## Tutorial data

The data used in this tutorial come from the [CLIMATE BRAIN](https://openneuro.org/datasets/ds005460/versions/2.0.0) dataset. However, only a subset of the original dataset is used in each chapter.

Below, we provide the commands that can be used to recreate the tutorial datasets. Please make sure you have [DataLad](https://www.datalad.org) installed.

### Recreate `demo-ds005460` dataset used for chapter 1

```
datalad install -s https://github.com/OpenNeuroDatasets/ds005460.git demo-ds005460 && cd demo-ds005460

datalad get sub-0212[b-d]/anat/*
datalad get sub-0212[b-d]/func/*task-cet*

git annex uninit
rm -rf .datalad .git .gitattributes
find . -type l -delete

rm -f CHANGES README task-stories_events.json

find . -mindepth 2 -type f \
  ! \( \
    \( -path '*/sub-0212b/*' -o \
       -path '*/sub-0212c/*' -o \
       -path '*/sub-0212d/*' \) \
    -a \( \
       -name '*T1w*' -o \
       -name '*task-cet_bold*' -o \
       -name '*task-cet_events*' \
    \) \
  \) -delete

find . -type d -empty -delete
```

### Recreate `demo-ds005460-with-derivatives` dataset used for chapter 2

```
datalad install -s https://github.com/OpenNeuroDatasets/ds005460.git demo-ds005460-with-derivatives && cd demo-ds005460-with-derivatives

datalad get derivatives/fmriprep/sub-(0312f|1512e|2811d)/func/*task-cet*bold*
datalad get derivatives/fmriprep/sub-(0312f|1512e|2811d)/func/*task-cet*confounds*

git annex uninit
rm -rf .datalad .git .gitattributes
find . -type l -delete

rm -f CHANGES README task-stories_events.json

find . -mindepth 2 -type f \
  ! \( \
    \( -path '*/sub-0312f/*' -o \
       -path '*/sub-1512e/*' -o \
       -path '*/sub-2811d/*' \) \
    -a \( \
       -name '*task-cet_events*' -o \
       -name '*task-cet*confounds*' -o \
       -name '*task-cet*preproc_bold*' \
    \) \
  \) -delete

find . -type d -empty -delete
```

## Contact information

Any problems or concerns regarding this repository should be reported to Małgorzata Wierzba (m.wierzba@nencki.edu.pl).
