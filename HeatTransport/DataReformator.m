%% Iterator by Roland Welter
% 
% Computes the heat transport for a large number of Rayleigh and rotation
% numbers by creating trajectories for each.

%clear all, close all, clc

codeFolder='C:\Users\rolan\Desktop\RolandsDocs\Research\2024_TRR181_3dRotatingConvectionHierarchy\SpectralCodeRepo';
saveFolder=strcat(codeFolder,'/SavedData');

addpath(strcat(codeFolder,'/HeatTransport'));
addpath(strcat(codeFolder,'/ModelConstruction'));
addpath(strcat(codeFolder,'/ModelConstruction/ModeSelection'));

%% generate Data 

% select parameters

Pr = 10;
%Ro = 0;
Ra = 5000;
k1 = 1; k2 = 1;  k3 = 1/(k1*k2);
varVec = 50;%[50:50:400]; % Rayleigh values
%varVec = 50:50:400;
hierNum = 1; M = 1;

%[hierName,diffEq,velVec,tempVec,numTempVert] = ModelSelector(hierNum,M,k1,k2);


for i=1:length(varVec)

    Ro = varVec(i)
    [hierName,diffEq,velVec,tempVec,numTempVert] = ModelSelector(hierNum,M,k1,k2);

    name = strcat(saveFolder,'/',hierName,'/Trajectories/Prandtl_10/',diffEq,'_Ra_',num2str(Ra),'_Ro_',num2str(Ro),'.mat');

    if(isfile(name))
        allData = load(name);
        X = allData.X;
        parameters = allData.parameters;
        limitStdDevPercent = allData.limitStdDevPercent;
        stratNusselt = (allData.stratNusselt-1)/pi+1;
        nusselt = (allData.nusselt-1)/pi+1;

        save(name,'parameters','X','stratNusselt','nusselt','limitStdDevPercent');
    else
        error(strcat('Unrecognized file ',name));
    end 
        
        
end
