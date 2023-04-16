function Plot_DelaunayOrbit
%%  < File Description >
%    Author:        Ruthvik Bommena
%    File Name:     Plot_DelaunayOrbit.m
%    Compiler:      MATLAB R2022b
%    Date:          16 April, 2023
%    Affiliation:   Department of Aerospace Engineering, University of Illinois Urbana-Champaign.
%    Description:   Function to plot orbit using Delaunay Variables

close all; clear; clc;

% Given
a = 1;
e = 0.5;
i = deg2rad(45);
frameRotationRate = 0.01;
mu = 1;
tf = 100;
tspan = linspace(0,tf,1000);

% propagate trajectory
[~,X] = propagateDelaunayEOM(a,e,i,frameRotationRate,tspan,mu);

% Assign
L = X(:,1); G = X(:,2); H = X(:,3);
l = X(:,4); g = X(:,5); h = X(:,6);

n = sqrt(mu/a^3);

% orbital elements to cartesian state
R = zeros(length(X),3); V = zeros(length(X),3);

for ii = 1:length(X)

    % calculate Keplerian orbital elements
    a = sqrt(L(ii)/n);
    e = sqrt(1-(G(ii)/L(ii))^2);
    i = acos(H(ii)/G(ii));
    omega = g(ii);
    alpha = h(ii)-omega;
    M = l(ii);
    
    % orbital elements to cartesian state
    [R(ii,:),V(ii,:)] = ElmToState(a,e,i,alpha,omega,M,mu);
end

% Plot Trajectory
figure; hold on; grid on; view(3); axis("equal");
earth_sphere;
plot3(R(:,1),R(:,2),R(:,3),'-k','LineWidth',1,'DisplayName','Trajectory')
xlabel('x-Distance (DU)'); ylabel('y-Distance (DU)'); zlabel('z-Distance (DU)')
title('Satellite Orbit (Earth not to scale)')
legend('show','Location','best')

end

