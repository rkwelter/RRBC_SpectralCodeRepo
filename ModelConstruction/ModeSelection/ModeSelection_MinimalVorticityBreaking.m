function [velVec,tempVec,numTempVert] = ModeSelection_MinimalVorticityBreaking(M)
%MODE Summary of this function goes here
%   Detailed explanation goes here

if(M == 1)
    numTempVert = 2;

    velVec = [1,0,1,0,0,1;
              1,0,2,1,0,1;
              0,0,1,1,0,1];
    tempVec = [1,0,1,0,0,1;
               1,0,2,1,0,1;
               0,0,2,0,0,1;
               0,0,4,0,0,1;];
elseif(M==2)
    numTempVert = 2;

    velVec = [1,0,1,0,0,1;
              1,0,2,1,0,1;
              0,0,1,1,0,1;
              0,0,3,1,0,1;];
    tempVec = [1,0,1,0,0,1;
               1,0,2,1,0,1;
               0,0,2,0,0,1;
               0,0,4,0,0,1;];
else
    error('Unrecognized model number');
end

end

