function [hierName,diffEq] = ModelChoice(hierNum,M,k1,k2)
%MODELCHOICE Summary of this function goes here
%   Detailed explanation goes here

if(hierNum==1)
    hierName = 'linf';
elseif(hierNum==2)
    hierName = 'l1';
elseif(hierNum==3)
    hierName = 'HKC';
elseif(hierNum==4)
    hierName = 'energyInconsis';
elseif(hierNum==5)
    hierName = 'linf_full';
elseif(hierNum==6)
    hierName = 'l1_full';
elseif(hierNum==7)
    hierName = 'fourierBox';
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

diffEq = strcat(hierName,boxString,'_',num2str(M));

end

