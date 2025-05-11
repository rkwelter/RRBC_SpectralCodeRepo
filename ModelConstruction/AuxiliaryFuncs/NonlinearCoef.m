function [coef] = NonlinearCoef(n,np,npp,kVec,varType)
%NONLINEARTERM Summary of this function goes here
%   Detailed explanation goes here

coef = 0;
k1 = kVec(1); k2 = kVec(2);

if(strcmp(varType,'vel'))
    for i=1:3
        deriv = kVec(i)*npp(i);
        for j=1:3
            newTerm = GmatCoef(n,k1,k2,j)*GmatCoef(np,k1,k2,i)*GmatCoef(npp,k1,k2,j);
            newTerm = newTerm*deriv*AmpFactor(n,np,npp,i,j)*SignFactor(n,np,npp,i,j);
            coef = coef + newTerm;
        end
    end
    coef = coef/(NormGm(n,k1,k2)*NormGm(np,k1,k2)*NormGm(npp,k1,k2));
    coef = coef/(2^((sum(n(1:3)>0)+sum(np(1:3)>0)+sum(npp(1:3)>0))/2-2)*pi^(3/2));
elseif(strcmp(varType,'temp'))
    for i=1:3
        deriv = kVec(i)*npp(i);
        newTerm = GmatCoef(np,k1,k2,i);
        newTerm = newTerm*deriv*AmpFactor(n,np,npp,i,3)*SignFactor(n,np,npp,i,3);
        coef = coef + newTerm;
    end
    coef = coef/(NormGm(np,k1,k2));
    coef = coef/(2^((sum(n(1:3)>0)+sum(np(1:3)>0)+sum(npp(1:3)>0))/2-2)*pi^(3/2));
else
    error('Unrecognized variable type')
end


end

