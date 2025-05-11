function [velVec,tempVec,numTempVert] = ModeSelection_EnergyInconsis(M,scale)
%MODE Summary of this function goes here
%   Detailed explanation goes here

if(M == 1)
    numTempVert = 1;
    velVec = [1,0,1,0,0,1;
              3,0,1,0,0,1;
              2,0,2,0,0,1];
    tempVec = [1,0,1,0,0,1;
               3,0,1,0,0,1;
               2,0,2,0,0,1;
               0,0,4,0,0,1];
elseif(M == 2)
    numTempVert = 2;
    velVec = [1,0,1,0,0,1;
              1,0,3,0,0,1;
              2,0,2,0,0,1];
    tempVec = [1,0,1,0,0,1;
               1,0,3,0,0,1;
               2,0,2,0,0,1;
               0,0,4,0,0,1;
               0,0,6,0,0,1];
elseif(M == 3)
    numTempVert = 1;
    velVec = [1,1,1,0,0,1;
              2,0,2,0,0,1];
    tempVec = [1,1,1,0,0,1;
               2,0,2,0,0,1;
               0,0,4,0,0,1];
else
    error('Model not defined');
end


end

