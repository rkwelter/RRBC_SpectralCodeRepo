function [velVec,tempVec,numTempVert] = ModeSelection_L1_PhaseLock(M,scale)
%MODE Summary of this function goes here
%   Detailed explanation goes here

numVel = 0; numTemp = 0; numTempVert = 0;
% initialize with smallest wave vector
m = [0,0,scale];
mMax = 0;

for l1=1:M
    
    for node=1:((l1+2)*(l1+1)/2)
        
        mNormMod2 = mod(sum(m),2);
        if(m(1) == 0)
            if(m(2) == 0)
                % These are added later
            else
                if(m(3) == 0)
                    if(mNormMod2 == 0)
                        velVec(numVel+1,:) = [m,1,1,1];
                    else
                        velVec(numVel+1,:) = [m,1,0,1];
                    end
                    numVel = numVel+1;
                else
                    if(mNormMod2 == 0)
                        velVec(numVel+1,:) = [m,0,0,1];
                        velVec(numVel+2,:) = [m,1,1,1];
                    else
                        velVec(numVel+1,:) = [m,0,1,1];
                        velVec(numVel+2,:) = [m,1,0,1];
                    end
                    numVel = numVel+2;
                end
            end
        else
            if(m(2) == 0)
                if(m(3) == 0)
                    if(mNormMod2 == 0)
                        velVec(numVel+1,:) = [m,1,1,1];
                    else
                        velVec(numVel+1,:) = [m,0,1,1];
                    end
                    numVel = numVel+1;
                else
                    if(mNormMod2 == 0)
                        velVec(numVel+1,:) = [m,0,0,1];
                        velVec(numVel+2,:) = [m,1,1,1];
                    else
                        velVec(numVel+1,:) = [m,0,1,1];
                        velVec(numVel+2,:) = [m,1,0,1];
                    end
                    numVel = numVel+2;
                end
            else
                if(m(3) == 0)
                    if(mNormMod2 == 0)
                        velVec(numVel+1,:) = [m,0,0,1];
                        velVec(numVel+2,:) = [m,1,1,1];
                    else
                        velVec(numVel+1,:) = [m,0,1,1];
                        velVec(numVel+2,:) = [m,1,0,1];
                    end
                    numVel = numVel+2;
                else
                    if(mNormMod2 == 0)
                        velVec(numVel+1,:) = [m,0,0,1];
                        velVec(numVel+2,:) = [m,1,1,1];
                        velVec(numVel+3,:) = [m,0,0,2];
                        velVec(numVel+4,:) = [m,1,1,2];
                    else
                        velVec(numVel+1,:) = [m,0,1,1];
                        velVec(numVel+2,:) = [m,1,0,1];
                        velVec(numVel+3,:) = [m,0,1,2];
                        velVec(numVel+4,:) = [m,1,0,2];
                    end
                    numVel = numVel+4;
                end
            end
        end

        % Include all available temperature phases
        if(m(3) > 0) 
            if(m(1) == 0)
                if(m(2) == 0)
                    % these are included later
                else
                    if(mNormMod2 == 0)
                        tempVec(numTemp+1,:) = [m,0,0,1];
                    else
                        tempVec(numTemp+1,:) = [m,0,1,1];
                    end
                    numTemp = numTemp+1;
                end
            else
                if(m(2) == 0)
                    if(mNormMod2 == 0)
                        tempVec(numTemp+1,:) = [m,0,0,1];
                    else
                        tempVec(numTemp+1,:) = [m,1,0,1];
                    end
                    numTemp = numTemp+1;
                else
                    if(mNormMod2 == 0)
                        tempVec(numTemp+1,:) = [m,0,0,1];
                        tempVec(numTemp+2,:) = [m,1,1,1];
                    else
                        tempVec(numTemp+1,:) = [m,0,1,1];
                        tempVec(numTemp+2,:) = [m,1,0,1];
                    end
                    numTemp = numTemp+2;
                end
            end
        end

        % Update wave vector

        if(m(3)==0)
            if(m(2)==0)
                m = [0,0,(l1+1)*scale];
            else
                m(3) = m(2)-scale;
                m(2) = 0;
                m(1) = m(1)+scale;
            end
        else
            m(3) = m(3)-scale;
            m(2) = m(2)+scale;
        end
    end
end

% Include stratified temperature and velocity variables to meet energy consistency and vorticity consistency criteria

if(M ==1)
    velVec(numVel+1,:) = [0,0,scale,0,1,1];
    velVec(numVel+2,:) = [0,0,scale,1,0,1];
    tempVec = [];
    numTemp = 0; numTempVert = 0;
    numVel = numVel+2;
else
    for m3 = 1:(M-1)
        velVec(numVel+1,:) = [0,0,(2*m3-1)*scale,0,1,1];
        velVec(numVel+2,:) = [0,0,(2*m3-1)*scale,1,0,1];
        tempVec(numTemp+1,:) = [0,0,2*m3*scale,0,0,1];
        numTemp = numTemp+1; numTempVert = numTempVert + 1;
        numVel = numVel+2;
    end
end





end

