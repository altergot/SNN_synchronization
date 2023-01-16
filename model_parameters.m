function [params] = model_parameters(need_set)
persistent params_p
if nargin < 1 || ~need_set
    params = params_p;
    return;
end
params = struct;

params.step = 0.1;
params.t_end = 50;
params.n = fix( 1000 * params.t_end / params.step );
params.N_neurons = 1000;

params.neuron_fired_thr = 30;

params.aa = 0.02;
params.b = 0.2;
params.c = -65;
params.d = 8;

params.Iapp = 2.5;
params.Amp = 7;
params.t_imp = 30;
params.lambda = 100;

params.ksyn = 0.2;
params.alpha = 1;
params.beta = 0.002;

params.fwnd = 100;
params.freq2 = 31;

params.Lambda0 = 4;

params_p = params;
end