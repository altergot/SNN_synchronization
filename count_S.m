%% S
function [S, spikes] = count_S(model)
params = model_parameters();
fi = zeros(params.N_neurons,params.n);
spikes = [];

for j = 1:params.N_neurons
    k = find(model.array_V(j,:) == 30);
    spikes = [ spikes; k' j+0*k' ];
    if ~isempty(k)
        m = 1;
        for i = k(1):(k(length(k))-1)
            fi(j,i) = (i - k(m)) / (k(m+1)-k(m));
            if i == k(m+1)
                m = m+1;
            end
        end
    end
end
fi = 2*pi*fi;


S = zeros(params.n,1);

for i = 1:params.n
    S(i) = sum( cos( pdist(fi(:,i),'minkowski',1) ) );
end
S = 0.5 + S / params.N_neurons / (params.N_neurons-1);
S = smooth(S,1000);
end