%% BF SST analysis master guide
btm = pwd;
blfile = 'All bursts baseline std2 conn 6.mat';
clfile = 'All bursts clozapine std2 conn 6.mat';

%% Dreadd expressing animals 
cd([btm '\Dreadd'])

[blAllD,clAllD,freqblD,freqclD] = compareWidefieldBursts([btm '\Dreadd'],blfile, clfile)

%% control animals
cd([btm '\Control'])

[blAllC,clAllC,freqblC,freqclC] = compareWidefieldBursts([btm '\Control'],blfile, clfile)


%% plot each parameter before and after clozapine, dreadd + and control

varNames = {'file','startFrame', 'endFrame', 'meanAmplitude','Distance','Total area activated (square mm)', 'Average size of event (square mm)','Largest area in an event (square mm)','Speed', 'Deviation','Duration (seconds)','Xdist','Ydist','Unique Px Activated', 'Start v1', 'End v1', 'in v1', 'NaN', 'Mean as % FoV', 'Max as % FoV'};

for iParam = 4:8
    figure
    bar([nanmean(blAllD(:,iParam)) nanmean(clAllD(:,iParam)) ;nanmean(blAllC(:,iParam)) nanmean(clAllC(:,iParam)) ])
    hold on
    for iAnimal = 1:size(blAllD,1)
        plot([0.85 1.15], [blAllD(iAnimal,iParam) clAllD(iAnimal,iParam)],'b')
    end
    for iAnimal = 1:size(blAllC,1)
        plot([1.85 2.15], [blAllC(iAnimal,iParam) clAllC(iAnimal,iParam)],'b')
    end
    
    [h,p] = ttest(blAllD(:,iParam),clAllD(:,iParam))
    plotSig(h,p,1,nanmean(blAllD(:,iParam))+(0.1*nanmean(blAllD(:,iParam))));
    [h,p] = ttest(blAllC(:,iParam),clAllC(:,iParam))
    plotSig(h,p,2,nanmean(blAllC(:,iParam))+(0.1*nanmean(blAllC(:,iParam))));
    title(varNames(iParam))
    set(gca,'xticklabel',{'Dreadd','Control'})
    legend({'BL', 'Clozapine'})
    pimpPlot
end

%% frequency

figure
bar([nanmean(freqblD) nanmean(freqclD);nanmean(freqblC) nanmean(freqclC) ])
hold on
for iAnimal = 1:size(blAllD,1)
    plot([0.85 1.15], [freqblD(iAnimal,1) freqclD(iAnimal,1)],'black')
end
 for iAnimal = 1:size(blAllC,1)
        plot([1.85 2.15], [freqblC(iAnimal,1) freqclC(iAnimal,1)],'b')
    end
pimpPlot
ylabel('Frequency (events/min)')
set(gca,'xticklabel',{'Baseline','Clozapine'})
[h,p] = ttest(freqblD,freqclD)
plotSig(h,p,1,nanmean(freqblD)+0.1*nanmean(freqblD))
[h,p] = ttest(freqblC,freqclC)
plotSig(h,p,2,nanmean(freqblC)+0.1*nanmean(freqblC))
set(gca,'xticklabel',{'Dreadd','Control'})
legend({'BL', 'Clozapine'})
