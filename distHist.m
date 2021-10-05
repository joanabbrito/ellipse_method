function [bivHist] = distHist (store, debug)

    bivHist(1).npointsC = hist3(store(1).Centroids, 'Ctrs', {82.5:5:167.5 582.5:65:1167.5}); 
    bivHist(2).npointsC = hist3(store(2).Centroids, 'Ctrs', {82.5:5:167.5 582.5:65:1167.5}); 
    
    if debug == 1
        figure
        set(gcf, 'color', 'w')
        subplot(2, 1, 1)
        yyaxis right
        plot(82.5:5:167.5, sum(bivHist(1).npointsC, 2), 'color', [0.6 0.6 0.6], 'LineWidth', 2.0); hold on;
        bivHist(1).myXData_Sp = 82.5:5:167.5;
        bivHist(1).myYData_Sp = sum(bivHist(1).npointsC, 2);
        ylim ([0 400]);
        xlim ( [90 140]);
        ylabel('# Sp points')
        xlabel('Sp [mmHg]')
        set(gca, 'color', 'none')
        ax = gca;
        ax.YAxis(1).Color = 'none';
        ax.YAxis(2).Color = 'k';
        ax_pos = ax.Position;
        ax2 = axes('Position',ax_pos,'XAxisLocation','top','YAxisLocation','left','Color','none','XLim', [0 450], 'YLim', [550 850], 'Color', [0.8 0.8 0.8]);
            xlabel(ax2,'# rrInt');
        line(sum(bivHist(1).npointsC, 1), 582.5:65:1167.5,'Parent',ax2,'Color','k','linewidth',0.5); hold on;
        bivHist(1).myXData_RR = 582.5:65:1167.5;
        bivHist(1).myYData_RR = sum(bivHist(1).npointsC, 1);
        %set(gca, 'color', 'none')
        title('Supine')
        ylabel('RR [ms]')
        xlabel('# RR points')
        box off;
        set(gca, 'color', 'none')
        
        subplot(2, 1, 2)
        yyaxis right
        plot(82.5:5:167.5, sum(bivHist(2).npointsC, 2), 'color', [0.6 0.6 0.6], 'LineWidth', 2.0); hold on;
        bivHist(2).myXData_Sp = 82.5:5:167.5;
        bivHist(2).myYData_Sp = sum(bivHist(2).npointsC, 2);
        ylim ([0 400]);
        xlim ( [90 140]);
        ylabel('# Sp points')
        xlabel('Sp [mmHg]')
        set(gca, 'color', 'none')
        ax = gca;
        ax.YAxis(1).Color = 'none';
        ax.YAxis(2).Color = 'k';
        ax_pos = ax.Position;
        ax2 = axes('Position',ax_pos,'XAxisLocation','top','YAxisLocation','left','Color','none','XLim', [0 450], 'YLim', [550 850]);
            xlabel(ax2,'# rrInt');
        line(sum(bivHist(2).npointsC, 1), 582.5:65:1167.5,'Parent',ax2,'Color','k','linewidth',0.5); hold on;
        bivHist(2).myXData_RR = 582.5:65:1167.5;
        bivHist(2).myYData_RR = sum(bivHist(2).npointsC, 1);
        set(gca, 'color', 'none')
        title('Standing')
        ylabel('RR [ms]')
        xlabel('# RR points')
        box off;
%         
%         subplot(2, 2, 3)
%         plot(582.5:65:1167.5, sum(bivHist(1).npointsC, 1), 'color', 'r', 'LineWidth', 0.8); hold on;
%         title('Supine')
%         ylim([0 500])
%         xlabel('RR interval [ms]')
%         ylabel(' # of points present in sequences')
%         %yline(200, ':m'); hold on;
%         box off;
%         
%         subplot(2, 2, 4)
%         plot(582.5:65:1167.5, sum(bivHist(2).npointsC, 1), 'color', 'k', 'LineWidth', 0.8); hold on;
%         title('Standing')
%         ylim([0 500])
%         xlabel('RR interval [ms]')
%         ylabel(' # of points present in sequences')
%         %yline(200, ':m'); hold on;
%         box off;
    end

end