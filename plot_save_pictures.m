function [S] = plot_save_pictures(S, spikes)
params = model_parameters();
h=figure('Units','characters','Position',[0 0 600 175]);
clf
h1 = subplot(3,1,1);
plot(0.001*params.step*(0:params.n-1),[S])

grid on
ylabel('Coherence(t)')
title([ '\lambdao=' num2str(params.Lambda0) ',   \alpha=' num2str(params.alpha) ',   beta=' num2str(params.beta) ])

h2 = subplot(3,1,2:3);
plot( 0.001*params.step*spikes(:,1), spikes(:,2), '.k' )
ylabel('raster')
linkaxes( [h1 h2], 'x' )
%saveas(gcf,'results.png')
print(h,'-dpng','-r300','results')
save S.mat;
save spikes.mat;
end


