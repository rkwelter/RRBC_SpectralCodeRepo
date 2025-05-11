function [PiPhi] = PiFunc(i,j,k,phi)
%PIFUNC Summary of this function goes here
%   Detailed explanation goes here

PiPhi = phi;

if(j==k)
    PiPhi(1) = PiPhi(1) +1; PiPhi(3) = PiPhi(3) +1;
end

if(i==k)
    PiPhi(2) = PiPhi(2) +1; PiPhi(3) = PiPhi(3) +1;
end

PiPhi = mod(PiPhi,2);

end

