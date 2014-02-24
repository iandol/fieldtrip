function test_old_connectivityanalysis

% MEM 1gb
% WALLTIME 00:10:00

% TEST test_old_connectivityanalysis

% this script tests the functionality of connectivityanalysis

% first create some data
cfg             = [];
cfg.method      = 'linear_mix'; 
cfg.ntrials     = 200;
cfg.nsignal     = 2;
cfg.triallength = 1;
cfg.fsample     = 200;
%cfg.fsample     = 1000;
%cfg.bpfilter    = 'yes';
%cfg.bpfreq      = [15 25];
%cfg.mix         = [1 0 1; 0 1 1];
%cfg.delay       = [0 0 5; 0 0 0];
cfg.method      = 'ar';
cfg.params(:,:,1) = [ 0.8 0.5; 
                      0   0.9];
cfg.params(:,:,2) = [-0.5    0; 
                        0 -0.8]; 
cfg.noisecov      = [0.3 0; 
                       0 1];
data            = ft_connectivitysimulation(cfg);

% do mvaranalysis
cfgm       = [];
cfgm.order = 5;
cfgm.toolbox = 'bsmart';
mdata      = ft_mvaranalysis(cfgm, data);
cfgfm      = [];
cfgfm.method = 'mvar';
mfreq      = ft_freqanalysis(cfgfm, mdata);

% freqanalysis
cfgf           = [];
cfgf.method    = 'mtmfft';
cfgf.output    = 'fourier';
cfgf.tapsmofrq = 2;
freq           = ft_freqanalysis(cfgf, data);
fd             = ft_freqdescriptives([], freq);
freqx          = freq2transfer([], freq);

cfgsf.channelcmb = {'all' 'all'};
freq2x2          = freq2transfer(cfgsf, freq);

% connectivityanalysis
cfgc           = [];
cfgc.method    = 'coh';
c1             = ft_connectivityanalysis(cfgc, freq);
c1m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'plv';
c2             = ft_connectivityanalysis(cfgc, freq);
c2m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'csd';
cfgc.complex   = 'angle';
c3             = ft_connectivityanalysis(cfgc, freq);
c3m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'psi';
cfgc.complex   = 'abs';
cfgc.bandwidth = 4;
c4             = ft_connectivityanalysis(cfgc, freq);
c4m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'granger';
c5             = ft_connectivityanalysis(cfgc, freqx);
c5m            = ft_connectivityanalysis(cfgc, mfreq);
c5b            = ft_connectivityanalysis(cfgc, freq2x2);
cfgc.method    = 'pdc';
c6             = ft_connectivityanalysis(cfgc, freqx);
c6m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'dtf';
c7             = ft_connectivityanalysis(cfgc, freqx);
c7m            = ft_connectivityanalysis(cfgc, mfreq);
c7b            = ft_connectivityanalysis(cfgc, freq2x2);
cfgc.method    = 'instantaneous_causality';
c8             = ft_connectivityanalysis(cfgc, freqx);
c8m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'total_interdependence';
c9             = ft_connectivityanalysis(cfgc, freqx);
c9m            = ft_connectivityanalysis(cfgc, mfreq);


%--------------------------------------------------------
% now make 3 channels with no direct link between 1 and 2
% create some data
cfg             = [];
cfg.ntrials     = 500;
cfg.triallength = 1;
cfg.fsample     = 200;
cfg.nsignal     = 3;
%cfg.method      = 'linear_mix'; 
%cfg.bpfilter    = 'yes';
%cfg.bpfreq      = [15 25];
%cfg.mix         = [1 0 1; 0 1 1;0 0 2];
%cfg.delay       = [0 0 5; 0 0 0;0 0 0];
cfg.method      = 'ar';
cfg.params(:,:,1) = [ 0.8 0   0; 
                      0   0.9 0.5;
                      0.4 0   0.5];
cfg.params(:,:,2) = [-0.5    0  0; 
                        0 -0.8  0; 
                        0    0 -0.2];
cfg.noisecov      = [0.3 0 0;
                       0 1 0;
                       0 0 0.2];

data            = ft_connectivitysimulation(cfg);

% do mvaranalysis
cfgm       = [];
cfgm.order = 5;
cfgm.toolbox = 'bsmart';
mdata      = ft_mvaranalysis(cfgm, data);
cfgfm      = [];
cfgfm.method = 'mvar';
mfreq      = ft_freqanalysis(cfgfm, mdata);

% freqanalysis
cfgf           = [];
cfgf.method    = 'mtmfft';
cfgf.output    = 'fourier';
cfgf.tapsmofrq = 2;
freq           = ft_freqanalysis(cfgf, data);
fd             = ft_freqdescriptives([], freq);
freqx          = freq2transfer([], freq);

cfgfs            = [];
cfgfs.channelcmb = {'all' 'all'};
freq2x2          = freq2transfer(cfgfs, freq);

% connectivityanalysis
cfgc           = [];
cfgc.method    = 'coh';
c1             = ft_connectivityanalysis(cfgc, freq);
c1m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'plv';
c2             = ft_connectivityanalysis(cfgc, freq);
c2m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'csd';
cfgc.complex   = 'angle';
c3             = ft_connectivityanalysis(cfgc, freq);
c3m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'psi';
cfgc.complex   = 'abs';
cfgc.bandwidth = 4;
c4             = ft_connectivityanalysis(cfgc, freq);
c4m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'granger';
c5             = ft_connectivityanalysis(cfgc, freqx);
c5m            = ft_connectivityanalysis(cfgc, mfreq);
c5b            = ft_connectivityanalysis(cfgc, freq2x2);
cfgc.method    = 'pdc';
c6             = ft_connectivityanalysis(cfgc, freqx);
c6m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'dtf';
c7             = ft_connectivityanalysis(cfgc, freqx);
c7m            = ft_connectivityanalysis(cfgc, mfreq);
c7b            = ft_connectivityanalysis(cfgc, freq2x2);
cfgc.method    = 'instantaneous_causality';
c8             = ft_connectivityanalysis(cfgc, freqx);
c8m            = ft_connectivityanalysis(cfgc, mfreq);
cfgc.method    = 'total_interdependence';
c9             = ft_connectivityanalysis(cfgc, freqx);
c9m            = ft_connectivityanalysis(cfgc, mfreq);



cfgc             = [];
cfgc.partchannel = 'signal003';
cfgc.method      = 'csd';
cfgc.complex     = 'complex';
freqp            = ft_connectivityanalysis(cfgc, freqx);
freqxp           = freq2transfer([], freqp);
cfgc.method      = 'granger';
c5p              = ft_connectivityanalysis(cfgc, freqxp);
cfgc.method      = 'instantaneous_causality';
c8p              = ft_connectivityanalysis(cfgc, freqxp);



