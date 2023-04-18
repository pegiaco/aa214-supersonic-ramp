function [A,B] = jacobians_2D(W)

global g;

V = W_to_V_2D(W);

rho = V(1);
u = V(2);
v = V(3);
p = V(4);
E = W(4);
h = (E + p)/rho;

A = [0, 1, 0, 0;
    0.5*(g-1)*(u^2 + v^2) - u^2, (3-g)*u, (1-g)*v, (g-1);
    -u*v, v, u, 0;
    (0.5*(g-1)*(u^2 + v^2) - h)*u, h + (1-g)*u^2, (1-g)*u*v, g*u];

B = [0, 0, 1, 0;
    -u*v, v, u, 0;
    0.5*(g-1)*(u^2 + v^2) - v^2, (1-g)*u, (3-g)*v, (g-1);
    (0.5*(g-1)*(u^2 + v^2) - h)*v, (1-g)*u*v, h + (1-g)*v^2, g*v];

end

