%% ModelConstructor by Roland Welter
% ModelConstructor builds the time stepper for a desired spectral model

%% Choose model
% The user must provide 5 parameters which specify which model that
% ModelConstructor will write.  These are as follows:
%
% hierNum - Describes which hierarchy the model belongs to.  tau_1 in 
%           the notation of the paper. The following values of hierNum
%           give the following hierarchies:
%               hierNum = 1 - 'linf'
%               hierNum = 2 - 'l1'
%               hierNum = 3 - 'HKC'
%               hierNum = 4 - 'energyInconsis'
%               hierNum = 5 - 'linf_full'
%               hierNum = 6 - 'l1_full'
%               hierNum = 7 - 'fourierBox'
%
% M - the model number describing which model is selected within a given
%     hierarchy.  tau_2 in the notation of the paper.
%
% k1,k2 - the first and second box parameters, which specify the shape of
%         the domain, ie the domain is [0,2*pi/k1] x [0,2*pi/k2] x
%         [0,pi*k1*k2]

hierNum = 3; 
M=24;
k1 = 1; k2 = 1; 

%% Add paths, build mode variables and find couplings 

addpath('./AuxiliaryFuncs'); addpath('./ModeSelection');
[hierName,diffEq,velVec,tempVec,numTempVert] = ModelSelector(hierNum,M,k1,k2);
numVel = size(velVec,1); numTemp = size(tempVec,1);
[velBuoyMatches,tempBuoyMatches] = BuoyancyMatches(velVec,tempVec);
[CorMatches] = CoriolisMatches(velVec);
[velTriples,tempTriples] = CompatibleTriples(velVec,tempVec);

%% write function

FID=fopen(strcat('../FluidSolver/TimeSteppers/',diffEq,'.m'),'w');
introString = [strcat('function [dX] = ',diffEq,'(X,Pr,Ra,Ro)'),newline,newline,'dX = [ '];
fprintf(FID, '%s', introString);

%% velocity terms

for i=1:numVel

    %viscous term
    ODEstring = strcat('-Pr*(',num2str(AnisoLaplacian(velVec(i,1:3),k1,k2)),')*X(',num2str(i),')');

    %buoyancy term
    ODEstring = strcat(ODEstring,BuoyancyTerm(velVec(i,:),k1,k2,'vel',numVel,velBuoyMatches(i)));

    %Coriolis term
    ODEstring = strcat(ODEstring,CoriolisTerm(velVec(i,:),k1,k2,CorMatches(i)));

    %Nonlinear term
    for j=1:size(velTriples{i},1)
        ind1 = velTriples{i}(j,1); ind2 = velTriples{i}(j,2);
        nonlinCoef = NonlinearCoef(velVec(i,:),velVec(ind1,:),velVec(ind2,:),[k1,k2,1/(k1*k2)],'vel');
        if(nonlinCoef ~= 0)
            ODEstring = strcat(ODEstring,'-(',num2str(nonlinCoef),')*X(',num2str(ind1),')*X(',num2str(ind2),')');
        end
    end

    ODEstring = [strcat(ODEstring,';'),newline];
    fprintf(FID, '%s', ODEstring);
end

%% temperature terms

for i=1:numTemp

    %viscous term
    ODEstring = strcat('-(',num2str(AnisoLaplacian(tempVec(i,1:3),k1,k2)),')*X(',num2str(numVel+i),')');

    %buoyancy term
    ODEstring = strcat(ODEstring,BuoyancyTerm(tempVec(i,:),k1,k2,'temp',0,tempBuoyMatches(i,:)));

    %Nonlinear term
    for j=1:size(tempTriples{i},1)
        ind1 = tempTriples{i}(j,1); ind2 = tempTriples{i}(j,2);
        nonlinCoef = NonlinearCoef(tempVec(i,:),velVec(ind1,:),tempVec(ind2,:),[k1,k2,1/(k1*k2)],'temp');
        if(nonlinCoef ~= 0)
            ODEstring = strcat(ODEstring,'-(',num2str(nonlinCoef),')*X(',num2str(ind1),')*X(',num2str(ind2+numVel),')');
        end
    end

    if(i < numTemp)
        ODEstring = [strcat(ODEstring,';'),newline];
    else
    end
    fprintf(FID, '%s', ODEstring);
end


closeString = ['];',newline,'end'];
fprintf(FID, '%s', closeString);
fclose(FID);
