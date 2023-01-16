function [model] = init_model()
model = struct;
params = model_parameters();

V_0 = -65 + 20*randn(params.N_neurons,1);
model.V = V_0 .* ones(params.N_neurons,1);
model.U = zeros(params.N_neurons,1);
model.array_V = zeros(params.N_neurons,params.n);

load SF_1000_3_3.mat
model.A100 = A100;
model.D = sum(model.A100,2);

model.t_spike = zeros(params.N_neurons,1);

model.spike1 = false(params.N_neurons,params.n);

model.freq = zeros(params.N_neurons,params.n);
model.Lambda = params.Lambda0 * ones(params.N_neurons,1);
model.I_poisson_noise = make_poisson_noise();
end