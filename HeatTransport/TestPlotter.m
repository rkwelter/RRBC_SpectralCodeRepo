
hkcFolder='C:\Users\rolan\Desktop\RolandsDocs\Research\2024_TRR181_3dRotatingConvectionHierarchy\SpectralCodeRepo';
saveFolder=strcat(hkcFolder,'/SavedData');
addpath(strcat(hkcFolder,'/HeatTransport'));
addpath(strcat(hkcFolder,'/ModelConstruction'));
addpath(strcat(hkcFolder,'/ModelConstruction/ModeSelection'));
addpath(strcat(hkcFolder,'/FluidSolver')); 
addpath(strcat(hkcFolder,'/FluidSolver/TimeSteppers/'));

%% generate Data 

% select parameters

Pr = 10;
Ro = 0;
%Ra = 5000;
k1 = 1; k2 = 1;  k3 = 1/(k1*k2);
varVec = [500:100:1000,1500:500:5000]; % [500:100:1000,1500:500:5000]; %[700:100:1000,1500:500:5000]; % Rayleigh values
%varVec = [50:50:400]; % Rotation values
hierNum = 2; M = 8; scale = 1;
errTol = 10^(-3);
initTime = 10^2; extTime = 2*10^2; tInc=10^(-4);
extendLimit = 1; % extendLimit sets a maximum number of iterations that the solver continues a trajectory if the variation in the heat transport remains large

[hierName,diffEq,velVec,tempVec,numTempVert] = ModelSelector(hierNum,M,k1,k2);
fig = figure;
list = [1,3,5,7,9,11,13,14]

for k=1:8 %length(varVec)

    i = list(k);
    Ra = varVec(i)
    extensions = 0;

    for j=1:1 %length(RaVec)
        
        %Ra = RaVec(j);
        name = strcat(saveFolder,'/',hierName,'/Trajectories/Prandtl_10/',diffEq,'_Ra_',num2str(Ra),'_Ro_',num2str(Ro),'.mat');

        if(isfile(name))
            allData = load(name);
            X = allData.X;
            parameters = allData.parameters;
            Tf = parameters(9);
            tInc = parameters(8);
            if(isfield(allData,'nusselt'))
                nusselt = allData.nusselt;
                stratNusselt = allData.stratNusselt;
                limitStdDevPercent = allData.limitStdDevPercent;
            else
                nusselt = [];
                limitStdDevPercent = 1;
            end
            addTime = extTime*tInc;
        else
            error('No file');
        end 
        
        t = (0:tInc:Tf)';
        plot(t,stratNusselt-nusselt,'LineWidth',2.5); hold on;
        legendLabels{k} = strcat('R = ',num2str(Ra));
    end
end

xlim([0 5.5]);
ylim([-0.5 3]);
title('L^1 hierarchy, \tau_2 = 8'); 
fontsize(fig, 16, "points");
set(gca, 'FontName', 'SansSerif')
ylabel('Nu^{\tau}(t)', 'Rotation',0) 
xlabel('t') 
legend(legendLabels,'NumColumns',2);
