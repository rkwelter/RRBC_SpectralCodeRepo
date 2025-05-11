function [sign] = SigmaFunc(mu,xi)
%SIGMAFUNC Summary of this function goes here
%   Detailed explanation goes here

if(xi(1) == 0 && xi(2) == 0 && xi(3) == 0)
    sign = 1;
elseif(xi(1) == 0 && xi(2) == 1 && xi(3) == 1)
    sign = SFunc(mu(1),mu(2),mu(3));
elseif(xi(1) == 1 && xi(2) == 0 && xi(3) == 1)
    sign = SFunc(mu(2),mu(3),mu(1));
elseif(xi(1) == 1 && xi(2) == 1 && xi(3) == 0)
    sign = SFunc(mu(3),mu(1),mu(2));
else
    error('Inadmissible phase triad');
end

end

