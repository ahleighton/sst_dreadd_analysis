function[] = scatterAmpvsPart(nX, xBL, xCL)
figure
for iAnimal = 1:nX
    figure
    scatter(xBL.(['Animal_' (num2str(iAnimal))]).handl(:,8),xBL.(['Animal_' (num2str(iAnimal))]).handl(:,7),'b')
    maxed_before(iAnimal,1) = sum(xBL.(['Animal_' (num2str(iAnimal))]).handl(:,8)==100)
    hold on
    scatter(xCL.(['Animal_' (num2str(iAnimal))]).handl(:,8),xCL.(['Animal_' (num2str(iAnimal))]).handl(:,7), 'r')
    maxed_after(iAnimal,1) = sum(xCL.(['Animal_' (num2str(iAnimal))]).handl(:,8)==100)
end

pimpPlot
xlabel('Participation')
ylabel('Amplitude')
legend({'Before', 'After'})

disp('Number of 100% participation events, before')
sum(maxed_before)
disp('Number of 100% participation events, after')
sum(maxed_after)
