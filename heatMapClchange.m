function[allcountchanged] = heatMapClchange(nD,dBL,dCL)

%% bin amplitude and participation before after and change

for iAnimal = 1:nD
    [counts, countspercent, countsbl,countscl] = clozapineChangeAmp(iAnimal, dBL, dCL,0);
    allcountsbl(:,:,iAnimal) = countsbl;
    allcountchanged(:,:,iAnimal) = counts;
    allcountspercentd(:,:,iAnimal) = countspercent;
    hl(iAnimal,:) = [nanmean(dBL.(['Animal_' (num2str(iAnimal))]).hevent(:,7)) nanmean(dBL.(['Animal_' (num2str(iAnimal))]).levent(:,7))];
    allcountscl(:,:,iAnimal) = countscl;
    
end

% baseline frequencies
figure
subplot(2,2,1)
imagesc(nanmean(allcountsbl,3),[0 0.7])
colormap(calcium_lut)
set(gca,'xtick',[1:8])
set(gca,'ytick',[1:17])
set(gca,'xticklabel',{'20-30','30-40','40-50','50-60','60-70','70-80','80-90','90-100'})
set(gca,'yticklabel',{'160-170','150-160','140-150','130-140','120-130','110-120','100-110','90-100','80-90','70-80','60-70','50-60','40-50','30-40','20-30','10-20','0-10'})
ylabel('Amplitude')
xlabel('Participation')
pimpPlot
title('baseline frequencies')

% clozapine frequencies

subplot(2,2,2)
imagesc(nanmean(allcountscl,3),[0 0.7])
colormap(calcium_lut)
set(gca,'xtick',[1:8])
set(gca,'ytick',[1:17])
set(gca,'xticklabel',{'20-30','30-40','40-50','50-60','60-70','70-80','80-90','90-100'})
%set(gca,'yticklabel',{'150-170','130-150','110-130','90-110','70-90','50-70','30-50','10-30'})
set(gca,'yticklabel',{'160-170','150-160','140-150','130-140','120-130','110-120','100-110','90-100','80-90','70-80','60-70','50-60','40-50','30-40','20-30','10-20','0-10'})
ylabel('Amplitude')
xlabel('Participation')
pimpPlot
title('clozapine frequencies')

% frequency change as % of baseline
subplot(2,2,3)
imagesc(nanmean(allcountspercentd,3),[-200 500])
colormap(calcium_lut)
set(gca,'xtick',[1:8])
set(gca,'ytick',[1:17])
set(gca,'xticklabel',{'20-30','30-40','40-50','50-60','60-70','70-80','80-90','90-100'})
%set(gca,'yticklabel',{'150-170','130-150','110-130','90-110','70-90','50-70','30-50','10-30'})
set(gca,'yticklabel',{'160-170','150-160','140-150','130-140','120-130','110-120','100-110','90-100','80-90','70-80','60-70','50-60','40-50','30-40','20-30','10-20','0-10'})
ylabel('Amplitude')
xlabel('Participation')
title('Change in %')
pimpPlot

% frequency change
subplot(2,2,4)
imagesc(nanmean(allcountchanged,3),[-0.05 0.40])
colormap(parula)
set(gca,'xtick',[1:8])
set(gca,'ytick',[1:17])
set(gca,'xticklabel',{'20-30','30-40','40-50','50-60','60-70','70-80','80-90','90-100'})
%set(gca,'yticklabel',{'150-170','130-150','110-130','90-110','70-90','50-70','30-50','10-30'})
set(gca,'yticklabel',{'160-170','150-160','140-150','130-140','120-130','110-120','100-110','90-100','80-90','70-80','60-70','50-60','40-50','30-40','20-30','10-20','0-10'})
ylabel('Amplitude')
xlabel('Participation')
title('Change in Frequency')
pimpPlot