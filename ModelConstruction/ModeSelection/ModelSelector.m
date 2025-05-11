function [hierName,diffEq,velVec,tempVec,numTempVert] = ModelSelector(hierNum,M,k1,k2)
%MODESELECTOR Summary of this function goes here
%   Detailed explanation goes here

scale = 1; % scale can be used for studying invariant subspaces formed by lattices of Fourier modes, but the user can ignore this variable. 

if(hierNum==1)
    hierName = 'linf';
    [velVec,tempVec,numTempVert] = ModeSelection_Linf_PhaseLock(M,scale);
elseif(hierNum==2)
    hierName = 'l1';
    [velVec,tempVec,numTempVert] = ModeSelection_L1_PhaseLock(M,scale);
elseif(hierNum==3)
    hierName = 'HKC';
    [velVec,tempVec,numTempVert] = ModeSelection_HKC(M);
elseif(hierNum==4)
    hierName = 'energyInconsis';
    [velVec,tempVec,numTempVert] = ModeSelection_EnergyInconsis(M,scale);
elseif(hierNum==5)
    hierName = 'linf_full';
    [velVec,tempVec,numTempVert] = ModeSelection_Linf_Full(M,scale);
elseif(hierNum==6)
    hierName = 'l1_full';
    [velVec,tempVec,numTempVert] = ModeSelection_L1_Full(M,scale);
elseif(hierNum==7)
    hierName = 'fourierBox';
    [velVec,tempVec,numTempVert] = ModeSelection_FourierBox_PhaseLock(M);
else
    error('Unrecognized hierarchy choice.')
end
   
shape1Str = num2str(floor(k1));
if(floor(10^5*(k1 - floor(k1))) > 0)
    shape1Str = strcat(shape1Str,'_',num2str(floor(10^5*(k1 - floor(k1)))));
end
shape2Str = num2str(floor(k2));
if(floor(10^5*(k2 - floor(k2))) > 0)
    shape2Str = strcat(shape2Str,'_',num2str(floor(10^5*(k2 - floor(k2)))));
end
boxString = strcat('_k1_',shape1Str,'_k2_',shape2Str);

if(scale == 1)
    scaleString = '';
else
    scaleString = strcat('_Scale_',num2str(scale));
end

diffEq = strcat(hierName,boxString,scaleString,'_',num2str(M));

end

