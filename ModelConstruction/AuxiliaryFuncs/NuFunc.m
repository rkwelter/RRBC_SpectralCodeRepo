function [nu] = NuFunc(n)
%NUFUNC_FB Summary of this function goes here
%   Detailed explanation goes here

    m = n(1:3); p1 = n(4); p2 = n(5);
    if(p1 == 0 && p2 == 0)
        nu(1) = min([m(1),1]); nu(2) = min([m(2),1]); nu(3) = min([m(3),1]);
    elseif(p1 == 1 && p2 == 0)
        nu(1) = 1; nu(2) = min([m(1),m(2),1]); nu(3) = min([m(1),m(3),1]);
    elseif(p1 == 0 && p2 == 1)
        nu(1) = min([m(1),m(2),1]); nu(2) = 1; nu(3) = min([m(2),m(3),1]);
    elseif(p1 == 1 && p2 == 1)
        nu(1) = min([m(2),1]); nu(2) = min([m(1),1]); nu(3) = min([m(1),m(2),m(3),1]);
    else
        error('Unrecognized phase');
    end

end

