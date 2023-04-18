function [F_far_field] = far_field_flux(W_i, nu_i_inf)

global W_inlet;

% supersonic inflow
if nu_i_inf(1) < 0
    F_far_field = Roe_2D_flux_method_1(W_i, W_inlet, nu_i_inf);
% Steger-Warming for supersonic outflow
elseif nu_i_inf(1) > 0
    [A, B] = jacobians_2D(W_i);

    A_i = A*nu_i_inf(1) + B*nu_i_inf(2);

    F_far_field = A_i*W_i;
end


end

