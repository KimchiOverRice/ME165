clear all; close all;

%% Constants 
h = 300;
r = 10;
t = 0.05;
rho_steel = 7850;
rho_ballast = 4000;
rho_water = 1025;
h_b = 0:1:100;

% Mass of steel hull
M = rho_steel * (vol_cyl(r, h) - vol_cyl(r-t, h-(2*t)));
% Mass of ballast
M_b = rho_ballast * vol_cyl(r-t, h_b);
% Mass of Turbine
M_blades = 2.07 * 10^6;
% Mass of Hub
M_hub = 2.53 * 10^5;
% Mass of Nacelle
M_nacelle = 9.45 * 10^5;
M_top  = M_blades + M_hub + M_nacelle;
M_total = M + M_b + M_top;

%% Spar and Turbine 

% Submerged Depth
h_s = (M_total)/(rho_water * pi * r^2);

% Center of Buoyancy
CB = h_s/2;

% Center of Gravity
CG = (M .* h/2 + M_b .* h_b + M_top * h)./(M_total);

% Distance between center of buoyancy and center of gravity
BG = CG - CB;

% Distance between center of buoyancy and metacenter
BM = ((1/64) .* r^4)./(r^2 .* h_s);

% Metacentric height
GM = BM - BG;

%% Only Spar
h_s_spar = (M + M_b)/(rho_water * pi * r^2);

% Center of Buoyancy
CB_spar = h_s_spar/2;

% Center of Gravity
CG_spar = (M .* h/2 + M_b .* h_b)./(M + M_b);

% Distance between center of buoyancy and center of gravity
BG_spar = CG_spar - CB_spar ;

% Distance between center of buoyancy and metacenter
BM_spar = ((1/64) .* r^4)./(r^2 .* h_s_spar);

% Metacentric height
GM_spar = BM_spar - BG_spar;

%% Plotting

figure;
hold on
plot(0:1:100, GM);
plot(0:1:100, GM_spar);
line(xlim(), [0,0], 'LineWidth', 0.5, 'Color', 'k');
grid on;
title("Metacentric height (GM) vs Height of Ballast")
xlabel("height of ballast [m]")
ylabel("GM")
legend(["spar", "spar with a turbine"])

figure;
hold on
plot(0:1:100, CB);
plot(0:1:100, CB_spar);


plot(0:1:100, CG);
plot(0:1:100, CG_spar);
line(xlim(), [0,0], 'LineWidth', 0.5, 'Color', 'k');
grid on;
title("Center of Gravity (CG) and Center of Buoyancy (CB) vs Height of Ballast")
xlabel("height of ballast [m]")
ylabel("CG and CB")
legend(["CB", "CB with a turbine", "CG", "CG with a turbine"])

%% Function for volume of a cylinder

function vol = vol_cyl(radius, height)
vol = pi * radius^2 * height;
end
