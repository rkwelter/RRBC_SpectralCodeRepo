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
addpath(strcat(codeFolder,'/ModelConstruction/AuxiliaryFuncs'));
addpath(strcat(codeFolder,'/FluidSolver')); 
addpath(strcat(codeFolder,'/FluidSolver/TimeSteppers'));

%% generate Data 

% select parameters

Pr = 10;
Ro = 0;
%Ra = 5000;
k1 = 1; k2 = 1;  k3 = 1/(k1*k2);
varVec = 5*10^4;%[1,50:50:500,600:100:1000,1500:500:10000]; % Rayleigh values
hierNum = 7; M = 4;
errTol = 10^(-3);
initTime = 10^5; extTime = 10^2; tInc=10^(-4);
numInitConds = 2;
extendLimit = 1; % extendLimit sets a maximum number of iterations that the solver continues a trajectory if the variation in the heat transport remains large
saveImage = 1;

[hierName,diffEq,velVec,tempVec,numTempVert] = ModelSelector(hierNum,M,k1,k2);
[velBuoyMatches,tempBuoyMatches] = BuoyancyMatches(velVec,tempVec);

for i=1:length(varVec)

    Ra = varVec(i)
    extensions = 0;

    for j=1:numInitConds
        
        name = strcat(saveFolder,'/',hierName,'/Trajectories/Prandtl_',num2str(Pr),'/',diffEq,'_Ra_',num2str(Ra),'_Ro_',num2str(Ro),'.mat');
        if(numInitConds > 1)
            name = strcat(saveFolder,'/',hierName,'/Trajectories/Prandtl_',num2str(Pr),'/',diffEq,'_Ra_',num2str(Ra),'_Ro_',num2str(Ro),'_IC_',num2str(j),'.mat');
        end

        if(isfile(name))
            allData = load(name);
            X = allData.X;
            parameters = allData.parameters;
            tInc = parameters(8);
            Tf = parameters(9);
            t = (0:tInc:Tf)';
            if(isfield(allData,'stratNusselt'))
                stratNusselt = allData.stratNusselt;
                limitStdDevPercent = allData.limitStdDevPercent;
            else
                stratNusselt = [];
                limitStdDevPercent = 1;
            end
            addTime = extTime*tInc;
        else
            Tf = 0;
            runTime = 0;
            stratNusselt = [];
            limitStdDevPercent = 1;
            parameters = [Pr,Ro,k1,k2,Ra,hierNum,M,tInc,Tf,errTol,0];
            X0 = normrnd(0,10,1,size(velVec,1)+size(tempVec,1)); %InitCond(hierNum,M,'nearUniform');
            addTime = initTime*tInc;
            [t,X,parameters] = FluidSolver(parameters,X0,addTime);
            addTime = extTime*tInc;
        end 
        
        while(  extensions < extendLimit ) %limitStdDevPercent > .02 &&
            [t,X,parameters] = FluidSolver(parameters,X,addTime,0);
            Tf = parameters(9);
            
            % Compute Nusselt integrand
            
            NusseltIntegrand = tempVec(end - numTempVert+1,3)*X(:,end - numTempVert+1);
            if(numTempVert > 1)
                for ell=2:numTempVert
                    NusseltIntegrand = NusseltIntegrand + tempVec(end - numTempVert+ell,3)*X(:,end - numTempVert+ell);
                end
            end
            
            stratNusselt = 1-k3*tInc*cumsum(NusseltIntegrand)./(sqrt(2)*pi^(5/2)*t);
            limitStdDevPercent = std(stratNusselt(floor(end/2):end))/stratNusselt(end);
            extensions = extensions + 1;
        end
        
        nusselt = Nusselt(X,t,tInc,velVec,velBuoyMatches,k1,k2);
        %diff = mean(abs(stratNusselt(floor(end/2):end) - nusselt(floor(end/2):end)))/nusselt(end)
        save(name,'parameters','X','stratNusselt','nusselt','limitStdDevPercent');
        extensions = 0;
        if(saveImage)
            plot(t,nusselt,'LineWidth',1.75); xlim([0 Tf]); title(strcat('\tau_2 = ',num2str(M),', Ra = ',num2str(Ra))); hold on;
            ylabel(['Nu^{(box,1)}(t)'], 'Rotation',0); 
            xlabel('t');
            fontsize(16,"points");
            saveas(gcf,strcat('../SavedImages/HeatTransportConvergence/',diffEq,'_Ra_',num2str(Ra),'_Ro_',num2str(Ro),'.fig'));
        end
    end
end
