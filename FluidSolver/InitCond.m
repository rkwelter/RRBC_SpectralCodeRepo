function [X0] = InitCond(hierNum,M,initString)
%INITIALCONDITIONS Defines an initial condition for a new trajectory

noise = 0.05; scale = 1;

if(hierNum==1)
    [velVec,tempVec,numTempVert] = ModeSelection_Linf_PhaseLock(M,scale);
elseif(hierNum==2)
    [velVec,tempVec,numTempVert] = ModeSelection_L1_PhaseLock(M,scale);
elseif(hierNum==3)
    [velVec,tempVec,numTempVert] = ModeSelection_HKC(M);
elseif(hierNum==4)
    [velVec,tempVec,numTempVert] = ModeSelection_EnergyInconsis(M,scale);
elseif(hierNum==5)
    [velVec,tempVec,numTempVert] = ModeSelection_Linf_Full(M,scale);
elseif(hierNum==6)
    [velVec,tempVec,numTempVert] = ModeSelection_L1_Full(M,scale);
elseif(hierNum==7)
    [velVec,tempVec,numTempVert] = ModeSelection_MinimalVorticityBreaking(M);
else
    error('Unrecognized hierarchy choice.')
end

numVel = size(velVec,1); numTemp = size(tempVec,1); 

if(strcmp(initString,'nearUniform')) % near uniform IC

    vel0 = noise*randn(numVel,1)./(velVec(:,1).^2+velVec(:,2).^2+velVec(:,3).^2);
    temp0 = noise*randn(numTemp,1)./(tempVec(:,1).^2+tempVec(:,2).^2+tempVec(:,3).^2);
    for i=1:numTempVert
        m3 = tempVec(end - numTempVert + i,3);
        temp0(end - numTempVert + i) = temp0(end - numTempVert + i) - (1 + (-1)^(m3))*sqrt(2*pi^3)/(m3);
    end

elseif(strcmp(initString,'rand')) % random IC

    vel0 = noise*randn(numVel,1)./(velVec(:,1).^2+velVec(:,2).^2+velVec(:,3).^2);
    temp0 = noise*randn(numTemp,1)./(tempVec(:,1).^2+tempVec(:,2).^2+tempVec(:,3).^2);


else

    error('Unrecognized initial condition');

end

X0=[vel0;temp0]';

end

