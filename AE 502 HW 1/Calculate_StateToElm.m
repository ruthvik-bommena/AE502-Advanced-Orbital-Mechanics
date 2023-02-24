function Calculate_StateToElm
%%  < File Description >
%    Author:        Ruthvik Bommena
%    File Name:     Calculate_StateToElm.m
%    Compiler:      MATLAB R2022b
%    Date:          10 February, 2023
%    Affiliation:   Department of Aerospace Engineering, University of Illinois Urbana-Champaign.
%    Description:   Function to calculate Orbital Elements from State Vectors 

constants; 

% Oumouamoua
params = TransferCase(1); mu = params.mu; 
R02 = params.R02; V02 = params.V02;
[a_Om,e_Om,i_Om,alpha_Om,omega_Om,f_Om] = StateToElm(R02,V02,mu);
elmOm = [a_Om, e_Om, deg2rad([i_Om,alpha_Om,omega_Om,f_Om])]

% Borisov
params = TransferCase(2); mu = params.mu; 
R02 = params.R02; V02 = params.V02;
[a_Bo,e_Bo,i_Bo,alpha_Bo,omega_Bo,f_Bo] = StateToElm(R02,V02,mu);
elmBo = [a_Bo, e_Bo, deg2rad([i_Bo,alpha_Bo,omega_Bo,f_Bo])]

end