function Plot_LambertHC
%%  < File Description >
%    Author:        Ruthvik Bommena
%    File Name:     LambertHC.m
%    Compiler:      MATLAB R2022b
%    Date:          10 February, 2023
%    Affiliation:   Department of Aerospace Engineering, University of Illinois Urbana-Champaign.
%    Description:   Function to calculate delta V using Lambert's Equation

constants; 

% Choose Transfer Parameters
params = TransferCase(1);
TU = params.TU; mu = params.mu; 
R01 = params.R01; V01 = params.V01;
R02 = params.R02; V02 = params.V02; 
dT = params.dT; tf = params.tf; t0f = params.t0f;
dvMaxRendz = params.dvMaxRendz; dvMaxFlyBy = params.dvMaxFlyBy; 

% Choose transfer type - Prograde or Retrograde
transferType = 'Prograde';

% Initialize DV
dvRendz = zeros(length(tf),length(dT));
dvFlyBy = zeros(length(tf),length(dT));

% Calculate DV for various departure and arrival dates
for ii = 1:length(dT)

    [R1,V1] = StateAtDT(R01,V01,dT(ii),mu); 

    for jj = 1:length(tf)
        
        % Arrival State
        [R2,V2] = StateAtDT(R02,V02,tf(jj),mu);
        
        % Time of flight for Lambert's transfer
        tof = tf(jj)-dT(ii);
        
        % Lambert's solver (choose either prograde or retrograde transfer)
        [v1,v2] = LambertHC(R1,R2,tof,mu,transferType);
        
        % Terminal DVs
        dv1 = v1-V1;
        dv2 = v2-V2;

        % Total DV
        dvRendz(jj,ii) = (norm(dv1)+norm(dv2))*AU/TU; %km/sec
        dvFlyBy(jj,ii) = norm(dv1)*AU/TU; %km/sec

        % Constraint DV values to less than mission requirements
        % Rendezvous
        if dvRendz(jj,ii) > dvMaxRendz
            dvRendz(jj,ii) = NaN;
        end
        % Fly-By
        if dvFlyBy(jj,ii) > dvMaxFlyBy
            dvFlyBy(jj,ii) = NaN;
        end

    end

end

% Change text in the plot as needed
% Oumouamoua transfer plots
% Transfer Case 1
figure; hold on; grid on;
surf(dT*TU/86400,(tf-t0f)*TU/86400,dvRendz, 'LineStyle','none')
xlabel('Departure (Days past January 1st, 2017)');
ylabel('Arrival (Days Past August 1st, 2017)');
colormap turbo; c = colorbar; yl = ylabel(c,'Total \DeltaV (km/s)');
set(yl,'Rotation',270); c.Label.Position(1) = 3.5;
title(['Oumouamoua ',transferType,' Rendezvous Pork Chop Plot'])

figure; hold on; grid on;
surf(dT*TU/86400,(tf-t0f)*TU/86400,dvFlyBy, 'LineStyle','none')
xlabel('Departure (Days past January 1st, 2017)');
ylabel('Arrival (Days Past August 1st, 2017)');
colormap turbo; c = colorbar; yl = ylabel(c,'Total \DeltaV (km/s)');
set(yl,'Rotation',270); c.Label.Position(1) = 3.5;
title(['Oumouamoua ',transferType,' Fly-By Pork Chop Plot'])

% % Borisov transfer plots
% % Transfer Case 2
% figure; hold on; grid on;
% surf(dT*TU/86400,(tf-t0f)*TU/86400,dvRendz, 'LineStyle','none')
% xlabel('Departure (Days past January 1st, 2017)');
% ylabel('Arrival (Days Past June 1st, 2019)');
% colormap turbo; c = colorbar; yl = ylabel(c,'Total \DeltaV (km/s)');
% set(yl,'Rotation',270); c.Label.Position(1) = 3.5;
% title(['Borisov ',transferType,' Rendezvous Pork Chop Plot'])
% 
% figure; hold on; grid on;
% surf(dT*TU/86400,(tf-t0f)*TU/86400,dvFlyBy, 'LineStyle','none')
% xlabel('Departure (Days past January 1st, 2017)');
% ylabel('Arrival (Days Past June 1st, 2019)');
% colormap turbo; c = colorbar; yl = ylabel(c,'Total \DeltaV (km/s)');
% set(yl,'Rotation',270); c.Label.Position(1) = 3.5;
% title(['Borisov ',transferType,' Fly-By Pork Chop Plot'])

end



