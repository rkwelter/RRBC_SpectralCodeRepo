function [velTriples,tempTriples] = CompatibleTriples(velVec,tempVec)
%COMPATIBLETRIPLES Summary of this function goes here
%   Detailed explanation goes here

velTriples = cell(size(velVec,1),1);
tempTriples = cell(size(tempVec,1),1);

for i = 1:size(velVec,1)
    for j = 1:size(velVec,1)
        for k = 1:size(velVec,1)
            indexCond = CompatibilityTest(velVec(i,:),velVec(j,:),velVec(k,:));
            if(indexCond>0)
                velTriples{i} = [velTriples{i}; j,k ]; 
            end
        end
    end
end

for i = 1:size(tempVec,1)
    for j = 1:size(velVec,1)
        for k = 1:size(tempVec,1)
            indexCond = CompatibilityTest(tempVec(i,:),velVec(j,:),tempVec(k,:));
            if(indexCond>0)
                tempTriples{i} = [tempTriples{i}; j,k ]; 
            end
        end
    end
end

end

