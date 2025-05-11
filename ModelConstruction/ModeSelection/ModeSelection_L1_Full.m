function [velVec,tempVec,numTempVert] = ModeSelection_L1_Full(M,scale)
%MODE Summary of this function goes here
%   Detailed explanation goes here

numVel = 0; numTemp = 0; numTempVert = 0;
% initialize with smallest wave vector
m = [0,0,scale];
mMax = 0;

for l1=1:M
    
    for node=1:((l1+2)*(l1+1)/2)

        % Include all available velocity phases
        if(m(1) == 0)
            if(m(2) == 0)
                % These are added later
            else
                if(m(3) == 0)
                    velVec(numVel+1,:) = [m,1,0,1];
                    velVec(numVel+2,:) = [m,1,1,1];
                    numVel = numVel+2;
                else
                    velVec(numVel+1,:) = [m,0,0,1];
                    velVec(numVel+2,:) = [m,0,1,1];
                    velVec(numVel+3,:) = [m,1,0,1];
                    velVec(numVel+4,:) = [m,1,1,1];
                    numVel = numVel+4;
                end
            end
        else
            if(m(2) == 0)
                if(m(3) == 0)
                    velVec(numVel+1,:) = [m,0,1,1];
                    velVec(numVel+2,:) = [m,1,1,1];
                    numVel = numVel+2;
                else
                    velVec(numVel+1,:) = [m,0,0,1];
                    velVec(numVel+2,:) = [m,0,1,1];
                    velVec(numVel+3,:) = [m,1,0,1];
                    velVec(numVel+4,:) = [m,1,1,1];
                    numVel = numVel+4;
                end
            else
                if(m(3) == 0)
                    velVec(numVel+1,:) = [m,0,0,1];
                    velVec(numVel+2,:) = [m,0,1,1];
                    velVec(numVel+3,:) = [m,1,0,1];
                    velVec(numVel+4,:) = [m,1,1,1];
                    numVel = numVel+4;
                else
                    velVec(numVel+1,:) = [m,0,0,1];
                    velVec(numVel+2,:) = [m,0,1,1];
                    velVec(numVel+3,:) = [m,1,0,1];
                    velVec(numVel+4,:) = [m,1,1,1];
                    velVec(numVel+5,:) = [m,0,0,2];
                    velVec(numVel+6,:) = [m,0,1,2];
                    velVec(numVel+7,:) = [m,1,0,2];
                    velVec(numVel+8,:) = [m,1,1,2];
                    numVel = numVel+8;
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
                    tempVec(numTemp+2,:) = [m,0,1,1];
                    numTemp = numTemp+2;
                end
            else
                if(m(2) == 0)
                    tempVec(numTemp+1,:) = [m,0,0,1];
                    tempVec(numTemp+2,:) = [m,1,0,1];
                    numTemp = numTemp+2;
                else
                    tempVec(numTemp+1,:) = [m,0,0,1];
                    tempVec(numTemp+2,:) = [m,0,1,1];
                    tempVec(numTemp+3,:) = [m,1,0,1];
                    tempVec(numTemp+4,:) = [m,1,1,1];
                    numTemp = numTemp+4;
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
    tempVec(numTemp+1,:) = [0,0,scale,0,0,1];
    numTemp = numTemp+1; numTempVert = numTempVert + 1;
else
    for m3 = 1:(2*(M-1))
        tempVec(numTemp+1,:) = [0,0,m3*scale,0,0,1];
        numTemp = numTemp+1; numTempVert = numTempVert + 1;
    end
end

if(M ==1)
    velVec(numVel+1,:) = [0,0,scale,0,1,1];
    velVec(numVel+2,:) = [0,0,scale,1,0,1];
    numVel = numVel+2;
elseif(M==2)
    for m3 = 1:2
        velVec(numVel+1,:) = [0,0,m3*scale,0,1,1];
        velVec(numVel+2,:) = [0,0,m3*scale,1,0,1];
        numVel = numVel+2;
    end
else
    for m3 = 1:(2*M-3)
        velVec(numVel+1,:) = [0,0,m3*scale,0,1,1];
        velVec(numVel+2,:) = [0,0,m3*scale,1,0,1];
        numVel = numVel+2;
    end
end





end

