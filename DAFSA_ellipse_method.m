function [DAFSA] = DAFSA_ellipse_method( ellipse, cntrd ,position, color_left, color_right, linestyle, line, debug)

%     Fs = 4;                     % frequency of interpolation in Hz
%     T = 1/ Fs;
    L = 1500;
%     t = (0:L-1)*T;
    theta_grid = linspace(-pi, pi, 1500);
    x_t = ellipse.MjrSemiAxisLength * cos( theta_grid ) ; 
    y_t = ellipse.MnrSemiAxisLength * sin( theta_grid ) ;
    R = [ cosd(ellipse.Orientation) -sind(ellipse.Orientation); ...
                sind(ellipse.Orientation) cosd(ellipse.Orientation) ];
    myEllipse = R * [x_t; y_t];
    myEllipse(1, :) = myEllipse(1, :) + cntrd(1);
    myEllipse(2, :) = myEllipse(2, :) + cntrd(2);

    
    [maximum.x, i1] = max(myEllipse(1, :));
    minimum.x = min(myEllipse(1, :));
    [maximum.y, i2] = max(myEllipse(2, :));
    minimum.y = min(myEllipse(2, :));
%     delay = i2-i1;
    i1 = rad2deg(theta_grid(i1)) ;
    i2 = rad2deg(theta_grid(i2)) ;
    phase_shift = i2-i1;
    
    DAFSA.magnitude.ps = maximum.x - minimum.x;
    DAFSA.magnitude.rr = maximum.y - minimum.y;
    DAFSA.phase_shift = phase_shift;
    
    %right side: pressure
    yyaxis right
    myplt1 = plot(rad2deg(theta_grid), myEllipse(1, :), 'Color',  color_right , 'LineStyle' , linestyle, 'LineWidth', line); hold on;
    myplt1.Annotation.LegendInformation.IconDisplayStyle ='off';
    if debug == 1
        myplt2 = plot(i1, maximum.x, '*','MarkerEdgeColor','red'); hold on;
        myplt2.Annotation.LegendInformation.IconDisplayStyle ='off';
    end
    xlabel('Degrees °')
    xlim([-180 180])
    ylabel('[mmHg]')
%     switch position
%         case 'supine'
%             ylim([118 126])
%         case 'standing'
%     end
    ax = gca;
    set(gca, 'YColor',  color_right)
    box off
    grid on
    
    myplt.Annotation.LegendInformation.IconDisplayStyle ='off';
    
    yyaxis left
    myplt3 = plot(rad2deg(theta_grid), myEllipse(2, :), 'Color', color_left, 'LineStyle', linestyle, 'LineWidth', line'); hold on;
    myplt3.Annotation.LegendInformation.IconDisplayStyle = 'off';
    xlabel(' Degrees °')
     ylabel('[ms]')
    ax = gca;
    set(gca, 'YColor', color_left )
    if debug == 1
        myplt4 = plot(i2, maximum.y, '*' , 'MarkerEdgeColor','red'); hold on;
        myplt4.Annotation.LegendInformation.IconDisplayStyle ='off';
    end
    switch position
        case 'supine'
            ylim([700 850])
        case 'standing'
            ylim([580 680])
    end
    xlim([-180 180])
    box off
    grid on
    
   title( join(['Phase shift plot for ', position, ' position']) )
    
    
    
    
    

end