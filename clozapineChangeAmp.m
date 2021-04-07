function[countschange,countschangepercent, countsbl,countscl] = clozapineChangeAmp(iAnimal, dBL, dCL,plot_on,edges )

infobl = dBL.(['Animal_' (num2str(iAnimal))]).handl;
timebl = dBL.(['Animal_' (num2str(iAnimal))]).Time;
infocl = dCL.(['Animal_' (num2str(iAnimal))]).handl;
timecl = dCL.(['Animal_' (num2str(iAnimal))]).Time;

%% baseline
% bin into participation
edgesp = 21:10:101;
[np,~,p]= histcounts(infobl(:,8),edgesp);
% bin into amplitude
edgesa = 0:10:171;
[ap,~,a]= histcounts(infobl(:,7),edgesa);

i = 0;
for iPart = 1:size(np,2)
    for iAmp = 1:size(ap,2)
        i = i+1;
        countsbl(18-iAmp,iPart) = sum(p==iPart & a == iAmp);
    end
end
countsbl = countsbl./timebl;

switch plot_on
    case 1
        figure
        subplot(4,1,1)
        imagesc(countsbl,[0 1])
        set(gca,'ytick',[1:18])
        set(gca,'yticklabel',171-edgesa)
        set(gca,'xticklabel',{'20-30','30-40','40-50','50-60','60-70','70-80','80-90','90-100'})
        set(gca,'yticklabel',{'160-170','150-160','140-150','130-140','120-130','110-120','100-110','90-100','80-90','70-80','60-70','50-60','40-50','30-40','20-30','10-20','0-10'})
        ylabel('Amplitude')
        xlabel('Participation')
        title(['Animal_' (num2str(iAnimal)) 'baseline'] )
    case 0
end


%% clozapine

% bin into participation
edgesp = 21:10:101;
[np,~,p]= histcounts(infocl(:,8),edgesp);
% bin into amplitude
edgesa = 0:10:171;
[ap,~,a]= histcounts(infocl(:,7),edgesa);

i = 0;
for iPart = 1:size(np,2)
    for iAmp = 1:size(ap,2)
        i = i+1;
        countscl(18-iAmp,iPart) = sum(p==iPart & a == iAmp);
    end
end
countscl = countscl./timecl;
switch plot_on
    case 1
        subplot(4,1,2)
        imagesc(countscl,[0 2])
        set(gca,'ytick',[1:18])
        set(gca,'xticklabel',{'20-30','30-40','40-50','50-60','60-70','70-80','80-90','90-100'})
        %set(gca,'yticklabel',{'150-170','130-150','110-130','90-110','70-90','50-70','30-50','10-30'})
        set(gca,'yticklabel',171-edgesa)
        ylabel('Amplitude')
        xlabel('Participation')
        title(['Animal_' (num2str(iAnimal)) 'clozapine'] )
    case 0
end

%% plot change

countschange = countscl- countsbl;
switch plot_on
    case 1
        subplot(4,1,3)
        imagesc(countschange,[-1 1])
        set(gca,'ytick',[1:18])
        set(gca,'xticklabel',{'20-30','30-40','40-50','50-60','60-70','70-80','80-90','90-100'})
        %set(gca,'yticklabel',{'150-170','130-150','110-130','90-110','70-90','50-70','30-50','10-30'})
        set(gca,'yticklabel',171-edgesa)
        ylabel('Amplitude')
        xlabel('Participation')
        title(['Animal_' (num2str(iAnimal)) 'change'] )
    case 0
end

%% plot change

countschangepercent = (countscl- countsbl)./countsbl*100;
countschangepercent(isinf(countschangepercent))= nan;

switch plot_on
    case 1
        subplot(4,1,4)
        imagesc(countschangepercent,[0 200])
        set(gca,'xticklabel',{'20-30','30-40','40-50','50-60','60-70','70-80','80-90','90-100'})
        set(gca,'yticklabel',{'150-170','130-150','110-130','90-110','70-90','50-70','30-50','10-30'})
        ylabel('Amplitude')
        xlabel('Participation')
        title(['Animal_' (num2str(iAnimal)) 'change'] )
    case 0
end

end
