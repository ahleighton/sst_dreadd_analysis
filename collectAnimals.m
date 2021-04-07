function[nA, xBL, xCL] = collectAnimals()
btm = pwd;
animalList = dir();
animalList = animalList(3:end);
restrictTo30 = 6; 

xBL = struct;
xCL = struct;
nA = size(animalList,1);
for iAnimal = 1:nA
    cd([btm '\' num2str(animalList(iAnimal).name)])
    load('InfoBurstsBL.mat');load('InfoBurstsCL.mat');    
    xBL.(['Animal_' num2str(iAnimal)]) = InfoBurstsBL;
    xCL.(['Animal_' num2str(iAnimal)])  = InfoBurstsCL;
end

cd(btm)