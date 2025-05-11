%% HeatTransport_Assembler by Roland Welter
% 
% Combines the heat transport data from a large number of trajectories into
% a single heatTransportGrid variable

%clear all, close all, clc

codeFolder='C:\Users\rolan\Desktop\RolandsDocs\Research\2024_TRR181_3dRotatingConvectionHierarchy\SpectralCodeRepo';
saveFolder=strcat(codeFolder,'/SavedData');
addpath(strcat(codeFolder,'/HeatTransport'));
addpath(strcat(codeFolder,'/ModelConstruction/ModeSelection'));
addpath(strcat(codeFolder,'/ModelConstruction'));
addpath(strcat(codeFolder,'/FluidSolver'));

%% generate Data 

% select parameters

Pr = 10;
%Ro = 0;
k1 = 1; k2 = 1;  k3 = 1/(k1*k2);
RaVec = [1,50:50:500,600:100:1000,1500:500:10000];
RoVec = 0;%[0:50:400];
hierNum = 3; M = 1;
errTol = 10^(-3);
saveName = 1;

[hierName,diffEq,velVec,tempVec,numTempVert] = ModelSelector(hierNum,M,k1,k2);

% build grid

RaGrid = ones(length(RaVec),length(RoVec));
RoGrid = ones(length(RaVec),length(RoVec));

for i =1:length(RaVec)
    for j =1:length(RoVec)
        RaGrid(i,j) = RaVec(i);
        RoGrid(i,j) = RoVec(j);
    end
end

nusseltGrid = zeros(length(RaVec),length(RoVec));
stratNusseltGrid = zeros(length(RaVec),length(RoVec));
limitStdDevPercentGrid = ones(length(RaVec),length(RoVec));

% Integrate

for i=1:length(RaVec)
    for j =1:length(RoVec)

        trajName = strcat(saveFolder,'/',hierName,'/Trajectories/Prandtl_',num2str(Pr),'/',diffEq,'_Ra_',num2str(RaVec(i)),'_Ro_',num2str(RoVec(j)),'.mat');
            
        if(isfile(trajName))
            allData = load(trajName);
            nusseltGrid(i,j) = allData.nusselt(end);
            stratNusseltGrid(i,j) = allData.stratNusselt(end);
            limitStdDevPercentGrid(i,j) = allData.limitStdDevPercent;
        else
            message = strcat('Error: Ra ',num2str(RaVec(i)),' Ro ',num2str(RoVec(j)),' not found.');
            error(message);
        end 
    end
end

heatSaveFolder = strcat(saveFolder,'/',hierName,'/HeatTransport');

if(saveName==2)
    name = strcat(heatSaveFolder,'/',diffEq,'_HeatTransport_FineRes.mat');
elseif(saveName==1)
    name = strcat(heatSaveFolder,'/',diffEq,'_HeatTransport_SmallRay.mat');
else
    name = strcat(heatSaveFolder,'/',diffEq,'_HeatTransport.mat');
end


if(isfolder(heatSaveFolder))
    save(name,'M','RaGrid','Pr','k1','k2','RoGrid','nusseltGrid','stratNusseltGrid','limitStdDevPercentGrid');
elseif(mkdir(heatSaveFolder))
    save(name,'M','RaGrid','Pr','k1','k2','RoGrid','nusseltGrid','stratNusseltGrid','limitStdDevPercentGrid');
else
    error('Folder creation failed.');
end

