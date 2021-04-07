function[]= allSSTamp(nD, dBL, dCL, nC, cBL, cCL)

for iAnimal = 1:nD
    bd(iAnimal,1) = nanmean(dBL.(['Animal_' (num2str(iAnimal))]).handl(:,7));
    cd(iAnimal,1) = nanmean(dCL.(['Animal_' (num2str(iAnimal))]).handl(:,7));
end

for iAnimal = 1:nC
    bc(iAnimal,1) = nanmean(cBL.(['Animal_' (num2str(iAnimal))]).handl(:,7));
    cc(iAnimal,1) = nanmean(cCL.(['Animal_' (num2str(iAnimal))]).handl(:,7));
end

figure
bar([nanmean(bd) mean(cd) ; mean(bc) mean(cc)])
set(gca,'xticklabel',{'Dreadds', 'Controls'})
hold on
plot([0.85 1.15], [bd cd],'-')
plot([1.85 2.15], [bc cc],'-')
legend({'Baseline','Clozapine'})
pimpPlot
title('Amplitude')