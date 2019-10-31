% INTERFERENCE MODEL

% Set up our time increment and our vector (array) of x (time) values
deltaX = .1   % month
%x = seq(0,5,deltaX)
x = 0:deltaX:10;

% Constants
ARGbirthFraction = 0.6  % 1/month (ARG births per ARG adult per month)
NATbirthFraction = 0.5  % 1/month (NAT births per NAT adult per month)
ARGdeathConstant = .20  % 1/NAT*month (ARG deaths per ARG per NAT per mo.)
NATdeathConstant = .20  % 1/ARG*month (NAT deaths per NAT per ARG per mo.)
initARGpop = 10         % Argentine Ants
initNATpop = 30         % Native Ants


Ca = 100
Cn = 100
alpha = 0.5
beta = 0.6
ka =  0.5
kn =  0.25
pa = 0.5
pn = 0.5

% Initial conditions.
% NATpop = # native ants at each time step
% ARGpop = # Argentine ants at each time step
NATpop = zeros(length(x), 1)
NATpop(1) = initNATpop
ARGpop = zeros(length(x), 1)
ARGpop(1) = initARGpop

% Loop a standard number of times, starting with i=2 since we have already
% set up the simulation's initial conditions at i=1.
for (i = 2:length(x))

    % Compute births/month and deaths/month for each type of shark.
    ARGbirthRate = ARGbirthFraction * ARGpop(i-1)
    NATbirthRate = NATbirthFraction * NATpop(i-1)
    
    ARGdeathRate = ARGdeathConstant * ARGpop(i-1) * NATpop(i-1)
    NATdeathRate = NATdeathConstant * NATpop(i-1) * ARGpop(i-1)

    % Increase or decrease the population of each type of shark based on
    % the birth and death rates for this time step.
    ARGpop(i) = ARGpop(i-1) + (ARGbirthRate * (1 - ARGpop(i-1)/Ca - alpha*NATpop(i-1)/Ca   - pa*ARGpop(i-1) + ka*ARGpop(i-1) ) )* deltaX
    NATpop(i) = NATpop(i-1) + (NATbirthRate * (1 - NATpop(i-1)/Cn - beta*ARGpop(i-1)/Cn   - pn*NATpop(i-1) + kn*NATpop(i-1) )  )* deltaX
end

plot(x,ARGpop,x,NATpop)
xlabel('Time')
ylabel('Population Size')
title('\it{Simulation of Ant Populations}','FontSize',16)

