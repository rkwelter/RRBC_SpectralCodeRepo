function [velMatches,tempMatches] = BuoyancyMatches(velVec,tempVec)
%COMPUTEMATCHES This function creates the libraries uPlusMatches, uMinusMatches, thetaMatches
% which enable one to easily determine across the uPlus, uMinus, theta
% variables which element in the combined vector X corresponds to the same
% Fourier index. 

velMatches = -1*ones(size(velVec,1),1);
tempMatches = -1*ones(size(tempVec,1),2);

for j=1:size(tempVec,1)
    nt = tempVec(j,:);
    for i=1:size(velVec,1)
        n=velVec(i,:);
        if(min(n(1:end-1) == nt(1:end-1)))
            velMatches(i) = j;
            if(n(end) == 1)
                tempMatches(j,1) = i;
            else
                tempMatches(j,2) = i;
            end
        end
    end
end

end

