function params = TransferCase(Case)
%%  < File Description >
%    Author:        Ruthvik Bommena
%    File Name:     LambertHC.m
%    Compiler:      MATLAB R2022b
%    Date:          10 February, 2023
%    Affiliation:   Department of Aerospace Engineering, University of Illinois Urbana-Champaign.
%    Description:   Function to select orbital transfer.

constants;

% Select Transfer Case
switch Case 

    case 1
        % Departure: Earth
        % Arrival: Oumouamoua
        % Assumption: Two-body motion w.r.t the Sun

        % Dimensionalized Time and Gravitational Parameter
        TU = sqrt(AU^3/muS);
        mu = 1;

        % Earth State at t0 (January 1st, 2017)
        R01 = [-1.796136509111975*1e-1, 9.667949206859814*1e-1, -3.668681017942158*1e-5]; % AU
        V01 = [-1.720038360888334*1e-2, -3.211186197806460*1e-3, 7.927736735960840*1e-7].*TU/86400; % AU/TU

        % Oumouamoua State at t0 (January 1st, 2017)
        R02 = [3.515868886595499*1e-2, -3.162046390773074, 4.493983111703389]; % AU
        V02 = [-2.317577766980901*1e-3, 9.843360903693031*1e-3, -1.541856855538041*1e-2].*TU/86400; % AU/TU
        
        % Departure days from January 1st, 2017 to December 31st, 2017
        dT = 0:365; % days
        dT = dT.*86400/TU; % TU
        
        % Time to August 1st, 2017 since January 1st, 2017
        t0f = 212*86400/TU; % TU
        
        % Arrival days from August 1st, 2017 to January 31st 2019
        tf = 0:548; % days 
        tf = tf.*86400/TU; % TU
        tf = t0f+tf;

        % Maximum DV (km/sec) available for Rendezvous and Fly-By missions
        dvMaxRendz = 50;
        dvMaxFlyBy = 20;

    case 2
        % Departure: Earth
        % Arrival: Borisov
        % Assumption: Two-body motion w.r.t the Sun

        % Dimensionalized Time and Gravitational Parameter
        TU = sqrt(AU^3/muS);
        mu = 1;

        % Earth State at t0 (January 1st, 2017)
        R01 = [-1.796136509111975*1e-1, 9.667949206859814*1e-1, -3.668681017942158*1e-5]; % AU
        V01 = [-1.720038360888334*1e-2, -3.211186197806460*1e-3, 7.927736735960840*1e-7].*TU/86400; % AU/TU

        % Borisov State at t0 (January 1st, 2017)
        R02 = [7.249472033259724, 14.61063037906177, 14.24274452216359]; % AU
        V02 = [-8.241709369476881*1e-3, -1.156219024581502*1e-2, -1.317135977481448*1e-2].*TU/86400; % AU/TU

        % Departure days from January 1st, 2017 to July 31st, 2020
        dT = 0:1301; % days
        dT = dT.*86400/TU; % TU

        % Time to June 1st, 2019 since January 1st, 2017
        t0f = 881*86400/TU; % TU

        % Arrival days from June 1st, 2019 to January 31st 2022
        tf = 0:975; % days 
        tf = tf.*86400/TU; % TU
        tf = t0f+tf;
        
        % Maximum DV (km/sec) available for Rendezvous and Fly-By missions
        dvMaxRendz = 60;
        dvMaxFlyBy = 20;
end

    params.TU = TU; params.mu = mu; params.R01 = R01; params.V01 = V01; params.R02 = R02; params.V02 = V02;
    params.dT = dT; params.tf = tf; params.t0f = t0f; params.dvMaxRendz = dvMaxRendz; params.dvMaxFlyBy = dvMaxFlyBy; 
end
