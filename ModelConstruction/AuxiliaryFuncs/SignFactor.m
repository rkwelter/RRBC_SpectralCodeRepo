function [signFactor] = SignFactor(n,np,npp,i,j)
%SIGNFACTOR Summary of this function goes here
%   Detailed explanation goes here

x1Factor = SigmaFunc([n(1),np(1),npp(1)],PiFunc(i,j,1,[n(4),np(4),npp(4)]));
x2Factor = SigmaFunc([n(2),np(2),npp(2)],PiFunc(i,j,2,[n(5),np(5),npp(5)]));
x3Factor = SigmaFunc([n(3),np(3),npp(3)],PiFunc(i,j,3,[0,0,0]));

signFactor = SignFactor_Deriv(npp(4:5),i,j)*x1Factor*x2Factor*x3Factor;

end

