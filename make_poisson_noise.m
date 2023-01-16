function [I_poisson_noise] = make_poisson_noise()
params = model_parameters();
N_pulse = fix(params.n / 100);
r = poissrnd(params.lambda,params.N_neurons,N_pulse);
r = r * 10;
I_poisson_noise = zeros(params.N_neurons,params.n);
for j = 1:params.N_neurons
    a = r(j,:);
    b = a(a~=0);
    for i = 1:N_pulse
        if i == 1
            I_poisson_noise(j,b(1,i):b(1,i)+params.t_imp) = params.Amp;
            m = b(1,i);
        else
            I_poisson_noise(j,(m +b(1,i)):(m+ b(1,i)+params.t_imp)) = params.Amp;
            m = m + b(1,i);
        end
        if m > params.n
            break
        end
    end
end
end