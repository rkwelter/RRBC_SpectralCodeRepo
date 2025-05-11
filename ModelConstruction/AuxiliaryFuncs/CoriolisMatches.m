function [CorMatches] = CoriolisMatches(velVec)
%CORIOLISMATCHES Summary of this function goes here
%   Detailed explanation goes here

CorMatches = -1*ones(size(velVec,1),1);

for i=1:size(velVec,1)
    n=velVec(i,:);
    if(n(3) > 0)
        for j=1:size(velVec,1)
            nt = velVec(j,:);
            if(min(n(1:3) == nt(1:3)) && mod(n(4)+1,2) == nt(4) && mod(n(5)+1,2) == nt(5))
                if((sum(n(1:3) > 0) == 3 && n(6) ~= nt(6)) || sum(n(1:3) > 0) < 3)
                    CorMatches(i) = j;
                end
            end
        end
    end
end



end

