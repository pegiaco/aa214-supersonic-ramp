function [] = plot_grid(Grid, r)

global nx;
global ny;
global fontsize;
global x_min;
global x_max;
global y_min;
global y_max;

set(gca,'FontSize', fontsize);
hold on;
scatter(Grid.x, Grid.y, 'k', 'filled');
scatter(Grid.xc, Grid.yc, 'r', 'filled');
for k = 1:ny+1
    plot(Grid.x(:,1), Grid.y(:,k), 'k');
end
for k = 1:nx+1
    plot(repelem(Grid.x(k,1),ny+1), Grid.y(k,:), 'k');
end
hold off;
title("Grid  |  n_x = "+nx+"  |  n_y = "+ny+"  |  r = "+r);
xlim([x_min x_max]);
ylim([y_min y_max]);
axis equal;
grid on;

end

