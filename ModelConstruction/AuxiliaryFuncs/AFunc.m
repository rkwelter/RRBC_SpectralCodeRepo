function [ampPower] = AFunc(mu,xi)
%AFUNC Summary of this function goes here
%   Detailed explanation goes here

chi1 = (sum(xi == [0,1,1]) == 3 && (mu(2) == 0 || mu(3) == 0) );
chi2 = (sum(xi == [1,0,1]) == 3 && (mu(1) == 0 || mu(3) == 0) );
chi3 = (sum(xi == [1,1,0]) == 3 && (mu(1) == 0 || mu(2) == 0) );

if(max(mu) == 0 && max(xi) == 0)
    ampPower = 1;
elseif( chi1 || chi2 || chi3 )
    ampPower = -10;
else
    ampPower = 0;
end

end

