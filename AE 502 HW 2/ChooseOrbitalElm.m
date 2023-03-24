function ChooseOrbitalElm
%%  < File Description >
%    Author:        Ruthvik Bommena
%    File Name:     ChooseOrbitalElm.m
%    Compiler:      MATLAB R2022b
%    Date:          08 March, 2023
%    Affiliation:   Department of Aerospace Engineering, University of Illinois Urbana-Champaign.
%    Description:   Function to choose orbital elements for a set of constraints

close all; clc;

constants;

%% Question 1
% Given
rp = RE + 600; % perigee radius in km
T = 86400/3; % orbital period in sec
J2 = 0.00108263; % Earth Zonal Harmonics J2

% Calculate satellite's mean motion
n = 360/T; % deg/sec

% Calculate 'a' in km, e, 'i' in deg
a = ((T/(2*pi))^2*muE)^(1/3);
e = 1 - rp/a;
i = [acosd(sqrt(1/5)), acosd(-sqrt(1/5))];

% Calculate nodal precession for at i
alphaDotI = -3/2*n*J2*(RE/a)^2*cosd(i)/(1-e^2)^2;

% Caculate nodal precession for a range of i
iRange = linspace(0,360,1000); % deg
alphaDot = -3/2*n*J2*(RE/a)^2*cosd(iRange)/(1-e^2)^2;

% Plot
figure; hold on; grid on;
plot(iRange,alphaDot,'-b','LineWidth',1,'DisplayName','$\dot{\Omega}$');
plot(i(1),alphaDotI(1),'*r','MarkerSize',10,'LineWidth',1,'DisplayName',['$\dot{\Omega}(i=63.435^{\circ})=  $ ',num2str(alphaDotI(1))])
plot(i(2),alphaDotI(2),'*k','MarkerSize',10,'LineWidth',1,'DisplayName',['$\dot{\Omega}(i=116.565^{\circ})=  $ ',num2str(alphaDotI(2))])
xlabel('inclination (deg)'); ylabel('$\dot{\Omega}$ (deg/s)','Interpreter','latex');
title('Variation of Nodal Precession with Inclination - Earth Molniya Orbit')
fl = legend('show','Location','best');
set(fl,'Interpreter','latex')


%% Question 2
% Given
rp = RM + 400; % perigee radius in km
T = 88775; % orbital period in sec
J2 = 0.00196; % Mars Zonal Harmonics J2

% Calculate satellite's mean motion
n = 360/T; % deg/sec

% Calculate 'a' in km, e, 'i' in deg
a = ((T/(2*pi))^2*muM)^(1/3);
e = 1 - rp/a;
i = [acosd(sqrt(1/5)), acosd(-sqrt(1/5))];

% Calculate nodal precession for at i
alphaDotI = -3/2*n*J2*(RM/a)^2*cosd(i)/(1-e^2)^2;

% Caculate nodal precession for a range of i
iRange = linspace(0,360,1000); % deg
alphaDot = -3/2*n*J2*(RM/a)^2*cosd(iRange)/(1-e^2)^2;

% Plot
figure; hold on; grid on;
plot(iRange,alphaDot,'-b','LineWidth',1,'DisplayName','$\dot{\Omega}$');
plot(i(1),alphaDotI(1),'*r','MarkerSize',10,'LineWidth',1,'DisplayName',['$\dot{\Omega}(i=63.435^{\circ})=  $ ',num2str(alphaDotI(1))])
plot(i(2),alphaDotI(2),'*k','MarkerSize',10,'LineWidth',1,'DisplayName',['$\dot{\Omega}(i=116.565^{\circ})=  $ ',num2str(alphaDotI(2))])
xlabel('inclination (deg)'); ylabel('$\dot{\Omega}$ (deg/s)','Interpreter','latex');
title('Variation of Nodal Precession with Inclination - Mars Molniya Orbit')
fl = legend('show','Location','best');
set(fl,'Interpreter','latex')

end