function [coef] = GmatCoef(n,k1,k2,comp)
%GMATRIXCOEFS Summary of this function goes here
%   Detailed explanation goes here

m = n(1:3);
k3 = 1/(k1*k2);
gamma = [1 1 -1];
Km = [k1*m(1) k2*m(2) k3*m(3)];
Gmat1 = cross(gamma,Km);
Gmat2 = cross(Km,Gmat1);

if(comp == 1)
    signFactor = (-1)^(n(4));
elseif(comp == 2)
    signFactor = (-1)^(n(5));
elseif(comp == 3)
    signFactor = 1;
else
    error('Unrecognized component for G matrix')
end

if(n(6) == 1)
    coef = Gmat1(comp);
else
    coef = Gmat2(comp);
end

coef = coef*signFactor;

end

