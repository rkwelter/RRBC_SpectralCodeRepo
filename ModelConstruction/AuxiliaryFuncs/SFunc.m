function [sign] = SFunc(a1,a2,a3)
%SFUNC Summary of this function goes here
%   Detailed explanation goes here

if(a1 == a2+a3)
    sign = -1;
else
    sign = 1;
end

end

