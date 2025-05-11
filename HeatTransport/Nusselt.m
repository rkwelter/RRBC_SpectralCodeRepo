function [nusselt] = Nusselt(X,t,tInc,velVec,velBuoyMatches,k1,k2)
%NUSSELT Summary of this function goes here
%   Detailed explanation goes here

NusseltIntegrand = zeros(size(X,1),1);
numVel = size(velVec,1);

for i=1:numVel
    buoyInd = velBuoyMatches(i);
    if(buoyInd > 0)
        n = velVec(i,:);
        coef1 = GmatCoef(n,k1,k2,3)/(4*pi^4*NormGm(n,k1,k2));
        NusseltIntegrand = NusseltIntegrand + coef1*X(:,i).*X(:,numVel + buoyInd);
    end
end

nusselt = 1 + tInc*cumsum(NusseltIntegrand)./t;

end

