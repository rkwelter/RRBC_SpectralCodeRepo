function [sign] = SignFactor_Deriv(phase,i,j)
%SIGNFACTOR_DERIV Summary of this function goes here
%   Detailed explanation goes here

if(i==1)
    sign = (-1)^(phase(1));
elseif(i==2)
    sign = (-1)^(phase(2));
elseif(i==3)
    sign = 1;
else
    error('Unrecognized component.')
end

if(j ~= i)
    sign = -sign;
end

end

