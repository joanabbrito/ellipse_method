function [] = lag_analysis(debug, store, ID)
if debug == 0
    return
end 
    figure(1);
    set(gcf,'color','w');
    fig1 = figure(1);
%     figure(2);
%     fig2 = figure(2);
%     set(gcf,'color','w');
%     figure(3);
%     fig3 = figure(3);
%     set(gcf,'color','w');
    figure(4);
    fig4 = figure(4);
    set(gcf,'color','w');
%     figure(5);
%     fig5 = figure(5);
%     set(gcf,'color','w');
    figure(6);
    fig6 = figure(6);
    set(gcf,'color','w');
    
   for iPosition = 1:2
       switch iPosition
           case 1
               tit = '(a) Supine';
           case 2
               tit = '(b) Upright';
       end 
%        subplot(1,2, 1)
%     barh(store(1).nCycles)
%     yticks(1:21);
%     subplot(1,2, 2)
%     barh(store(2).nCycles)
%     yticks(1:21);
        figure(1)
        subplot(1,2, iPosition)
        mybarplt = barh([store(iPosition).nCycles store(iPosition).nUp store(iPosition).nDn] ,  'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
        mybarplt(1).CData =[1 1 1];
        mybarplt(2).CData =[0.7 0.7 0.7];
        mybarplt(3).CData =[0 0 0];
        title(tit);
        yticks(1:21);
        yticklabels(ID);
        legend('# cycles', '# up sequences', '# dn sequences' );
        xlim([0 130]);
        box on;
        grid on;
        
%         figure(2)
%         subplot(1,2, iPosition)
%         mybarplt = barh( flip(flip(store(iPosition).nLag, 1), 2) , 'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%         mybarplt(1).CData =[1 1 1];
%         mybarplt(2).CData =[0.7 0.7 0.7];
%         mybarplt(3).CData =[0.4 0.4 0.4];
%         title(tit);
%         yticks(1:21);
%         yticklabels(flip(ID));
%         xlim([0 100]);
%         legend('Lag 2','Lag 1','Lag 0');
%         box on
%         grid off
  
   end
   
    figure(1)
    han=axes(fig1,'visible','off');
    han.Title.Visible='on';
    han.XLabel.Visible='off';
    han.YLabel.Visible='on';
    ylabel(han,'Subject');
    box off;
    grid on;
    
%     figure(2)
%     han=axes(fig2,'visible','off');
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han,'Subject');
%     xlabel(han,'# of valid baroreflex sequences');
    
    figure(3)
    X = categorical({'Lag 0','Lag 1'});
    X = reordercats(X, {'Lag 0','Lag 1'});
    mybarplt = bar(X, [nanmean(store(1).SlopeAll), nanmean(store(2).SlopeAll); nanmean(store(1).lag1), ...
         nanmean(store(2).lag1)], 'BarWidth', 1, ...
        'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
    a = [nanmean(store(1).SlopeAll), nanmean(store(2).SlopeAll)];
    b = [nanmean(store(1).lag1), nanmean(store(2).lag1)];
    y = [a; b];
    [ngroups,nbars] = size(y);
    % Get the x coordinate of the bars
    x = nan(nbars, ngroups);
    for i = 1:nbars
        x(i,:) = mybarplt(i).XEndPoints;
    end
    a = [nanstd(store(1).SlopeAll), nanstd(store(2).SlopeAll)];
    b = [nanstd(store(1).lag1), nanstd(store(2).lag1)];
    err = [a; b];
    neg = zeros(size(err));
    e = errorbar(x',y,neg, err, 'k','linestyle','none');
    mybarplt(1).CData =[1 1 1];
    mybarplt(2).CData =[0.4 0.4 0.4];
    ylim([0 25]);
    legend('Supine','Standing');
    box on
    grid off
    

    figure(4) 
    subplot(3, 2, 1) %SPV
    X = categorical({'#1','#2','#3', '# 1 ','# 2 ','# 3 '});
    X = reordercats(X,{'#1','#2','#3', '# 1','# 2','# 3'});
    a = [nanmean(store(1).beatSpUp); nanmean(store(2).beatSpUp)];
    b = [nanmean(store(1).beatSpDn); nanmean(store(2).beatSpDn)];
    y = [abs(a) abs(b)]';
    mybarplt = bar(y, 'grouped', 'BarWidth', 1, ...
        'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
    [ngroups,nbars] = size(y);
    % Get the x coordinate of the bars
    x = nan(nbars, ngroups);
    for i = 1:nbars
        x(i,:) = mybarplt(i).XEndPoints;
    end
    a = [nanstd(store(1).beatSpUp); nanstd(store(2).beatSpUp)];
    b = [nanstd(store(1).beatSpDn); nanstd(store(2).beatSpDn)];
    err = [a b]';
    neg = zeros(size(err));
    e = errorbar(x',y,neg, err, 'k','linestyle','none');
    mybarplt(1).CData =[1 1 1];
    mybarplt(2).CData =[0.4 0.4 0.4];
    mybarplt(1).CData =[1 1 1];
    mybarplt(2).CData =[0.4 0.4 0.4];
   % ylim([0 4]);
    title('\Delta SPV')
    legend('Supine','Standing');
    box on
    grid off
    ylabel(' [mmHg]'); 
    
    subplot(3,2, 2) %SPV
    X = categorical({'#1','#2','#3', '# 1 ','# 2 ','# 3 '});
    X = reordercats(X,{'#1','#2','#3', '# 1','# 2','# 3'});
    a = [nanmean(store(1).beatSpUp_lag1); nanmean(store(2).beatSpUp_lag1)];
    b = [nanmean(store(1).beatSpDn_lag1); nanmean(store(2).beatSpDn_lag1)];
    y = [abs(a) abs(b)]';
    mybarplt = bar(y, 'grouped', 'BarWidth', 1, ...
        'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
    [ngroups,nbars] = size(y);
    % Get the x coordinate of the bars
    x = nan(nbars, ngroups);
    for i = 1:nbars
        x(i,:) = mybarplt(i).XEndPoints;
    end
    a = [nanstd(store(1).beatSpUp_lag1); nanstd(store(2).beatSpUp_lag1)];
    b = [nanstd(store(1).beatSpDn_lag1); nanstd(store(2).beatSpDn_lag1)];
    err = [a b]';
    neg = zeros(size(err));
    e = errorbar(x',y,neg, err, 'k','linestyle','none');
    mybarplt(1).CData =[1 1 1];
    mybarplt(2).CData =[0.4 0.4 0.4];
    mybarplt(1).CData =[1 1 1];
    mybarplt(2).CData =[0.4 0.4 0.4];
   % ylim([0 4]);
    title('\Delta SPV')
    legend('Supine','Standing');
    box on
    grid off
    ylabel(' norm'); 
    
%     subplot(2,2,2)
%     X = categorical({'Beat 1','Beat 2','Beat 3'});
%     X = reordercats(X,{'Beat 1','Beat 2','Beat 3'});
%     mybarplt = bar(X, [-nanmean(store(1).beatSpDn); -nanmean(store(2).beatSpDn)]', 1, ...
%         'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%     mybarplt(1).CData =[1 1 1];
%     mybarplt(2).CData =[0.4 0.4 0.4];
%     title('(b) Descending sequence')
%     ylim([0 4]);
%     legend('Supine','Standing');
%     box on
%     grid off
%     han=axes(fig4,'visible','off');
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han, 'Beat to beat SPV in baroreflex sequences [mmHg]'); 
    
%     subplot(2,1,2)
%     X = categorical({'Beat 1','Beat 2','Beat 3', 'lala 1 ','lala 2 ','lala 3 '});
%     X = reordercats(X,{'Beat 1','Beat 2','Beat 3', 'lala 1 ','lala 2 ','lala 3 '});
%     a = [nanmean(store(1).beatSpUp_lag1); nanmean(store(2).beatSpUp_lag1)];
%     b = [-nanmean(store(1).beatSpDn_lag1); -nanmean(store(2).beatSpDn_lag1)];
%     mybarplt = bar(X, [a b]', 'BarWidth', 1, ...
%         'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%     mybarplt(1).CData =[1 1 1];
%     mybarplt(2).CData =[0.4 0.4 0.4];
%     %title('(c) Ascending sequence')
%     ylim([0 4.5]);
%     legend('Supine','Standing');
%     box on
%     grid off
%     han=axes(fig4,'visible','off');
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     title('Lag 1')
%     ylabel(han, 'Beat to beat SPV in baroreflex sequences [mmHg]'); 
%     
%     subplot(2,2,4)
%     X = categorical({'Beat 1','Beat 2','Beat 3'});
%     X = reordercats(X,{'Beat 1','Beat 2','Beat 3'});
%     mybarplt = bar(X, [-nanmean(store(1).beatSpDn_lag1); -nanmean(store(2).beatSpDn_lag1)]', 1, ...
%         'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%     mybarplt(1).CData =[1 1 1];
%     mybarplt(2).CData =[0.4 0.4 0.4];
%     title('(d) Descending sequence')
%     ylim([0 4]);
%     legend('Supine','Standing');
%     box on
%     grid off
%     han=axes(fig4,'visible','off');
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han, 'Beat to beat SPV in baroreflex sequences [mmHg]'); 
     
    subplot(3,2, 3) % HRV
    a = [nanmean(store(1).beatRRUp); nanmean(store(2).beatRRUp)];
    b = [nanmean(store(1).beatRRDn); nanmean(store(2).beatRRDn)];
    y = [abs(a) abs(b)]';
    mybarplt = bar(y, 'grouped', 'BarWidth', 1, ...
        'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
    mybarplt(1).CData =[1 1 1];
    mybarplt(2).CData =[0.4 0.4 0.4];
    [ngroups,nbars] = size(y);
    % Get the x coordinate of the bars
    x = nan(nbars, ngroups);
    for i = 1:nbars
        x(i,:) = mybarplt(i).XEndPoints;
    end
    a = [nanstd(store(1).beatRRUp); nanstd(store(2).beatRRUp)];
    b = [nanstd(store(1).beatRRDn); nanstd(store(2).beatRRDn)];
    err = [a b]';
    neg = zeros(size(err));
    e = errorbar(x',y,neg, err, 'k','linestyle','none');
    title('\Delta HRV')
    %ylim([0 4]);
    legend('Supine','Standing');
    box on
    grid off
    ylabel(' [ms]'); 
    
    subplot(3,2, 4) % HRV
    a = [nanmean(store(1).beatRRUp_lag1); nanmean(store(2).beatRRUp_lag1)];
    b = [nanmean(store(1).beatRRDn_lag1); nanmean(store(2).beatRRDn_lag1)];
    y = [abs(a) abs(b)]';
    mybarplt = bar(y, 'grouped', 'BarWidth', 1, ...
        'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
    mybarplt(1).CData =[1 1 1];
    mybarplt(2).CData =[0.4 0.4 0.4];
    [ngroups,nbars] = size(y);
    % Get the x coordinate of the bars
    x = nan(nbars, ngroups);
    for i = 1:nbars
        x(i,:) = mybarplt(i).XEndPoints;
    end
    a = [nanstd(store(1).beatRRUp_lag1); nanstd(store(2).beatRRUp_lag1)];
    b = [nanstd(store(1).beatRRDn_lag1); nanstd(store(2).beatRRDn_lag1)];
    err = [a b]';
    neg = zeros(size(err));
    e = errorbar(x',y,neg, err, 'k','linestyle','none');
    title('\Delta HRV')
    %ylim([0 4]);
    legend('Supine','Standing');
    box on
    grid off
    ylabel(' norm'); 
%     
%     subplot(2,2,2)
%     X = categorical({'Beat 1','Beat 2','Beat 3'});
%     X = reordercats(X,{'Beat 1','Beat 2','Beat 3'});
%     mybarplt = bar(X, [-nanmean(store(1).beatRRDn); -nanmean(store(2).beatRRDn)]', 1, ...
%         'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%     mybarplt(1).CData =[1 1 1];
%     mybarplt(2).CData =[0.4 0.4 0.4];
%     title('(b) Descending sequence')
%     %ylim([0 4]);
%     legend('Supine','Standing');
%     box on
%     grid off
%     han=axes(fig5,'visible','off');
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han, 'Beat to beat HRV in baroreflex sequences [ms]'); 
%     xlabel(han,'Sequence');
    
%     subplot(3,2, 5) % HRV
%     X = categorical({'#1','#2','#3', '# 1 ','# 2 ','# 3 '});
%     X = reordercats(X,{'#1','#2','#3', '# 1','# 2','# 3'});
%     a = [nanmean(store(1).beatRRUp_lag1); nanmean(store(2).beatRRUp_lag1)];
%     b = [-nanmean(store(1).beatRRDn_lag1); -nanmean(store(2).beatRRDn_lag1)];
%     y = [a b]';
%     mybarplt = bar(y, 'grouped', 'BarWidth', 1, ...
%         'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%     mybarplt(1).CData =[1 1 1];
%     mybarplt(2).CData =[0.4 0.4 0.4];
%     [ngroups,nbars] = size(y);
%     % Get the x coordinate of the bars
%     x = nan(nbars, ngroups);
%     for i = 1:nbars
%         x(i,:) = mybarplt(i).XEndPoints;
%     end
%     a = [nanstd(store(1).beatRRUp_lag1); nanstd(store(2).beatRRUp_lag1)];
%     b = [nanstd(store(1).beatRRDn_lag1); nanstd(store(2).beatRRDn_lag1)];
%     err = [a b]';
%     neg = zeros(size(err));
%     e = errorbar(x',y,neg, err, 'k','linestyle','none');
%     %ylim([0 4]);
%     legend('Supine','Standing');
%     title('\Delta HRV Lag 1')
%     box on
%     grid off
%     ylabel(' [ms]'); 
    
%     subplot(2,2,4)
%     X = categorical({'Beat 1','Beat 2','Beat 3'});
%     X = reordercats(X,{'Beat 1','Beat 2','Beat 3'});
%     mybarplt = bar(X, [-nanmean(store(1).beatRRDn_lag1_norm); -nanmean(store(2).beatRRDn_lag1_norm)]', 1, ...
%         'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%     mybarplt(1).CData =[1 1 1];
%     mybarplt(2).CData =[0.4 0.4 0.4];
%     title('(d) Descending sequence')
%     %ylim([0 4]);
%     legend('Supine','Standing');
%     box on
%     grid off
%     han=axes(fig5,'visible','off');
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han, 'Beat to beat HRV in baroreflex sequences [ms]'); 
%     xlabel(han,'Sequence');
    
%     figure(6) % BRS comparison ellipse & reg
%     set(gcf,'color','w');
%     X = categorical({'0','1', 'lala 0', 'lala 1'});
%     X = reordercats(X, {'0','1', 'lala 0', 'lala 1'});
% 
% %     X = categorical({'Ellipse', 'Regression'});
% %     X = reordercats(X, {'Ellipse', 'Regression'});
%     
%     a = [nanmedian( store(1).ellipseSlopeAll ), nanmedian( store(2).ellipseSlopeAll ); nanmedian( store(1).ellipseSlope_lag1 ), ...
%          nanmedian( store(2).ellipseSlope_lag1 )];
%     b = [nanmedian( store(1).SlopeAll ) , nanmedian( store(2).SlopeAll ); nanmedian( store(1).lag1 ), ...
%          nanmedian( store(2).lag1 )];
% %     a = [ nanmedian( boxPlt.allellipseSlopeC(:, 1) ), nanmedian( boxPlt.allellipseSlopeC(:, 2) )];
% %     b = [ median([store(1).SlopeUpC; store(1).SlopeDnC]), median([store(2).SlopeUpC; store(2).SlopeDnC]) ]; 
%     mybarplt = bar(X, [a; b], 'BarWidth', 1, ...
%         'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%     
%     %ylim([0 25]);
%     legend('Supine','Standing');
%     box on
%     grid off
%     han=axes(fig6,'visible','off');
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han, 'BRS [ms/mmHg]'); 
%     xlabel(han,'Sequence');
%     ylim([0 15])
   
%     figure(7) % HRV for seq within cycle
%     set(gcf, 'color', 'w')
%     X = categorical({'Beat 1','Beat 2','Beat 3', 'lala 1 ','lala 2 ','lala 3 '});
%     X = reordercats(X,{'Beat 1','Beat 2','Beat 3', 'lala 1 ','lala 2 ','lala 3 '});
%     a = [nanmean(store(1).beatRRUpC); nanmean(store(2).beatRRUpC)];
%     b = [nanmean(store(1).beatRRDnC); nanmean(store(2).beatRRDnC)];
%     mybarplt = bar(X, [a b]', 'BarWidth', 1, ...
%         'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%     mybarplt(1).CData =[1 1 1];
%     mybarplt(2).CData =[0.4 0.4 0.4];
%     %ylim([0 4]);
%     legend('Supine','Standing');
%     box on
%     grid off
%     han=axes(fig5,'visible','off');
%     han.Title.Visible='on';
%     han.XLabel.Visible='on';
%     han.YLabel.Visible='on';
%     ylabel(han, 'Beat to beat HRV in baroreflex sequences [mmHg]'); 
%     title('For sequences within cycles')
%   
%     
%     set(0,'DefaultAxesFontName','Arial');
%     set(0, 'DefaultAxesFontSize', 12);
%     set(0, 'defaultAxesFontWeight', 'normal') 
    
    figure(4)
    a = [abs( nanmean(store(1).beatRRUp)./nanmean(store(1).beatSpUp) ); abs( nanmean(store(2).beatRRUp)./nanmean(store(2).beatSpUp) )];
    b = [abs( nanmean(store(1).beatRRDn)./-nanmean(store(1).beatSpDn) ); abs( nanmean(store(2).beatRRDn)./nanmean(store(2).beatSpDn) )];
%     c = [nanmean(store(1).beatRRUp_lag1)./nanmean(store(1).beatSpUp); nanmean(store(2).beatRRUp_lag1)./nanmean(store(2).beatSpUp)];
%     d = [-nanmean(store(1).beatRRDn_lag1)./-nanmean(store(1).beatSpDn); -nanmean(store(2).beatRRDn_lag1)./-nanmean(store(2).beatSpDn)];
    subplot(3,2, 5) % brs lag 0
    X = categorical({'#1','#2','#3', '# 1 ','# 2 ','# 3 '});
    X = reordercats(X,{'#1','#2','#3', '# 1','# 2','# 3'});
    y = [a b]';
    mybarplt = bar(y, 'grouped', 'BarWidth', 1, ...
        'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
    mybarplt(1).CData =[1 1 1];
    mybarplt(2).CData =[0.4 0.4 0.4];
    a = [ nanstd(store(1).beatRRUp)./nanstd(store(1).beatSpUp) ; nanstd(store(2).beatRRUp)./nanstd(store(2).beatSpUp) ];
    b = [ nanstd(store(1).beatRRDn)./nanstd(store(1).beatSpDn) ; nanstd(store(2).beatRRDn)./nanstd(store(2).beatSpDn) ];
    [ngroups,nbars] = size(y);
    % Get the x coordinate of the bars
    x = nan(nbars, ngroups);
    for i = 1:nbars
        x(i,:) = mybarplt(i).XEndPoints;
    end
    err = [a b]';
    neg = zeros(size(err));
    e = errorbar(x',y,neg, err, 'k','linestyle','none');
    %ylim([0 4]);
    legend('Supine','Standing');
    box on
    grid off
    title(' Brs ')
    ylabel(' [ms/mmHg]'); 
    
    a = [abs( nanmean(store(1).beatRRUp_lag1)./nanmean(store(1).beatSpUp_lag1) ); abs( nanmean(store(2).beatRRUp_lag1)./nanmean(store(2).beatSpUp_lag1) )];
    b = [abs( nanmean(store(1).beatRRDn_lag1)./nanmean(store(1).beatSpDn_lag1) ); abs( nanmean(store(2).beatRRDn_lag1)./nanmean(store(2).beatSpDn_lag1) )];
    subplot(3,2, 6) % brs lag 0
    X = categorical({'#1','#2','#3', '# 1 ','# 2 ','# 3 '});
    X = reordercats(X,{'#1','#2','#3', '# 1','# 2','# 3'});
    y = [a b]';
    mybarplt = bar(y, 'grouped', 'BarWidth', 1, ...
        'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
    mybarplt(1).CData =[1 1 1];
    mybarplt(2).CData =[0.4 0.4 0.4];
    a = [ nanstd(store(1).beatRRUp_lag1)./nanstd(store(1).beatSpUp_lag1) ; nanstd(store(2).beatRRUp_lag1)./nanstd(store(2).beatSpUp_lag1) ];
    b = [ nanstd(store(1).beatRRDn_lag1)./nanstd(store(1).beatSpDn_lag1) ; nanstd(store(2).beatRRDn_lag1)./nanstd(store(2).beatSpDn_lag1) ];
    [ngroups,nbars] = size(y);
    % Get the x coordinate of the bars
    x = nan(nbars, ngroups);
    for i = 1:nbars
        x(i,:) = mybarplt(i).XEndPoints;
    end
    err = [a b]';
    neg = zeros(size(err));
    e = errorbar(x',y,neg, err, 'k','linestyle','none');
    %ylim([0 4]);
    legend('Supine','Standing');
    box on
    grid off
    title(' Brs')
    ylabel(' norm'); 
    
%     subplot(3,2, 6) % brs lag 1
%     X = categorical({'#1','#2','#3', '# 1 ','# 2 ','# 3 '});
%     X = reordercats(X,{'#1','#2','#3', '# 1','# 2','# 3'});
%     y = [c d]';
%     mybarplt = bar(y, 'grouped', 'BarWidth', 1, ...
%         'FaceColor', 'flat', 'FaceAlpha', 1); hold on;
%     mybarplt(1).CData =[1 1 1];
%     mybarplt(2).CData =[0.4 0.4 0.4];
%     [ngroups,nbars] = size(y);
%     % Get the x coordinate of the bars
%     x = nan(nbars, ngroups);
%     for i = 1:nbars
%         x(i,:) = mybarplt(i).XEndPoints;
%     end
%     c = [nanstd(store(1).beatRRUp_lag1)./nanstd(store(1).beatSpUp); nanstd(store(2).beatRRUp)./nanstd(store(2).beatSpUp)];
%     d = [-nanstd(store(1).beatRRDn_lag1)./-nanstd(store(1).beatSpDn); -nanstd(store(2).beatRRDn_lag1)./-nanstd(store(2).beatSpDn)];
%     err = [c d]';
%     neg = zeros(size(err));
%     e = errorbar(x',y,neg, err, 'k','linestyle','none');
%     %ylim([0 4]);
%     legend('Supine','Standing');
%     box on
%     grid off
%     title(' Brs Lag 1')
%     ylabel(' [ms/mmHg]');
%     
%     subplot(3, 1, 3)
%     beatdiffbxplot = NaN( max( [length(store(1).beatRRUpC),  length(store(1).beatRRDnC), ...
%         length(store(2).beatRRUpC),  length(store(2).beatRRDnC)]) , 8);
%     beatdiffbxplot(1:length(store(1).beatRRUpC), 1) = store(1).beatRRUpC(:, 2) - store(1).beatRRUpC(:, 1);
%     beatdiffbxplot(1:length(store(2).beatRRUpC), 2) = store(2).beatRRUpC(:, 2) - store(2).beatRRUpC(:, 1);
%     beatdiffbxplot(1:length(store(1).beatRRUpC), 3) = store(1).beatRRUpC(:, 3) - store(1).beatRRUpC(:, 2);
%     beatdiffbxplot(1:length(store(2).beatRRUpC), 4) = store(2).beatRRUpC(:, 3) - store(2).beatRRUpC(:, 2);
%     beatdiffbxplot(1:length(store(1).beatRRDnC), 5) = store(1).beatRRDnC(:, 2) - store(1).beatRRDnC(:, 1);
%     beatdiffbxplot(1:length(store(2).beatRRDnC), 6) = store(2).beatRRDnC(:, 2) - store(2).beatRRDnC(:, 1);
%     beatdiffbxplot(1:length(store(1).beatRRDnC), 7) = store(1).beatRRDnC(:, 3) - store(1).beatRRDnC(:, 2);
%     beatdiffbxplot(1:length(store(2).beatRRDnC), 8) = store(2).beatRRDnC(:, 3) - store(2).beatRRDnC(:, 2);
%     beatdiffcolors = [0 0 0; 0.5 0.5 0.5; 0 0 0; 0.5 0.5 0.5; 0 0 0; 0.5 0.5 0.5; 0 0 0; 0.5 0.5 0.5];
%     boxplot(beatdiffbxplot, 'PlotStyle', 'compact', 'Colors', beatdiffcolors, 'Symbol',...
%         ' ', 'Positions', [0.95 1.05 1.45 1.55 1.95 2.05 2.45 2.55]); hold on;
    
%     ylim([-75 75])
%     ylabel('ms')
%     beatdiffbxplot = NaN( max( [length(store(1).beatSpUp),  length(store(1).beatSpDn), ...
%         length(store(2).beatSpUp),  length(store(2).beatSpDn)]) , 8);
%     beatdiffbxplot(1:length(store(1).beatSpUpC), 1) = store(1).beatSpUpC(:, 2) - store(1).beatSpUpC(:, 1);
%     beatdiffbxplot(1:length(store(2).beatSpUpC), 2) = store(2).beatSpUpC(:, 2) - store(2).beatSpUpC(:, 1);
%     beatdiffbxplot(1:length(store(1).beatSpUpC), 3) = store(1).beatSpUpC(:, 3) - store(1).beatSpUpC(:, 2);
%     beatdiffbxplot(1:length(store(2).beatSpUp), 4) = store(2).beatSpUp(:, 3) - store(2).beatSpUp(:, 2);
%     beatdiffbxplot(1:length(store(1).beatSpDn), 5) = store(1).beatSpDn(:, 2) - store(1).beatSpDn(:, 1);
%     beatdiffbxplot(1:length(store(2).beatSpDn), 6) = store(2).beatSpDn(:, 2) - store(2).beatSpDn(:, 1);
%     beatdiffbxplot(1:length(store(1).beatSpDn), 7) = store(1).beatSpDn(:, 3) - store(1).beatSpDn(:, 2);
%     beatdiffbxplot(1:length(store(2).beatSpDn), 8) = store(2).beatSpDn(:, 3) - store(2).beatSpDn(:, 2);
%     yyaxis right
%     ylabel('mmHg')
%     boxplot(beatdiffbxplot, 'PlotStyle', 'compact', 'Colors', beatdiffcolors, 'Symbol',...
%         ' ', 'Positions', [3.45 3.55 3.95 4.05 4.45 4.55 4.95 5.05]); hold on;
%     ylim([-7 7])
%     xlim([0.5 5.5])
%     xline(3)
%     xticks([1 1.5 2 2.5 3.5 4 4.5 5])
%     xticklabels({' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '})
%     ax = gca;
%     ax.YAxis(1).Color = 'k';
%     ax.YAxis(2).Color = 'k';
 
end 