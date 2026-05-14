%-----------------------------------------------------------------------
% Job saved on 12-May-2026 20:12:25 by cfg_util (rev $Rev: 8183 $)
% spm SPM - SPM25 (25.01.02)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files = '<UNDEFINED>';
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{1}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;
matlabbatch{2}.spm.spatial.smooth.data(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{2}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{2}.spm.spatial.smooth.dtype = 0;
matlabbatch{2}.spm.spatial.smooth.im = 0;
matlabbatch{2}.spm.spatial.smooth.prefix = 's';
matlabbatch{3}.spm.stats.fmri_spec.dir = '<UNDEFINED>';
matlabbatch{3}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{3}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
matlabbatch{3}.spm.stats.fmri_spec.sess.scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).name = 'CET';
%%
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).onset = [5.7918
                                                         20.8334
                                                         51.1668
                                                         66.9674
                                                         83.2502
                                                         99.5425
                                                         130.6259
                                                         147.4176
                                                         162.9592
                                                         193.051
                                                         208.3343
                                                         224.876
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
                                                         657.51
                                                         689.8428
                                                         705.1434
                                                         736.9851
                                                         753.7768];
%%
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).duration = 10;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).name = 'dummy';
%%
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).onset = [36.1257
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
                                                         721.4434];
%%
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).duration = 10;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{3}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.multi_reg = '<UNDEFINED>';
matlabbatch{3}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{3}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{3}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{3}.spm.stats.fmri_spec.volt = 1;
matlabbatch{3}.spm.stats.fmri_spec.global = 'None';
matlabbatch{3}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{3}.spm.stats.fmri_spec.mask = {''};
matlabbatch{3}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{4}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{4}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{4}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{5}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{5}.spm.stats.con.consess{1}.tcon.name = 'CET vs dummy';
matlabbatch{5}.spm.stats.con.consess{1}.tcon.weights = [1 -1];
matlabbatch{5}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{5}.spm.stats.con.consess{2}.tcon.name = 'dummy vs CET';
matlabbatch{5}.spm.stats.con.consess{2}.tcon.weights = [-1 1];
matlabbatch{5}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{5}.spm.stats.con.delete = 1;
