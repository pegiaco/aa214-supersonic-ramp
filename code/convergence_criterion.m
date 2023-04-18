function [convergence_criterion] = convergence_criterion(W_1, W_2)

global nx;
global ny;

rho_1 = reshape(squeeze(W_1(:,:,1)), nx*ny, 1);
rho_u_1 = reshape(squeeze(W_1(:,:,2)), nx*ny, 1);
rho_v_1 = reshape(squeeze(W_1(:,:,3)), nx*ny, 1);
E_1 = reshape(squeeze(W_1(:,:,4)), nx*ny, 1);

rho_2 = reshape(squeeze(W_2(:,:,1)), nx*ny, 1);
rho_u_2 = reshape(squeeze(W_2(:,:,2)), nx*ny, 1);
rho_v_2 = reshape(squeeze(W_2(:,:,3)), nx*ny, 1);
E_2 = reshape(squeeze(W_2(:,:,4)), nx*ny, 1);

residue_rho = abs(rho_2 - rho_1);
residue_rho_u = abs(rho_u_2 - rho_u_1);
residue_rho_v = abs(rho_v_2 - rho_v_1);
residue_E = abs(E_2 - E_1);

rms_error = sqrt(residue_rho.^2 + residue_rho_u.^2 + residue_rho_v.^2 + residue_E.^2);

convergence_criterion = max(rms_error);

end

