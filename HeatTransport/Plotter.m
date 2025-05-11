

colorScheme(1,:)=[0.4940 0.1840 0.5560];
colorScheme(2,:)=[0 0.4470 0.7410];
colorScheme(3,:)=[0.3010 0.7450 0.9330];
colorScheme(4,:)=[0.4660 0.6740 0.1880];
colorScheme(5,:)=[0.9290 0.6940 0.1250];
colorScheme(6,:)=[0.8500 0.3250 0.0980];
colorScheme(7,:)=[0.6350 0.0780 0.1840];

hkcFolder='C:\Users\rolan\Desktop\RolandsDocs\Research\2024_TRR181_3dRotatingConvectionHierarchy\SpectralCodeRepo';
saveFolder=strcat(hkcFolder,'/SavedData');
addpath(strcat(hkcFolder,'/HeatTransport'));
addpath(strcat(hkcFolder,'/ModelConstruction'));
addpath(strcat(hkcFolder,'/ModelConstruction/ModeSelection'));
addpath(strcat(hkcFolder,'/FluidSolver'));

%% generate Data 

% select parameters

Pr = 10;
k1 = 1; k2 = 1;  k3 = 1/(k1*k2);
hierNum = 3;
Mvec = [2,3,4,5,6,7,8]; %[3,4,5,6,7,8];
saveName = 1;

fig =figure;

for i=1:length(Mvec)

    M = Mvec(i);

    [hierName,diffEq,velVec,tempVec,numTempVert] = ModelSelector(hierNum,M,k1,k2);
    heatSaveFolder = strcat(saveFolder,'/',hierName,'/HeatTransport');
    if(saveName==2)
        name = strcat(heatSaveFolder,'/',diffEq,'_HeatTransport_FineRes.mat');
    elseif(saveName==1)
        name = strcat(heatSaveFolder,'/',diffEq,'_HeatTransport_SmallRay.mat');
    else
        name = strcat(heatSaveFolder,'/',diffEq,'_HeatTransport.mat');
    end
    
    if(isfile(name))
        allData = load(name);
    else
        message = strcat('Error: ',name,' not found.');
        error(message);
    end

    
    plot(allData.RaGrid(:),allData.nusseltGrid(:),'Color',colorScheme(i,:),'LineWidth',2.5); hold on;
    legendLabels{i} = strcat('\tau_2 = ',num2str(M));
end

xlim([0 5000]);
ylim([1 3.75]);
title('HKC hierarchy, S = 0'); 
fontsize(fig, 16, "points");
set(gca, 'FontName', 'SansSerif')
ylabel('Nu^{(3,\tau_2)}(Tf)', 'Rotation',0) 
xlabel('R') 
legend(legendLabels,'NumColumns',2);
