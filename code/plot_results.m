function [] = plot_results(V, t, Grid, criterion_array, method, r, name, n, cfl)

global nx;
global ny;
global g;
global names;
global legends;
global x_min;
global x_max;
global y_min;
global y_max;
global fontsize;

hold on;
for k = 1:4
    subplot(2,2,k);
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    if k <= 3
        scatter(Grid.x, Grid.y, 12, 'k', 'filled');
        if k == 1
            colors = squeeze(V(:,:,4));
            if n == 0
                cmin = 0.9966e5;
                cmax = 1.078e5;
            end
        elseif k == 2
            colors = squeeze(V(:,:,1));
            if n == 0
                cmin = 1.1586;
                cmax = 1.2187;
            end
        elseif k == 3
            colors = sqrt(squeeze(V(:,:,2)).^2 + squeeze(V(:,:,3)).^2)./sqrt(g*squeeze(V(:,:,4))./squeeze(V(:,:,1)));
            if n == 0
                cmin = 1.9659;
                cmax = 2.001;
            end
        end
        surf(Grid.x, Grid.y, zeros(nx+1, ny+1), colors);
        set(gca,'FontSize', fontsize);
        T = title(names(k)+"  |  "+method+"  |  t = "+t+" s  |  n_{x} = "+nx+"  |  n_{y} = "+ny+"  |  r = "+ r + "  |  CFL = " + cfl);
        c = colorbar;
        c.Label.String = legends(k);
        if n == 0
            clim([cmin, cmax]);
        end
        xlim([x_min x_max]);
        ylim([y_min y_max]);
        view(0,90);
    else
        semilogy(1:length(criterion_array), criterion_array, 'LineWidth', 1);
        set(gca,'FontSize', fontsize);
        T = title("Convergence criterion  |  RMS residues  |  Semi-Log scale");
        xlabel("Time step");
        ylabel("Convergence criterion");
        grid on;
    end
    ax = gca;
    ax.TitleFontSizeMultiplier = 0.97;
    titlePos = get(T, 'position');
    titlePos = titlePos + [0, 0.09, 0];
    set(T, 'position', titlePos);
end
hold off;
saveas(gcf, "./figures/" + name + "_" + n + ".png");

end

