% List of open inputs
% Gunzip Files: File Set - cfg_files
% Gunzip Files: File Set - cfg_files

code = '/Users/cynamon/Documents/batches/'; % Path to your batch script (adjust!)
data = '/Users/cynamon/Documents/demo-ds005460/'; % Path to your data (adjust!)

subjects = {'sub-0212b', 'sub-0212c', 'sub-0212d'};
nrun = numel(subjects); % enter the number of runs here

jobfile = {fullfile(code, 'tutorial_batch_preproc_job.m')};
jobs = repmat(jobfile, 1, nrun);

inputs = cell(2, nrun);
for crun = 1:nrun

    s = subjects{crun};

    inputs{1, crun} = {fullfile(data, s, 'anat', [s '_T1w.nii.gz'])}; % Gunzip Files: File Set - cfg_files
    inputs{2, crun} = {fullfile(data, s, 'func', [s '_task-cet_bold.nii.gz'])}; % Gunzip Files: File Set - cfg_files
end

spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
