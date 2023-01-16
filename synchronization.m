tic
close all; clearvars;
rng('shuffle');
params = model_parameters(true);
model = init_model();

%% cycle
for i = 1:params.n
    VV = false(params.N_neurons,1);
    VV( model.V==30 ) = true;
    model.spike1(:,i) = VV;
    if i > params.fwnd/params.step
        Aq = model.spike1(:,i-round(params.fwnd/params.step):i);
        model.freq(:,i) = sum(Aq,2)*1000/params.fwnd;
        model.freq( model.freq(:,i)<params.freq2, i ) = 0;
    end
    model.Lambda = model.Lambda + params.step * 0.001 * (params.alpha * (params.Lambda0-model.Lambda) - params.beta * model.freq(:,i) );
    model.Lambda(model.Lambda<0) = 0;
    
    S1 = 1 ./ (1 + exp((-model.V ./ params.ksyn)));
    Isyn = -sum(model.A100.*S1)' .* model.V .* model.Lambda ./ model.D;
    
    fired = find(model.V >= params.neuron_fired_thr);
    model.V(fired) = params.c;
    model.U(fired) = model.U(fired) + params.d;
    model.V = model.V + params.step * (0.04*model.V.^2 + 5*model.V + 140 + params.Iapp + model.I_poisson_noise(:,i) + Isyn - model.U);
    model.U = model.U + params.step * params.aa * (params.b*model.V - model.U);
    model.V = min(model.V, params.neuron_fired_thr);
    
    model.array_V(:,i) = model.V;
    
end
vars = {'Aq','fired','i', 'Isyn', 'S1', 'VV'};
clear(vars{:});

[S, spikes] = count_S(model);
[S] = plot_save_pictures(S, spikes);
toc