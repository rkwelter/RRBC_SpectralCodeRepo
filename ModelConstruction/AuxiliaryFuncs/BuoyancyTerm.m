function [buoyancyString] = BuoyancyTerm(n,k1,k2,varType,numVel,coupleIndex)
%BUOYANCYTERM Summary of this function goes here
%   Detailed explanation goes here

    nu = NuFunc(n);
    coef1 = GmatCoef(n,k1,k2,3)/NormGm(n,k1,k2);

    if(strcmp(varType,'vel'))
        if(nu(3) == 0 || coef1 == 0 || coupleIndex == -1)
            buoyancyString = '';
        else
            buoyancyString = strcat('+Pr*Ra*(',num2str(coef1),')*X(',num2str(numVel+coupleIndex),')');
        end
    elseif(strcmp(varType,'temp'))
        if(nu(3) == 0 || max(coupleIndex) == -1)
            buoyancyString = '';
        else
            if(coef1 == 0) 
                buoyancyString = '';
            else
                buoyancyString = strcat('+(',num2str(coef1),')*X(',num2str(coupleIndex(1)),')');
            end
            if(coupleIndex(2) > -1)
                n(6) = 2;
                coef2 = GmatCoef(n,k1,k2,3)/NormGm(n,k1,k2);
                if(coef2 ~= 0 ) 
                    buoyancyString = strcat(buoyancyString,'+(',num2str(coef2),')*X(',num2str(coupleIndex(2)),')');
                end
            end
        end
    else
       error('Unrecognized var type');
    end
    

end

