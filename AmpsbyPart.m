function[] = AmpsbyPart(nD, dBL, dCL, nC, cBL, cCL)

%% amplitude (in events per minute) of each participation bin

edges = [1:10:101];
% dreadd
for iAnimal = 1:nD
    [nbl,~,binsbl] = histcounts(dBL.(['Animal_' (num2str(iAnimal))]).all(:,8),edges);
    [ncl,~,binscl] = histcounts(dCL.(['Animal_' (num2str(iAnimal))]).all(:,8),edges);    
    
    for iBin = 1:size(edges,2)-1
        allAmpsbld(iAnimal,iBin) = nanmean(dBL.(['Animal_' (num2str(iAnimal))]).all(binsbl==iBin,7));
        allAmpscld(iAnimal,iBin) = nanmean(dCL.(['Animal_' (num2str(iAnimal))]).all(binscl==iBin,7));
    end
end

% control
for iAnimal = 1:nC
    [nbl,~,binsbl] = histcounts(cBL.(['Animal_' (num2str(iAnimal))]).all(:,8),edges);
    [ncl,~,binscl] = histcounts(cCL.(['Animal_' (num2str(iAnimal))]).all(:,8),edges);    
    
    for iBin = 1:size(edges,2)-1
        allAmpsblc(iAnimal,iBin) = nanmean(cBL.(['Animal_' (num2str(iAnimal))]).all(binsbl==iBin,7));
        allAmpsclc(iAnimal,iBin) = nanmean(cCL.(['Animal_' (num2str(iAnimal))]).all(binscl==iBin,7));
    end    
end

%% bar of participation amplitudes dreadd
x1= 0.85:1:7.85;
x2= 1.15:1:8.15;

%x5 =
figure
subplot(2,1,1)
bar([nanmean(allAmpsbld); nanmean(allAmpscld)]')%; mean(allFreqsblc); mean(allFreqsclc)]')
hold on;
for i = 1:size(allAmpsbld,2)
    plot([i-0.15 i+0.15],[allAmpsbld(:,i) allAmpscld(:,i)], '-o')
end

legend({'Dreadd + BL', 'Dreadd + CL'})
set(gca,'xtick',1:10)
set(gca,'Xticklabel',{'0-10','10-20','20-30', '30-40','40-50', '50-60','60-70','70-80','80-90', '90-100'} )
%set(gca,'Xticklabel',{'20-40', '40-60','60-80','80-100'} )

pimpPlot
xlabel('Participation')
ylabel('Amplitude (events/min)')

%% bar of participation amplitudes ctrl
x1= 0.85:1:7.85;
x2= 1.15:1:8.15;

%x5 =
subplot(2,1,2)
bar([nanmean(allAmpsblc); nanmean(allAmpsclc)]')%; mean(allFreqsblc); mean(allFreqsclc)]')
hold on;
for i = 1:size(allAmpsbld,2)
    plot([i-0.15 i+0.15],[allAmpsblc(:,i) allAmpsclc(:,i)], '-o')
end 

legend({'Dreadd + BL', 'Dreadd + CL'})
set(gca,'xtick',1:8)
set(gca,'Xticklabel',{'20-30', '30-40','40-50', '50-60','60-70','70-80','80-90', '90-100'} )
%set(gca,'Xticklabel',{'0-20','20-40', '40-60','60-80','80-100'} )

pimpPlot
xlabel('Participation')
ylabel('Amplitude (events/min)')


