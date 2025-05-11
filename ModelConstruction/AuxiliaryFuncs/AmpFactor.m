function [ampFactor] = AmpFactor(n,np,npp,i,j)
%AMPFACTOR Summary of this function goes here
%   Detailed explanation goes here

ampPower1 = AFunc([n(1),np(1),npp(1)],PiFunc(i,j,1,[n(4),np(4),npp(4)]));
ampPower2 = AFunc([n(2),np(2),npp(2)],PiFunc(i,j,2,[n(5),np(5),npp(5)]));
ampPower3 = AFunc([n(3),np(3),npp(3)],PiFunc(i,j,3,[0,0,0]));

totalPower = ampPower1 + ampPower2 + ampPower3;

if(totalPower >= 0)
    ampFactor = 2^(-totalPower);
else
    ampFactor = 0;
end

end

