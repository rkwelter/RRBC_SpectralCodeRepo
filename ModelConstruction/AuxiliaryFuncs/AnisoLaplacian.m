function [laplacian] = AnisoLaplacian(m,k1,k2)
%ANISOLAPLACIAN Summary of this function goes here
%   Detailed explanation goes here

    laplacian = k1^2*m(1)^2+k2^2*m(2)^2 + m(3)^2/(k1^2*k2^2);
    
end

