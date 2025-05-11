function [velVec,tempVec,numTempVert] = ModeSelection_HKC(M)
%MODE Summary of this function goes here
%   Detailed explanation goes here

numVel = 0; numTemp = 0; numTempVert = 0;
% initialize with smallest wave vector
m = [1,0,1];
mMax = 1;

for i=1:M
    
    for j = 1:i
        % Adjoin interior modes and select phase based on wavenumber
    
        p1 = mod(sum(m),2);
        pt1 = mod(1+sum(m),2);
    
        velVec(numVel+1,:) = [m,p1,0,1];
        velVec(numVel+2,:) = [m,pt1,1,1];
        tempVec(numTemp+1,:) = [m,p1,0,1];
        numVel = numVel+2; numTemp = numTemp+1;

        if(m(1)==1 && m(3) > 1)
            velVec(numVel+1,:) = [m(3)-1,0,0,mod(m(3)+1,2),1,1];
            numVel = numVel+1; 
        end

        % Update wave vector

        if(j < M)
            if(m(3)==1)
                mMax = mMax+1;
                m = [1,0,mMax];
            else
                m(3) = m(3)-1;
                m(1) = m(1)+1;
            end
        end
    end
end

% Include stratified temperature variables to meet energy consistency criterion

for i = 1:(mMax)
    tempVec(numTemp+1,:) = [0,0,2*i,0,0,1];
    velVec(numVel+1,:) = [0,0,2*i-1,0,1,1];
    velVec(numVel+2,:) = [0,0,2*i-1,1,0,1];
    numVel = numVel+2; numTemp = numTemp+1; numTempVert = numTempVert + 1;
end

end

