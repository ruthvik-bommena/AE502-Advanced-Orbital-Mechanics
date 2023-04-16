function [t,X] = propagateDelaunayEOM(a,e,i,frameRotationRate,tspan,mu)
%%  < File Description >
%    Author:        Ruthvik Bommena
%    File Name:     propagateDelaunayEOM.m
%    Compiler:      MATLAB R2022b
%    Date:          16 April, 2023
%    Affiliation:   Department of Aerospace Engineering, University of Illinois Urbana-Champaign.
%    Description:   Function to propagate Delaunay equations of motion numerically 
%    Inputs:        semimajor axis 'a', eccentricity 'e', inclination 'i',
%                   frame rotation rate, time span, gravitational parameter 'mu'

% calculate initial state
n = sqrt(mu/a^3);
L = n*a^2;
G = L*sqrt(1-e^2);
H = G*cos(i);
l = 0;
g = 0;
h = 0;

% initial state vector
X = [L;G;H;l;g;h];

% set ode tolerance
options = odeset('RelTol',1e-13,'AbsTol',1e-15);

% ode propagator
[t,X] = ode89(@delaunayEOM,tspan,X,options,frameRotationRate);

end