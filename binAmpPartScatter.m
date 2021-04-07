function[] = binAmpPartScatter(nX, xBL, xCL, edges)

for iAnimal = 1:nX
    figure
    participations = xBL.(['Animal_' (num2str(iAnimal))]).handl(:,8);
    amplitudes = xBL.(['Animal_' (num2str(iAnimal))]).handl(:,7);
    [a,b,c] = histcounts(participations,edges);
    nbins = max(c);
    scatter(c-0.15, amplitudes(:), 10, 'b', 'jitter','on', 'jitterAmount', 0.15);
    participations = xCL.(['Animal_' (num2str(iAnimal))]).handl(:,8);
    amplitudes = xCL.(['Animal_' (num2str(iAnimal))]).handl(:,7);
    [a,b,c] = histcounts(participations,edges);
    nbins = max(c);
    scatter(c+0.15, amplitudes(:), 10, 'r', 'jitter','on', 'jitterAmount', 0.15);
end

pimpPlot
xlabel('Participation')
ylabel('Amplitude')
legend({'Baseline', 'After Clozapine'})
set(gca,'Xtick', 1:8)

set(gca,'Xticklabel',{'20-30', '30-40','40-50', '50-60','60-70','70-80','80-90', '90-100'} )

