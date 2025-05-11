function [t,X,parameters] = FluidSolver(varargin)
%FLUIDSOLVER by Roland Welter
% 
% Solves and saves a trajectory from a user-selected HKC model
% by calling ode45 with its corresponding time stepper.  Note that this
% function can either initialize a new trajectory with a user-selected
% initial condition or continue an existing trajectory
% 
% To compute a new trajectory on the interval [0,Tf] one can call this 
% function as follows:
%
% parameters = [Pr,Ro,k1,k2,Ra,hierNum,M,tInc,Tf,10^(-10),0];
% [t,X,parameters] = FluidSolver(parameters);
%
% Required input arguments:
%     - parameters: 11x1 vector, specifying the Prandtl number, rotation
%                   number, shape parameters k1,k2, Rayleigh number,
%                   hierarchy number, model number, integration step size, 
%                   final time, error tolerance and cumulative run time.
%                   Note Tf MUST be a multiple of tInc.
%
% The default initial condition is the near uniform initial condition.  On 
% the other hand, one can either pass in a desired initial condition, or 
% extend an existing trajectory by calling this function as follows:
%
% [t,X,parameters] = FluidSolver(parameters,Xprev,addTime);
%
% Optional input arguments:
%     - Xprev: a matrix storing the previously computed values of the
%              trajectory, where the different columns represent the 
%              different variables in the truncated model, and the rows 
%              represent the solution at different times.
%     - addTime: a scalar specifying how much time to add onto the
%                trajectory. Note addTime MUST be a multiple of tInc
%     - heatTransport: a vector specifying the running average heat
%                      transport
%     - limitStdDevPercent: a vector specifying the running standard
%                           deviation for the heat transport
%
% Finally, one can also optionally call FluidSolver with a "dontSave"
% argument if one does not want to save the trajectory.
%
% [t,X,parameters] = FluidSolver(parameters,Xprev,addTime,dontSave);
%
% Additional optional input argument:
%     - dontSave: a dummy variable which ensures FluidSolver does not save
%                 the trajectory.  Used for heat transport computations 
%
% Output arguments:
%     - t: a vector storing the time values for the trajectory
%     - X: a matrix storing the trajectory, in which the different columns
%          represent the different variables in the truncated model, and 
%          the rows represent the solution at different times.
%     - parameters: same as above, but with updated values for Tf, runTime

% parameters

parameters = varargin{1};

Pr = parameters(1);
Ro = parameters(2);
k1 = parameters(3);
k2 = parameters(4);
Ra = parameters(5); 
hierNum = parameters(6);
M = parameters(7);
tInc=parameters(8);
Tf = parameters(9);
errTol = parameters(10);
runTime = parameters(11);

% model name definition

[hierName,diffEq] = ModelChoice(hierNum,M,k1,k2);

% add paths

if(nargin == 1)
    addpath('../ModelConstruction');
    addpath('../ModelConstruction/ModeSelection');
    addpath('./TimeSteppers');
elseif(nargin == 3 || nargin == 4)
else
    error('Invalid number of arguments')
end

% initial conditions

if(nargin == 1)
    X0 = InitCond(hierNum,M,'nearUniform');
    tspan=0:tInc:Tf;
else
    Xprev = varargin{2};
    addTime = varargin{3};
    X0=Xprev(end,:);
    tspan=0:tInc:addTime;
end

% integrate

options = odeset('RelTol',errTol,'AbsTol',errTol);
odeFunc = @(t,X) feval(diffEq,X,Pr,Ra,Ro);
tic;
[t,X]=ode45(odeFunc,tspan,X0,options);
runTime = runTime + toc;

% if extending, adjoin result to the old trajectory 

if(nargin > 1)
    tOld = tInc*(0:1:round(Tf/tInc))'; % The colon operator may fail to include the last index if the quantities are not integers.
    t = [ tOld ; (t(2:end)+Tf) ];
    X = [ Xprev ; X(2:end,:)];
    parameters(9) = Tf + addTime;
end

parameters(11) = runTime;

% save

if(nargin < 4)
    folderName = strcat('../SavedData/',hierName,'/Trajectories/Prandtl_',num2str(Pr));
    fileName = strcat(folderName,'/',diffEq,'_Ra_',num2str(Ra),'_Ro_',num2str(Ro),'.mat');
    if(isfolder(folderName))
        save(fileName,'parameters','X');
    elseif(mkdir(folderName))
        save(fileName,'parameters','X');
    else
        error('Folder creation failed.');
    end
end


end

