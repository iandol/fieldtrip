function test_bug1527

% MEM 1500mb
% WALLTIME 00:10:00

% TEST test_bug1527
% TEST ft_sourceplot


if ispc
  home = 'H:';
else
  home = '/home';
end

load(fullfile(home, 'common', 'matlab', 'fieldtrip', 'data', 'test', 'bug1527.mat'))

% this should be enough to reproduce the error
ft_sourceplot(cfg, source)
