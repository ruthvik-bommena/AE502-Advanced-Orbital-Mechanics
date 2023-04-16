function xDot = delaunayEOM(~,X,frameRotationRate)
%%  < File Description >
%    Author:        Ruthvik Bommena
%    File Name:     delaunayEOM.m
%    Compiler:      MATLAB R2022b
%    Date:          16 April, 2023
%    Affiliation:   Department of Aerospace Engineering, University of Illinois Urbana-Champaign.
%    Description:   Delaunay equations of motion
%    Inputs:        Initial state vector 'X', frame rotation rate

% Equations of motion
LDot = 0;
GDot = 0;
HDot = 0;
lDot = 1/(X(1)^3);
gDot = 0;
hDot = frameRotationRate;

% combine
xDot = [LDot; GDot; HDot; lDot; gDot; hDot];

end