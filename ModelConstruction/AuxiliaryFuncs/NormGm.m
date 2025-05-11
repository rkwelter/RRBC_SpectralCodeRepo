function [norm] = NormGm(n,k1,k2)
%NORMGM Summary of this function goes here
%   Detailed explanation goes here

    nu = NuFunc(n);
    norm = sqrt( nu(1)*(GmatCoef(n,k1,k2,1))^2 + nu(2)*(GmatCoef(n,k1,k2,2))^2 + nu(3)*(GmatCoef(n,k1,k2,3))^2);

end

