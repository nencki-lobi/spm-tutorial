% List of open inputs
% Gunzip Files: File Set - cfg_files
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Multiple regressors - cfg_files

code = '/Users/cynamon/Documents/batches/'; % Path to your batch script (adjust!)
data = '/Users/cynamon/Documents/demo-ds005460-with-derivatives/'; % Path to your data (adjust!)

derivatives = fullfile(data, 'derivatives');
fmriprep = fullfile(derivatives, 'fmriprep');
results = fullfile(derivatives, 'results');

subjects = {'sub-0312f', 'sub-1512e', 'sub-2811d'};
nrun = numel(subjects); % enter the number of runs here

jobfile = {fullfile(code, 'tutorial_batch_glm_job.m')};
jobs = repmat(jobfile, 1, nrun);

inputs = cell(3, nrun);
for crun = 1:nrun
    
    s = subjects{crun};

    mkdir(fullfile(results, s))

    inputs{1, crun} = {fullfile(fmriprep, s, 'func', [s '_task-cet_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz'])}; % Gunzip Files: File Set - cfg_files
    inputs{2, crun} = {fullfile(results, s)}; % fMRI model specification: Directory - cfg_files
    inputs{3, crun} = {fullfile(fmriprep, s, 'func', [s '_motion_parameters.txt'])}; % fMRI model specification: Multiple regressors - cfg_files
end

spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
