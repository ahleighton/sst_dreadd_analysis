%% SST 
btm = pwd;
edges = [20:10:101];

% collect dreadd expressing and control animals 
cd([btm '\Dreadd'])
[nD, dBL, dCL] = collectAnimals();
cd([btm '\Control'])
[nC, cBL, cCL] = collectAnimals();
cd(btm)

%% scatter amplitude vs participation (all animals)

scatterAmpvsPart(nD, dBL, dCL)
title('Participation vs Amplitude, before and after clozapine, DREADD expressing')

scatterAmpvsPart(nC, cBL, cCL)
title('Participation vs Amplitude, before and after clozapine, CONTROL animals')

% binned into 20% participation
binAmpPartScatter(nD, dBL, dCL, edges)

AmpsbyPart(nD, dBL, dCL, nC, cBL, cCL)
%% is there a change in Frequency after applying clozapine?

% frequency split into participation bin
allFreqsbyPart(nD, dBL, dCL, nC, cBL, cCL)


%% is there a change in Amplitude after applying clozapine?

allSSTamp(nD, dBL, dCL,nC, cBL, cCL)


%% bin amplitude and participation before after and change

allcountchangedC= heatMapClchange(nD,dBL,dCL)

allcountchangedC= heatMapClchange(nC,cBL,cCL)




