function [velVec,tempVec,numTempVert] = ModeSelection_Linf_PhaseLock(M,scale)
%MODE Summary of this function goes here
%   Detailed explanation goes here

numVel = 0; numTemp = 0; numTempVert = 0;
% initialize with smallest wave vector
m = [0,0,scale];

for m1=0:M
    m(1) = scale*m1; 
    for m2 = 0:M
        m(2) = scale*m2;
        for m3 = 0:M
            m(3) = scale*m3; 
            % Include all available velocity phases

            if(m(1) == 0)
                if(m(2) == 0)
                    if(m(3) > 0)
                        % No available phases 
                    end
                else
                    if(m(3) == 0)
                        velVec(numVel+1,:) = [m,1,1,1];
                        numVel = numVel+1;
                    else
                        velVec(numVel+1,:) = [m,0,0,1];
                        velVec(numVel+2,:) = [m,1,1,1];
                        numVel = numVel+2;
                    end
                end
            else
                if(m(2) == 0)
                    if(m(3) == 0)
                        velVec(numVel+1,:) = [m,1,1,1];
                        numVel = numVel+1;
                    else
                        velVec(numVel+1,:) = [m,0,0,1];
                        velVec(numVel+2,:) = [m,1,1,1];
                        numVel = numVel+2;
                    end
                else
                    if(m(3) == 0)
                        velVec(numVel+1,:) = [m,0,0,1];
                        velVec(numVel+2,:) = [m,1,1,1];
                        numVel = numVel+2;
                    else
                        velVec(numVel+1,:) = [m,0,0,1];
                        velVec(numVel+2,:) = [m,1,1,1];
                        velVec(numVel+3,:) = [m,0,0,2];
                        velVec(numVel+4,:) = [m,1,1,2];
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
                        tempVec(numTemp+1,:) = [m,0,0,1];
                        numTemp = numTemp+1;
                    end
                else
                    if(m(2) == 0)
                        tempVec(numTemp+1,:) = [m,0,0,1];
                        numTemp = numTemp+1;
                    else
                        tempVec(numTemp+1,:) = [m,0,0,1];
                        tempVec(numTemp+2,:) = [m,1,1,1];
                        numTemp = numTemp+2;
                    end
                end
            end
        end
    end
end

% Include stratified temperature variables to meet energy consistency criterion

for i = 1:(2*M)
    tempVec(numTemp+1,:) = [0,0,scale*i,0,0,1];
    numTemp = numTemp+1; numTempVert = numTempVert + 1;
end

end

