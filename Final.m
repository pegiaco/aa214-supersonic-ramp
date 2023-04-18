clear all; close all; clc;

%% Parameters

global g;
global nx;
global ny;
global W_inlet;
global fontsize;
global names;
global legends;
global x_min;
global x_max;
global y_min;
global y_max;

g = 1.4;
R = 287; % J.kg^{-1}.K^{-1}

M_inf = 2;
p_inf = 1e5; % N.m^{-2}
T_inf = 300; % K

rho_inf = p_inf/(R*T_inf);
c_inf = sqrt(g*R*T_inf);
u_inf = M_inf*c_inf;
v_inf = 0;

W_inlet = V_to_W_2D([rho_inf; u_inf; v_inf; p_inf]);

nx = 60;
ny = 20;

x_min = 0;
x_max = 4;
y_min = 0;
y_max = 1.5;

fontsize = 14;

% initialize the data used in the plots
names = {'Pressure', 'Density', 'Mach number'};
legends = ["p (N.m^{-2})", "\rho (kg.m^{-3})", "M"];

%% grid with r = 1 - plotted

r = 1;
grid_1 = GridGen(nx, ny, r);

figure(1);
plot_grid(grid_1, r);

%% Method 1 - grid with r = 1 - global time-stepping

cfl = 0.4;
delta_t_global = cfl*(min(min(grid_1.edge(:,:,2), [], "all"), min(grid_1.edge(:,:,4), [], "all"))/(u_inf + c_inf));
eps = 1e2;

% solve
[V_global_1, criterion_1_global, wct_1_global] = method_1_global_time_step(delta_t_global, grid_1, eps, cfl, "r=1_global");

%% Method 1 - grid with r = 1 - local time-stepping

cfl = 0.4;
delta_t_global = cfl*(min(min(grid_1.edge(:,:,2), [], "all"), min(grid_1.edge(:,:,4), [], "all"))/(u_inf + c_inf));
eps = 1e2;

% solve
[V_local_1, t_final, criterion_1_local, wct_1_local] = method_1_local_time_step(delta_t_global, grid_1, eps, cfl, "r=1_local");

%% grid with r = 0.1 - plotted

r = 0.1;
grid_2 = GridGen(nx, ny, r);

figure(4);
plot_grid(grid_2, r);

%% Method 1 - grid with r = 0.1 - global time-stepping

cfl = 0.6;
delta_t_global = cfl*(min(min(grid_2.edge(:,:,2), [], "all"), min(grid_2.edge(:,:,4), [], "all"))/(u_inf + c_inf));
eps = 1e2;

% solve
[V_global_2, criterion_2_global, wct_2_global] = method_1_global_time_step(delta_t_global, grid_2, eps, cfl, "r=0.1_global");

%% Method 1 - grid with r = 0.1 - local time-stepping

cfl = 0.6;
delta_t_global = cfl*(min(min(grid_2.edge(:,:,2), [], "all"), min(grid_2.edge(:,:,4), [], "all"))/(u_inf + c_inf));
eps = 1e2;

% solve
[V_local_2, t_final, criterion_2_local, wct_2_local] = method_1_local_time_step(delta_t_global, grid_2, eps, cfl, "r=0.1_local");

%% Bar plot - wall clock times

wtc = [wct_1_global, wct_1_local, wct_2_global, wct_2_local];
figure(7);
plot_bar(wtc);

%% video renderer

video_renderer("r=1_global");

video_renderer("r=1_local");

video_renderer("r=0.1_global");

video_renderer("r=0.1_local");