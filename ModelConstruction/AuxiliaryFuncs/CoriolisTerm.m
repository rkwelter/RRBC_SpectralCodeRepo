function [coriolisString] = CoriolisTerm(n,k1,k2,coupleIndex)
%CORIOLISTERM Summary of this function goes here
%   Detailed explanation goes here

nu = NuFunc(n);
nt=n; nt(4) = mod(n(4)+1,2); nt(5) = mod(n(5)+1,2);
if(sum(n(1:3)>0) == 3)
    nt(6) = mod(n(6),2) + 1; 
end
t1 = GmatCoef(nt,k1,k2,2)*GmatCoef(n,k1,k2,1)*nu(1);
t2 = GmatCoef(nt,k1,k2,1)*GmatCoef(n,k1,k2,2)*nu(2);
coef = (t1-t2)/(NormGm(nt,k1,k2)*NormGm(n,k1,k2));

if(coupleIndex == -1 || coef == 0 )
    coriolisString = '';
else
    coriolisString =strcat('+Pr*Ro*(',num2str(coef),')*X(',num2str(coupleIndex),')');
end

end

