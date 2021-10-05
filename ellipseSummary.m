function [ellipseSum] = ellipseSummary(store, debug, bivHist)


    theta_grid = linspace(0,2*pi);
    
    for iPosition = 1:2
        % centroid: median of all centroids
        ellipseSum(iPosition).cntrd  = [];

        switch iPosition
            case 1 
                color = 'r';
            case 2
                color = 'k';
        end
        
        ellipseSum(iPosition).cntrd.Q1 = quantile(store(iPosition).Centroids, 0.25);
        ellipseSum(iPosition).cntrd.Q2 = quantile(store(iPosition).Centroids, 0.75);
        ellipseSum(iPosition).cntrd.median = median(rmoutliers(store(iPosition).Centroids, 'quartiles'), 1);       
    
        % % inner ellipse: 25th quantile 
        ellipseSum(iPosition).inEllipse.MjrSemiAxisLength = quantile(store(iPosition).EllipseL, 0.25)/2;
        ellipseSum(iPosition).inEllipse.MnrSemiAxisLength = quantile(store(iPosition).Ellipsel,  0.25)/2;
        ellipseSum(iPosition).inEllipse.Orientation = quantile(atand(store(iPosition).EllipseSlope), 0.25);

            %parametric equation of ellipse
        ellipse_x_r  = ellipseSum(iPosition).inEllipse.MjrSemiAxisLength * cos( theta_grid );
        ellipse_y_r  = ellipseSum(iPosition).inEllipse.MnrSemiAxisLength * sin( theta_grid );                           
            % rotation matrix with orientation angle found
        R = [ cosd(ellipseSum(iPosition).inEllipse.Orientation) -sind(ellipseSum(iPosition).inEllipse.Orientation); ...
                    sind(ellipseSum(iPosition).inEllipse.Orientation) cosd(ellipseSum(iPosition).inEllipse.Orientation) ];
            %rotation of ellipse
        ellipseSum(iPosition).inEllipse.Ellipse =  R * [ellipse_x_r;ellipse_y_r];
        
         % setpoint
        [~, i] = min( ellipseSum(iPosition).inEllipse.Ellipse(1, :) );
        temp = zeros(200, 1);
        temp(1:100) = ellipseSum(iPosition).inEllipse.Ellipse(2, :);
        temp(101:200) = ellipseSum(iPosition).inEllipse.Ellipse(2, :);
        ellipseSum(iPosition).inEllipse.setpoints = abs( temp(i:i+49) - flip(temp(i+50:i+99)) );
        
        temp = zeros(200, 1);
        temp(1:100) = ellipseSum(iPosition).inEllipse.Ellipse(1, :);
        temp(101:200) = ellipseSum(iPosition).inEllipse.Ellipse(1, :);
        ellipseSum(iPosition).inEllipse.setpoints_xData = temp(i:i+49);
        
        [~, i] = min( ellipseSum(iPosition).inEllipse.Ellipse(2, :) );
        temp(1:100) = ellipseSum(iPosition).inEllipse.Ellipse(1, :);
        temp(101:200) = ellipseSum(iPosition).inEllipse.Ellipse(1, :);
        ellipseSum(iPosition).inEllipse.deltaPs = abs( temp(i:i+49) - flip(temp(i+50:i+99)) );
        
        temp(1:100) = ellipseSum(iPosition).inEllipse.Ellipse(2, :);
        temp(101:200) = ellipseSum(iPosition).inEllipse.Ellipse(2, :);
        ellipseSum(iPosition).inEllipse.deltaPs_xData = temp(i:i+49);
    
        % % middle ellipse: median 
        ellipseSum(iPosition).midEllipse.MjrSemiAxisLength = median(store(iPosition).EllipseL, 1)/2;
        ellipseSum(iPosition).midEllipse.MnrSemiAxisLength = median(store(iPosition).Ellipsel, 1)/2;
        ellipseSum(iPosition).midEllipse.Orientation = median(atand(store(iPosition).EllipseSlope), 1);

            %parametric equation of ellipse
        ellipse_x_r  = ellipseSum(iPosition).midEllipse.MjrSemiAxisLength * cos( theta_grid );
        ellipse_y_r  = ellipseSum(iPosition).midEllipse.MnrSemiAxisLength * sin( theta_grid );                           
            % rotation matrix with orientation angle found
        R = [ cosd(ellipseSum(iPosition).midEllipse.Orientation) -sind(ellipseSum(iPosition).midEllipse.Orientation); ...
                    sind(ellipseSum(iPosition).midEllipse.Orientation) cosd(ellipseSum(iPosition).midEllipse.Orientation) ];
            %rotation of ellipse
        ellipseSum(iPosition).midEllipse.Ellipse =  R * [ellipse_x_r;ellipse_y_r];
        
        % setpoint
        [~, i] = min( ellipseSum(iPosition).midEllipse.Ellipse(1, :) );
        temp = zeros(200, 1);
        temp(1:100) = ellipseSum(iPosition).midEllipse.Ellipse(2, :);
        temp(101:200) = ellipseSum(iPosition).midEllipse.Ellipse(2, :);
        ellipseSum(iPosition).midEllipse.setpoints = abs( temp(i:i+49) - flip(temp(i+50:i+99)) );
        
        temp = zeros(200, 1);
        temp(1:100) = ellipseSum(iPosition).midEllipse.Ellipse(1, :);
        temp(101:200) = ellipseSum(iPosition).midEllipse.Ellipse(1, :);
        ellipseSum(iPosition).midEllipse.setpoints_xData = temp(i:i+49);
        
        [~, i] = min( ellipseSum(iPosition).midEllipse.Ellipse(2, :) );
        temp(1:100) = ellipseSum(iPosition).midEllipse.Ellipse(1, :);
        temp(101:200) = ellipseSum(iPosition).midEllipse.Ellipse(1, :);
        ellipseSum(iPosition).midEllipse.deltaPs = abs( temp(i:i+49) - flip(temp(i+50:i+99)) );
        
        temp(1:100) = ellipseSum(iPosition).midEllipse.Ellipse(2, :);
        temp(101:200) = ellipseSum(iPosition).midEllipse.Ellipse(2, :);
        ellipseSum(iPosition).midEllipse.deltaPs_xData = temp(i:i+49);
    
        % % outer ellipse: 75th quantile 
        ellipseSum(iPosition).outEllipse.MjrSemiAxisLength = quantile(store(iPosition).EllipseL, 0.75)/2;
        ellipseSum(iPosition).outEllipse.MnrSemiAxisLength = quantile(store(iPosition).Ellipsel, 0.75)/2;
        ellipseSum(iPosition).outEllipse.Orientation = quantile(atand(store(iPosition).EllipseSlope), 0.75);
    
            %parametric equation of ellipse
        ellipse_x_r  = ellipseSum(iPosition).outEllipse.MjrSemiAxisLength * cos( theta_grid );
        ellipse_y_r  = ellipseSum(iPosition).outEllipse.MnrSemiAxisLength * sin( theta_grid );                           
            % rotation matrix with orientation angle found
        R = [ cosd(ellipseSum(iPosition).outEllipse.Orientation) -sind(ellipseSum(iPosition).outEllipse.Orientation); ...
                    sind(ellipseSum(iPosition).outEllipse.Orientation) cosd(ellipseSum(iPosition).outEllipse.Orientation) ];
            %rotation of ellipse
        ellipseSum(iPosition).outEllipse.Ellipse =  R * [ellipse_x_r;ellipse_y_r];
        
        % setpoint
        [~, i] = min( ellipseSum(iPosition).outEllipse.Ellipse(1, :) );
        temp = zeros(200, 1);
        temp(1:100) = ellipseSum(iPosition).outEllipse.Ellipse(2, :);
        temp(101:200) = ellipseSum(iPosition).outEllipse.Ellipse(2, :);
        ellipseSum(iPosition).outEllipse.setpoints = abs(temp(i:i+49) - flip(temp(i+50:i+99)));
        
        temp = zeros(200, 1);
        temp(1:100) = ellipseSum(iPosition).outEllipse.Ellipse(1, :);
        temp(101:200) = ellipseSum(iPosition).outEllipse.Ellipse(1, :);
        ellipseSum(iPosition).outEllipse.setpoints_xData = temp(i:i+49);
        
        [~, i] = min( ellipseSum(iPosition).outEllipse.Ellipse(2, :) );
        temp(1:100) = ellipseSum(iPosition).outEllipse.Ellipse(1, :);
        temp(101:200) = ellipseSum(iPosition).outEllipse.Ellipse(1, :);
        ellipseSum(iPosition).outEllipse.deltaPs = abs(temp(i:i+49) - flip(temp(i+50:i+99)));
        
        temp = zeros(200, 1);
        temp(1:100) = ellipseSum(iPosition).outEllipse.Ellipse(2, :);
        temp(101:200) = ellipseSum(iPosition).outEllipse.Ellipse(2, :);
        ellipseSum(iPosition).outEllipse.deltaPs_xData = temp(i:i+49);
        
        % % std ellipse 
        ellipseSum(iPosition).stdEllipse.MjrSemiAxisLength = std(store(iPosition).EllipseL)/2;
        ellipseSum(iPosition).stdEllipse.MnrSemiAxisLength = std(store(iPosition).Ellipsel)/2;
        ellipseSum(iPosition).stdEllipse.Orientation = std( atand(store(iPosition).EllipseSlope) );
    
            %parametric equation of ellipse
        ellipse_x_r  = ellipseSum(iPosition).stdEllipse.MjrSemiAxisLength * cos( theta_grid );
        ellipse_y_r  = ellipseSum(iPosition).stdEllipse.MnrSemiAxisLength * sin( theta_grid );                           
            % rotation matrix with orientation angle found
        R = [ cosd(ellipseSum(iPosition).stdEllipse.Orientation) -sind(ellipseSum(iPosition).stdEllipse.Orientation); ...
                    sind(ellipseSum(iPosition).stdEllipse.Orientation) cosd(ellipseSum(iPosition).stdEllipse.Orientation) ];
            %rotation of ellipse
        ellipseSum(iPosition).stdEllipse.Ellipse =  R * [ellipse_x_r;ellipse_y_r];
        
         
        % % mean ellipse 
        ellipseSum(iPosition).mEllipse.MjrSemiAxisLength = mean(store(iPosition).EllipseL)/2;
        ellipseSum(iPosition).mEllipse.MnrSemiAxisLength = mean(store(iPosition).Ellipsel)/2;
        ellipseSum(iPosition).mEllipse.Orientation = mean( atand(store(iPosition).EllipseSlope) );
            %parametric equation of ellipse
        ellipse_x_r  = ellipseSum(iPosition).mEllipse.MjrSemiAxisLength * cos( theta_grid );
        ellipse_y_r  = ellipseSum(iPosition).mEllipse.MnrSemiAxisLength * sin( theta_grid );                           
            % rotation matrix with orientation angle found
        R = [ cosd(ellipseSum(iPosition).mEllipse.Orientation) -sind(ellipseSum(iPosition).mEllipse.Orientation); ...
                    sind(ellipseSum(iPosition).mEllipse.Orientation) cosd(ellipseSum(iPosition).mEllipse.Orientation) ];
            %rotation of ellipse
        ellipseSum(iPosition).mEllipse.Ellipse =  R * [ellipse_x_r;ellipse_y_r];
        
       
        % % mean ellipse 
        [~, i] = min( ellipseSum(iPosition).outEllipse.Ellipse(1, :) );
        temp = zeros(200, 1);
        temp(1:100) = ellipseSum(iPosition).mEllipse.Ellipse(2, :);
        temp(101:200) = ellipseSum(iPosition).mEllipse.Ellipse(2, :);
        ellipseSum(iPosition).mEllipse.setpoints = abs(temp(i:i+49) - flip(temp(i+50:i+99)));
        temp = zeros(200, 1);
        temp(1:100) = ellipseSum(iPosition).mEllipse.Ellipse(1, :);
        temp(101:200) = ellipseSum(iPosition).mEllipse.Ellipse(1, :);
        ellipseSum(iPosition).mEllipse.setpoints_xData = temp(i:i+49);
    
    
        if debug == 1
            figure(1)
            set(gcf,'color','w');
              myEllipse(1, iPosition) = plot(ellipseSum(iPosition).inEllipse.Ellipse(1, :) + ellipseSum(iPosition).cntrd.median(1), ...
                   ellipseSum(iPosition).inEllipse.Ellipse(2, :) + ellipseSum(iPosition).cntrd.median(2), ...
                    color); hold on;

              myEllipse(2, iPosition) = plot(ellipseSum(iPosition).midEllipse.Ellipse(1, :) + ellipseSum(iPosition).cntrd.median(1), ...
                   ellipseSum(iPosition).midEllipse.Ellipse(2, :) + ellipseSum(iPosition).cntrd.median(2), ...
                    color, 'LineWidth', 1.5); hold on;

              myEllipse(3, iPosition) = plot(ellipseSum(iPosition).outEllipse.Ellipse(1, :) + ellipseSum(iPosition).cntrd.median(1), ...
                   ellipseSum(iPosition).outEllipse.Ellipse(2, :) + ellipseSum(iPosition).cntrd.median(2), ...
                   color); hold on;
       
            % filling 
            x2 = [ellipseSum(iPosition).inEllipse.Ellipse(1, :) + ellipseSum(iPosition).cntrd.median(1), ...
                fliplr(ellipseSum(iPosition).outEllipse.Ellipse(1, :) + ellipseSum(iPosition).cntrd.median(1))];
            inBetween = [ellipseSum(iPosition).inEllipse.Ellipse(2, :) + ellipseSum(iPosition).cntrd.median(2), ...
                fliplr(ellipseSum(iPosition).outEllipse.Ellipse(2, :) + ellipseSum(iPosition).cntrd.median(2))];
            h(iPosition) = fill(x2, inBetween, color); 
            set(h(iPosition),'facealpha',.2,'LineStyle','none'); hold on;
       
    
            ylim([550 850]) % RR range
            xlim( [90 140]) % BP range
            xlabel('Systolic BP [mmHg]')
            ylabel('RR interval [ms]')
            box on
            grid on

            set(0,'DefaultAxesFontName','Arial');
            set(0, 'DefaultAxesFontSize', 12);
            set(0, 'defaultAxesFontWeight', 'normal')
            
            ax1 = gca;
            ax1_pos = ax1.Position; % position of first axes
            xlabel('Systolic BP [mmHg]')
            ylabel('RR interval [ms]')
            if ~isempty(bivHist)

               yyaxis right
                plot(84.5:9:165.5, sum(bivHist(iPosition).npointsC, 2), 'color', 'r', 'LineWidth', 0.8); hold on;
                ylim([0 400])
                xlim( [90 140]) % BP range
                %xlabel('# Systolic BP ')
                ylabel('# Sp ')
                ax = gca;
                ax.YAxis(1).Color = 'k';
                ax.YAxis(2).Color = 'r';
                
                ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','left','Color','none','XLim', [0 400], 'YLim', [550 850]);
                xlabel(ax2,'# rrInt');
                line(sum(bivHist(iPosition).npointsC, 1), 582.5:65:1167.5,'Parent',ax2,'Color','k','linewidth',0.7); hold on;
                
            end
            
            figure(2)
            set(gcf,'color','w');
            f1(iPosition) = plot(ellipseSum(iPosition).mEllipse.Ellipse(1, :) + ellipseSum(iPosition).cntrd.median(1), ...
                   ellipseSum(iPosition).mEllipse.Ellipse(2, :) + ellipseSum(iPosition).cntrd.median(2), ...
                    color); hold on;
            plot(ellipseSum(iPosition).stdEllipse.Ellipse(1, :) + ellipseSum(iPosition).cntrd.median(1), ...
                   ellipseSum(iPosition).stdEllipse.Ellipse(2, :) + ellipseSum(iPosition).cntrd.median(2), ...
                    color); hold on;
                
            figure(3)
            plot(ellipseSum(iPosition).midEllipse.setpoints_xData  + ellipseSum(iPosition).cntrd.median(1), ellipseSum(iPosition).midEllipse.setpoints , 'LineWidth', 1.5, 'Color', color); hold on;
            plot(ellipseSum(iPosition).outEllipse.setpoints_xData  + ellipseSum(iPosition).cntrd.median(1), ellipseSum(iPosition).outEllipse.setpoints , 'LineWidth', 1.0, 'Color', color); hold on;
            plot(ellipseSum(iPosition).inEllipse.setpoints_xData  + ellipseSum(iPosition).cntrd.median(1), ellipseSum(iPosition).inEllipse.setpoints , 'LineWidth', 1.0, 'Color', color); hold on;
            xlabel('Systolic BP (mmHg)')
            ylabel('$\Delta$ RR (ms)', 'Interpreter', 'Latex')
            
            figure(4)
            plot(ellipseSum(iPosition).midEllipse.deltaPs_xData  + ellipseSum(iPosition).cntrd.median(2), ellipseSum(iPosition).midEllipse.deltaPs , 'LineWidth', 1.5, 'Color', color); hold on;
            plot(ellipseSum(iPosition).outEllipse.deltaPs_xData  + ellipseSum(iPosition).cntrd.median(2), ellipseSum(iPosition).outEllipse.deltaPs , 'LineWidth', 1.0, 'Color', color); hold on;
            plot(ellipseSum(iPosition).inEllipse.deltaPs_xData  + ellipseSum(iPosition).cntrd.median(2), ellipseSum(iPosition).inEllipse.deltaPs , 'LineWidth', 1.0, 'Color', color); hold on;
            xlabel('RR interval (ms)')
            ylabel('$\Delta$ Ps (ms)', 'Interpreter', 'Latex')
        end 
    
    end

if debug == 1
    figure(1)
     legend([h(1) h(2)], {'Supine', 'Upright'}, 'Box', 'off');
     
     title('Ellipse Summary Plot')
     
     figure(2)
     legend([f1(1), f1(2)], {'Supine', 'Upright'}, 'Box', 'off');
     
     title('Mean and std ellipse')
end



end