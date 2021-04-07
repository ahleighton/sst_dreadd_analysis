function[] = allFreqsbyPart(nD, dBL, dCL, nC, cBL, cCL)
%% frequency (in events per minute) of each participation bin

edges = [20:10:101];
% dreadd baseline
for iAnimal = 1:nD
    [nbl] = histcounts(dBL.(['Animal_' (num2str(iAnimal))]).all(:,8),edges)./dBL.(['Animal_' (num2str(iAnimal))]).Time;
    [ncl] = histcounts(dCL.(['Animal_' (num2str(iAnimal))]).all(:,8),edges)./dCL.(['Animal_' (num2str(iAnimal))]).Time;
    allFreqsbld(iAnimal,:) = nbl;
    allFreqscld(iAnimal,:) = ncl;
end

% control baseline
for iAnimal = 1:nC
    [nbl] = histcounts(cBL.(['Animal_' (num2str(iAnimal))]).all(:,8),edges)./cBL.(['Animal_' (num2str(iAnimal))]).Time;
    [ncl] = histcounts(cCL.(['Animal_' (num2str(iAnimal))]).all(:,8),edges)./cCL.(['Animal_' (num2str(iAnimal))]).Time;  
    allFreqsblc(iAnimal,:) = nbl;
    allFreqsclc(iAnimal,:) = ncl;    
end

%% bar of participation frequencies dreadd
x1= 0.85:1:7.85;
x2= 1.15:1:8.15;
 
figure
subplot(2,1,1)
bar([mean(allFreqsbld); mean(allFreqscld)]')%; mean(allFreqsblc); mean(allFreqsclc)]')
hold on;
for i = 1:size(allFreqsbld,2)
    plot([i-0.15 i+0.15],[allFreqsbld(:,i) allFreqscld(:,i)], '-')
end

legend({'Dreadd + BL', 'Dreadd + CL'})
%set(gca,'xtick',1:8)
set(gca,'Xticklabel',{'20-30', '30-40','40-50', '50-60','60-70','70-80','80-90', '90-100'} )
%set(gca,'Xticklabel',{'20-30', '30-40','40-50', '50-60','60-70','70-80','80-90', '90-100'} )
pimpPlot
xlabel('Participation (DREADD)')
ylabel('Frequency (events/min)')
ylim([0 6])

%% 
subplot(2,1,2)
bar([mean(allFreqsblc); mean(allFreqsclc)]')%; mean(allFreqsblc); mean(allFreqsclc)]')
hold on;
for i = 1:size(allFreqsblc,2)
    plot([i-0.15 i+0.15],[allFreqsblc(:,i) allFreqsclc(:,i)])
end

legend({'Dreadd + BL', 'Dreadd + CL'})
%set(gca,'xtick',1:8)
set(gca,'Xticklabel',{'0-10','10-20','20-30', '30-40','40-50', '50-60','60-70','70-80','80-90', '90-100'} )
pimpPlot
xlabel('Participation (CONTROL)')
ylabel('Frequency (events/min)')
ylim([0 6])