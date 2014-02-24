function test_bug576

% MEM 1500mb
% WALLTIME 00:10:00

% TEST test_bug576
% TEST ft_checkdata ft_senstype

% the test data that is used here was generated by 
% test_ft_preprocessing
% test_ft_timelockanalysis
% test_ft_freqanalysis
% test_ft_componentanalysis


dataset122 = {
  '/home/common/matlab/fieldtrip/data/test/latest/raw/meg/preproc_neuromag122.mat'
  '/home/common/matlab/fieldtrip/data/test/latest/comp/meg/comp_neuromag122.mat'
  '/home/common/matlab/fieldtrip/data/test/latest/freq/meg/freq_mtmfft_neuromag122.mat'
  '/home/common/matlab/fieldtrip/data/test/latest/freq/meg/freq_mtmconvol_neuromag122.mat'
  '/home/common/matlab/fieldtrip/data/test/latest/timelock/meg/timelock_neuromag122.mat'
  };

dataset306 = {
  '/home/common/matlab/fieldtrip/data/test/latest/raw/meg/preproc_neuromag306.mat'
  '/home/common/matlab/fieldtrip/data/test/latest/comp/meg/comp_neuromag306.mat'
  '/home/common/matlab/fieldtrip/data/test/latest/freq/meg/freq_mtmfft_neuromag306.mat'
  '/home/common/matlab/fieldtrip/data/test/latest/freq/meg/freq_mtmconvol_neuromag306.mat'
  '/home/common/matlab/fieldtrip/data/test/latest/timelock/meg/timelock_neuromag306.mat'
  };

for i=1:length(dataset122)
  filename = dataset122{i};
  tmp = load(filename);
  fn = fieldnames(tmp);
  for j=1:length(fn)
    data = tmp.(fn{j});
    if strcmp(fn{j}, 'comp')
      % ft_checkdata fails to detect compoment data correctly
      ft_checkdata(data, 'senstype', 'meg');
    else
      ft_checkdata(data, 'senstype', 'neuromag122');
    end
  end % for j
end % for i


for i=1:length(dataset306)
  filename = dataset306{i};
  tmp = load(filename);
  fn = fieldnames(tmp);
  for j=1:length(fn)
    data = tmp.(fn{j});
    if strcmp(fn{j}, 'comp')
      % ft_checkdata fails to detect compoment data correctly
      ft_checkdata(data, 'senstype', 'meg');
    else
      ft_checkdata(data, 'senstype', 'neuromag306');
    end
  end % for j
end % for i

