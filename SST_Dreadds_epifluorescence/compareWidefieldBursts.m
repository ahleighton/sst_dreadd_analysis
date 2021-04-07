function[blAll,clAll,freqbl,freqcl] = compareWidefieldBursts(btm,blfile,clfile)

animalList = dir();
animalList = animalList(3:end);


%% collect means of parameters into blAll and clAll

clear bn cln bnlog clnlog whichbin bnHonly clnHonly
for iAnimal = 1:size(animalList,1)
    cd([btm '\' animalList(iAnimal).name])
    load(blfile)
    load(clfile)
    load('areas traj non red')
    load('clustering output CL.mat')
    load('clustering output BL.mat')
    %% try jst start
    bursts = bursts(bursts(:,1)<6,:);
    clbursts = clbursts(clbursts(:,1)<6,:);
    
    %% compare areas to size of V1
    
    bursts(:,19) = bursts(:,7)./(260*348)*100;
    bursts(:,20) = bursts(:,8)./(260*348)*100;
    
    clbursts(:,19) = clbursts(:,7)./(260*348)*100;
    clbursts(:,20) = clbursts(:,8)./(260*348)*100;
    
    %% convert pixels to mm (1px = 7.4 um)
    bursts(:,6:8) = bursts(:,6:8).* 0.000054;
    clbursts(:,6:8) = clbursts(:,6:8).* 0.000054;
    bursts(:,5)= bursts(:,5).*0.0074;
    clbursts(:,5) = clbursts(:,5).*0.0074;
    bursts(:,11) = bursts(:,11)./20;
    clbursts(:,11) = clbursts(:,11)./20;
    bursts(:,9) = bursts(:,5)./ bursts(:,11);
    clbursts(:,9) = clbursts(:,5)./ clbursts(:,11);
    
    bursts(:,14) = bursts(:,14).* 0.000054;
    clbursts(:,14) = clbursts(:,14).* 0.000054;
    
    %%
    
    blAll(iAnimal,:) = nanmean(bursts);
    clAll(iAnimal,:) = nanmean(clbursts);
    
    % frequency is assuming all recs are 6000 frames and imaged at 20 Hz (5
    % mins)
    
    freqbl(iAnimal,:) = size(bursts,1)./((size(unique(bursts(:,1)),1))*5);
    freqcl(iAnimal,:) = size(clbursts,1)./((size(unique(clbursts(:,1)),1))*5);
    
    %% bin for histogram
    % edges = logspace(-2,2.5,30); used for first sub to Cell reports
    edgeslog = logspace(-4,2.5,30);       
    [bnlog(iAnimal,:)] = histcounts(bursts(:,7),edgeslog, 'normalization', 'probability');
    [clnlog(iAnimal,:)] = histcounts(clbursts(:,7),edgeslog, 'normalization', 'probability');
   
    [bnlogcount(iAnimal,:)] = histcounts(bursts(:,7),edgeslog);
    [clnlogcount(iAnimal,:)] = histcounts(clbursts(:,7),edgeslog);
   
    %% for each bin, how many H events?
    %which is L and which is H, basleine 
    indLBaseline = cbl==1;
    indHBaseline = cbl==2;
    if sum(indHBaseline) > sum(indLBaseline)
        indLBaseline = cbl ==2; indHBaseline = cbl ==1;
    end
            
    %which is L and which is H, basleine 
    indLClozapine = ccl==1;
    indHClozapine = ccl==2;
    if sum(indHClozapine) > sum(indLClozapine)
        indLClozapine = ccl ==2; indHClozapine = ccl ==1;
    end
    
    [BaselineBinWithH(iAnimal,:),b,whichbin] = histcounts(bursts(indHBaseline,7),edgeslog)
    [ClozapineBinWithH(iAnimal,:),b,whichbin] = histcounts(clbursts(indHClozapine,7),edgeslog)

    edgesHonly = 0.15:0.05:3;
    [bnHonly(iAnimal,:)] = histcounts(bursts(:,7),edgesHonly);
    [clnHonly(iAnimal,:)] = histcounts(clbursts(:,7),edgesHonly);
     
    edgeslinear = 0:0.05:3;
    [bnlinear(iAnimal,:)] = histcounts(bursts(:,7),edgeslinear, 'normalization', 'probability');
    [cllinear(iAnimal,:)] = histcounts(clbursts(:,7),edgeslinear, 'normalization', 'probability');
    
    %% trajectories
    blAll(iAnimal,15) = sum(bursts(:,16)./size(bursts,1));
    blAll(iAnimal,16) = sum(bursts(:,17)./size(bursts,1));
    clAll(iAnimal,15) = sum(clbursts(:,16)./size(clbursts,1));
    clAll(iAnimal,16) = sum(clbursts(:,17)./size(clbursts,1));
    blAll(iAnimal,17) = sum(bursts(:,15)./size(bursts,1));
    clAll(iAnimal,17) = sum(clbursts(:,15)./size(clbursts,1));
    
    inv1(iAnimal,1) = sum(bursts(:,15))./size(bursts,1);
    inv1(iAnimal,2) = sum(clbursts(:,15))./size(clbursts,1);
end

%% plot bar graphs

varNames = {'file','startFrame', 'endFrame', 'meanAmplitude','Distance','Total area activated (square mm)', 'Average size of event (square mm)','Largest area in an event (square mm)','Speed', 'Deviation','Duration (seconds)','Xdist','Ydist','Unique px', 'Start v1', 'End v1', 'in v1'};

for iParam = 4:17
    figure
    bar([nanmean(blAll(:,iParam)) nanmean(clAll(:,iParam))])
    hold on
    for iAnimal = 1:size(animalList,1)
        plot([1 2], [blAll(iAnimal,iParam) clAll(iAnimal,iParam)],'b-o')
    end
    [h,p] = ttest(blAll(:,iParam),clAll(:,iParam))
    plotSig(h,p,1,nanmean(blAll(:,iParam))+(0.1*nanmean(blAll(:,iParam))));
    title(varNames(iParam))
    set(gca,'xticklabel',{'Baseline','Dreadd Clozapine'})
    pimpPlot
end

%% frequencies

figure
bar([nanmean(freqbl) nanmean(freqcl)])
hold on
for iAnimal = 1:size(animalList,1)
    plot([1 2], [freqbl(iAnimal,1) freqcl(iAnimal,1)],'black-o')
end
pimpPlot
ylabel('Frequency (events/min)')
set(gca,'xticklabel',{'Baseline','Clozapine'})
[h,p] = ttest(freqbl,freqcl)
plotSig(h,p,1.5,nanmean(freqbl)+0.1*nanmean(freqbl))

% in v1

figure
bar([ nanmean(inv1)])
hold on
plot([1 2],[inv1(:,1) inv1(:,2)])
[h,p] = ttest(inv1(:,1),inv1(:,2))
pimpPlot

