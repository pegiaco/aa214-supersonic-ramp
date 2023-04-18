function [V, criterion_array, wall_clock_time] = method_1_global_time_step(delta_t_global, grid, eps, cfl, name)

global nx;
global ny;
global W_inlet;

tic

W = zeros(nx, ny, 4);

for j = 1:ny
    for i = 1:nx
        W(i,j,:) = W_inlet;
        V(i,j,:) = W_to_V_2D(W_inlet);
    end
end

figure(1);
plot_results(V, 0, grid, [], "Global time-step", 1, name, 0, cfl);
close(figure(1));

W_current = W;

criterion_array = [];

n = 0;
conv_criterion = 1e6;
while conv_criterion > eps
    n = n + 1
    for j = 1:ny
        for i = 1:nx
            F = zeros(4,1);
            
            % get the fluxes
            W_L = squeeze(W_current(i,j,:));

            % choose fluxes to compute
            [indices, indices_bc] = flux_indices(i,j);

            % construct fluxes
            for m = 1:4
                %normal
                normal = [grid.normx(i,j,m), grid.normy(i,j,m)]*grid.edge(i,j,m);

                % interior domain
                if ismember(m, indices)
                    if m == 1
                        W_R = squeeze(W_current(i+1,j,:));
                    elseif m == 2
                        W_R = squeeze(W_current(i,j+1,:));
                    elseif m == 3
                        W_R = squeeze(W_current(i-1,j,:));
                    elseif m == 4
                        W_R = squeeze(W_current(i,j-1,:));
                    end

                    F(:,end+1) = Roe_2D_flux_method_1(W_L, W_R, normal);
                % wall
                elseif ismember(m, [2,4]) && ismember(m, indices_bc)
                    F(:,end+1) = wall_flux(squeeze(W_current(i,j,:)), normal, grid, i, j);
                % far-field
                elseif ismember(m, [1,3]) && ismember(m, indices_bc)
                    F(:,end+1) = far_field_flux(squeeze(W_current(i,j,:)), normal);
                end
            end
            
            % update W
            W(i,j,:) = real(squeeze(W_current(i,j,:)) - (delta_t_global/grid.area(i,j))*sum(F,2));
        
            % update V
            V(i,j,:) = W_to_V_2D(W(i,j,:));

        end
    end

    conv_criterion = convergence_criterion(W_current, W)

    criterion_array(end+1) = conv_criterion;

    % plot
    figure(n);
    plot_results(V, n*delta_t_global, grid, criterion_array, "Global time-step", 1, name, n, cfl);
    close(figure(n));

    W_current = W;
end

% t_final = n*delta_t_global;

wall_clock_time = toc;

end
