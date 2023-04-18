function [F_wall] = wall_flux(W, nu_ii, grid, i, j)

nu_x = grid.normx(i,j,4);
nu_y = grid.normy(i,j,4);

V = W_to_V_2D(W);
rho = V(1);
u = V(2);
v = V(3);
E = W(4);

if nu_x == 0
    W_ghost =  [rho; rho*u; -rho*v; E];
elseif nu_x ~= 0
    v_ghost = -2*nu_x*nu_y*u-v*(nu_y^2 - nu_x^2);
    u_ghost = -(nu_y*v_ghost + nu_x*u+nu_y*v)/nu_x;
   
    W_ghost = [rho; rho*u_ghost; rho*v_ghost; E];
end

F_wall = Roe_2D_flux_method_1(W, W_ghost, nu_ii);

end

