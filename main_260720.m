clc
clear
close all

if ~exist('res', 'var')

%% Initialization
res = Datasort;
%%  Detection of R peaks (ECG) and systolic and diastolic BP peaks
res = findThePeaks(res);
%% Visual verification of found peaks 
debug = 1;
if debug == 1
    plotThePeaks(res, 1)
end 
%% Finding baroreflex (ascending and descending) sequences and cycles
debug = 0;
% if debug == 3
%     figure
%     title(join(['Baroreflex cycles for subject ' dataNum]))
% end
for iPosition = 1:2
    
%      if debug == 1
%         subplot(1, 2, iPosition)
%         sgtitle(join(['Baroreflex cycles for subject ' dataNum]))
%     end
        % 0 --> no plots
        % 1 --> plot just cycles
        % 2 --> plot results of regression method for cycles
        % 3 --> plot results of ellipse method for cycles
        % 4 --> plot results of ellipse method for sequences
        
    for iSubject = 1:21
        RpLoc    =  res(iPosition).AB(iSubject).RpLoc .* 2; % in ms
        Rp       = res(iPosition).AB(iSubject).Rp ; %in mV
        rrInt    = res(iPosition).AB(iSubject).rrInt ; % in ms
        SpLoc    = res(iPosition).AB(iSubject).SpLoc .* 2 ;% in ms
        Sp       = res(iPosition).AB(iSubject).Sp ; %in mmHg
        minSeq   = 2 ; %minimum amount of beats for baroreflex sequence to be valid
        position = res(iPosition).position ;
        fs = res(iPosition).fs;
        dataNum = res(iPosition).ID(iSubject);
        
%         % time domain; lag 0; cycles method
         [res(iPosition).BRS(iSubject).UpSeq, res(iPosition).BRS(iSubject).DnSeq, res(iPosition).BRS(iSubject).BrsCycle] = baroreflex_calculation_260720(RpLoc, Rp, rrInt, SpLoc, Sp,...
             minSeq, position, debug, dataNum, fs, 0);
%         % time domain; lag 1
     %   [res(iPosition).BRS(iSubject).lag1_Up, res(iPosition).BRS(iSubject).lag1_Dn, res(iPosition).BRS(iSubject).BrsCycle_lag1] = baroreflex_calculation_260720(RpLoc, Rp, rrInt, SpLoc, Sp,...
     %      minSeq, position, debug, dataNum, fs, 1);
%         % time domain; lag 2
%         [res(iPosition).BRS(iSubject).lag2_Up, res(iPosition).BRS(iSubject).lag2_Dn,~ ] = baroreflex_calculation_260720(RpLoc, Rp, rrInt, SpLoc, Sp,...
%            minSeq, position, debug, dataNum, fs, 2);
        
        debug = 0;
       % BRS calculation in frequency domain
      %   [res(iPosition).BRS(iSubject).psd, res(iPosition).BRS(iSubject).fft] = BP_HRV_Frequency_Domain(RpLoc, rrInt, SpLoc, Sp, position, debug, dataNum);
%         
%         

    end 
end  
clear RpLoc Rp rrInt SpLoc Sp minSeq position fs dataNum % clear auxiliary variables

%%
subjects = 1:21;
debug = 0;
% dn up cycles
res2 =  my_baroreflex(res, debug, subjects);

%join dn up cycles
for iPosition = 1:2
    for iSubject = 1:21
        res(iPosition).BRS(iSubject).BrsCycle = [res(iPosition).BRS(iSubject).BrsCycle res2(iPosition).BRS(iSubject).BrsCycle];
    end
end



%% Visual verification of detected baroreflex sequences
debug = 1;
if debug == 1
	plotTheSeq(res, 1)
    
end
clc
end

%% Save
save('res.mat', 'res');

%% 

clc
clear
close all


if ~exist('res', 'var') 
    load res
end


%% store RRint, Sp, Dp, freq domain ratios, sequence and cycle info
subjects = 1:21;

     store = storing(res, subjects); 

%%
    stats = statistics(store);
% 


%% for 4 subjects: delta setpoint vs delta BRS
figure
set(gcf, 'Color', 'w')
for iPosition = 1:2
    subplot(1, 2, iPosition)
    title(res(iPosition).position)
        yyaxis left
        for i=1:4
        scatter( 1, repSub(iPosition).setpoint(i).mean, 30, 'k', '.'); hold on;
        end
        %ylim([-100 200])storing
        
        ylabel('$\Delta$ setpoint (ms)', 'Interpreter', 'latex')


        yyaxis right 
        for i=1:4
            scatter( 3, repSub(iPosition).deltaBRS(i).mean, 30, [0 0.4470 0.7410] , 's'); hold on;
        end
        ylabel('$\Delta$ BRS (ms/mmHg)', 'Interpreter', 'latex')
        %ylim([-35 35])
        
        xlim([0 4])
        
        ax = gca;
        ax.YAxis(1).Color = 'k';
        ax.YAxis(2).Color = [0 0.4470 0.7410];
        set(gca,'XTick',[ ]);
            
end


%% plotting ellipse method sequences + cycle
debug = 1;
if debug == 1
    iCycle = 8;
    iSubject = 1;
    iPosition = 1;
    plotEllipseMethod(iCycle, iSubject, iPosition, res)
end 

%% storing for boxplots

boxPlt = storingBoxplt(store);



%% BOXPLOTS: plotting regression method
debug = 0;
if debug == 1
    % Ellipse method for sequences: length of minor axis
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.SeqEllipsel,'color', 'rk', 'FactorGap', 5);
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    title('Length of minor axis of sequence obtained with ellipse method')
    ylim([0 12])
    box off
    grid on
    disp(join(['P value for ascending sequence: ', num2str(stats(1).UpSeqEllipsel.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).DnSeqEllipsel.pvalue)]))

     % Ellipse method for sequences: viscoelasticity coefficient
    figure
    set(gcf,'color','w');
    c = [0 0 0; 0.5 0.5 0.5];
    boxplot(boxPlt.G,'color', c, 'FactorGap', 5, 'PlotStyle','compact', 'Symbol', ' ');
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Standing', 'Supine'});
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    title('Viscoelasticity coefficient of arteries')
    ylim([0 2])
    
    % Error of estimate 
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.error, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'}, 'FontSize', 10);
    title('Error of estimate of regression method', 'FontSize', 12);
    axis([0.5 5 0 3]);
    ylabel('$(ms^{2} + mmHg^{2})^{\frac{1}{2}}$','Interpreter','latex', 'FontSize', 12);
    box off
    grid on
    disp(join(['P value for ascending sequence: ', num2str(stats(1).errorUp.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).errorDn.pvalue)]))

    % Error of estimate wo lag 0
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.error_wo, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('Error of estimate of regression method (excluing first beat to beat segment)')
    axis([0.5 5 0 1.5]);
    ylabel('$\mathrm{(ms^{2} + mmHg^{2})^{\frac{1}{2}} }$','Interpreter','latex')
    box off
    grid on
    disp(join(['P value for ascending sequence: ', num2str(stats(1).errorUp_wo.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).errorDn_wo.pvalue)]))

    % Summed error of estimate 
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.errorSum, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('Summed error of estimate of regression method')
    axis([0.5 5 0 8.5]);
    ylabel('$(ms^{2} + mmHg^{2})^{\frac{1}{2}}$','Interpreter','latex')
    box off
    grid on
    disp(join(['P value for ascending sequence: ', num2str(stats(1).errorSumUp.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).errorSumDn.pvalue)]))

    %  BRS with reg: up + dn separated
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.Slope, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('BRS of all sequences with regression method')
    axis([0.5 5 0 40]);
    ylabel('BRS (ms/mmHg)')
    box on
    grid off
    disp(join(['P value for ascending sequence: ', num2str(stats(1).SlopeUp.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).SlopeDn.pvalue)]))
    
    figure
    %  BRS with reg: up + dn together
    set(gcf,'color','w');
    boxplot(boxPlt.allSlope, 'color','rk','PlotStyle', 'Compact'); hold on;
    mybxplt = findall(gca,'Tag','Box');
    set(gca,'xticklabel',{'Supine','Upright'})
    %  BRS with regression for sequence within cycle: wo differentiation up + dn
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.allSlopeC, 'color','rk','PlotStyle', 'Compact'); hold on;
    set(gca,'xticklabel',{'Supine','Standing'})
    mybxplt = findall(gca,'Tag','Box');
    ylim([0 55]);
    ylabel('BRS (ms/mmHg)')
    title('Regression, cycles')
    %  BRS of all sequences with ellipse method wo up/dn
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.allellipseSlopeSeq, 'color','rk', 'FactorGap', 5);
    set(gca,'xticklabel',{'Supine','Standing'})
    mybxplt = findall(gca,'Tag','Box');
    title('Ellipse, all')
    ylim([0 55]);
    ylabel('BRS (ms/mmHg)')
    %  BRS of sequence within cycle with ellipse method: no differentiation between up and dn
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.allellipseSlopeC, 'color','rk', 'FactorGap', 5);
    set(gca,'xticklabel',{'Supine','Upright'})
    mybxplt = findall(gca,'Tag','Box');
    title('Ellipse, cycles')
    ylim([0 55]);
    ylabel('BRS (ms/mmHg)')
    
  

    %  Slope of sequence wo lag 0
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.Slope_wo, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('Slope of axis of sequence for regression method (excluing first beat to beat segment)')
    axis([0.5 5 0 70]);
    ylabel('BRS (ms/mmHg)')
    box off
    grid on
    disp(join(['P value for ascending sequence: ', num2str(stats(1).SlopeUp_wo.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).SlopeDn_wo.pvalue)]))
    
    %  BRS with regression for sequence within cycle: differentiation up + dn
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.SlopeC, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('BRS of sequences within cycle with regression method')
    axis([0.5 5 0 50]);
    ylabel('BRS (ms/mmHg)')
    box on
    grid off
    disp(join(['P value for ascending sequence: ', num2str(stats(1).SlopeUpC.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).SlopeDnC.pvalue)]))

    %  BRS of sequence within cycle with ellipse method: differentiation between up and dn
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.ellipseSlopeC, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('BRS of sequences within cycle with ellipse method')
    axis([0.5 5 0 55]);
    ylabel('BRS (ms/mmHg)')
    box on
    grid off
    disp(join(['P value for ascending sequence: ', num2str(stats(1).ellipseSlopeUpC.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).ellipseSlopeDnC.pvalue)]))
    
    %  BRS of all sequences with ellipse method with up/dn
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.ellipseSlopeSeq, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('BRS of all sequences with ellipse method')
    axis([0.5 5 0 50]);
    ylabel('BRS (ms/mmHg)')
    box on
    grid off
    disp(join(['P value for ascending sequence: ', num2str(stats(1).ellipseSlopeUp.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).ellipseSlopeDn.pvalue)]))
    
    
    
  

    % Error of estimate (for sequences within cycle)
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.errorC, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('Error of estimate of regression method (for sequences within cycle)')
    axis([0.5 5 0 3.5]);
    ylabel('$(ms^{2} + mmHg^{2})^{\frac{1}{2}}$','Interpreter','latex')
    box off
    grid on
    disp(join(['P value for ascending sequence: ', num2str(stats(1).errorUpC.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).errorDnC.pvalue)]))

    % Summed error of estimate (for seq within cycle)
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.errorSumC, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Ascending sequence','Descending sequence'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('Summed error of estimate of regression method (for sequences within cycle)')
    axis([0.5 5 0 11]);
    ylabel('$(ms^{2} + mmHg^{2})^{\frac{1}{2}}$','Interpreter','latex')
    box off
    grid on
    disp(join(['P value for ascending sequence: ', num2str(stats(1).errorSumUpC.pvalue)]))
    disp(join(['P value for descending sequence: ', num2str(stats(1).errorSumDnC.pvalue)]))

    % Length of major axis
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.RegL,  {'Supine', 'Tilt'}, 'color', 'rk');
    title('Normalized length of major axis obtained with regression method')
    ylim([0 200])
    box off
    grid on
    disp(join(['P value: ', num2str(stats(1).RegL.pvalue)]))

    % Length of minor axis
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.Regl, {'Supine', 'Tilt'}, 'color', 'rk');
    title('Normalized length of minor axis obtained with regression method')
    ylim([0 20])
    box off
    grid on
    disp(join(['P value : ', num2str(stats(1).Regl.pvalue)]))

    % Length of major and minor axes together in one boxplot
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.allRegL, 'color','rk', 'FactorGap', 5);
    set(gca,'xtick',[1.5 3.8])
    set(gca,'xticklabel',{'Major Axis','Minor Axis'})
    mybxplt = findall(gca,'Tag','Box');
    legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
    title('Normalized length of axes obtained with regression method')
    axis([0.5 5 0 200]);
    box off
    grid on

    % Slope of major axis
    figure
    set(gcf,'color','w');
    boxplot(boxPlt.RegSlope, {'Supine', 'Upright'}, 'color', 'rk');
    title('BRS of cycle with regression method')
    ylabel('BRS (ms/mmHg)')
    ylim([0 40])
    box on 
    grid off
    disp(join(['P value: ', num2str(stats(1).RegSlope.pvalue)]))

        % Length of major axis
        figure
        set(gcf,'color','w');
        boxplot(boxPlt.EllipseL,  {'Supine', 'Tilt'}, 'color', 'rk', 'PlotStyle', 'Compact');
        title('Length of major axis obtained with ellipse method')
        ylim([0 200])
        disp(join(['P value: ', num2str(stats(1).EllipseL.pvalue)]))

        % Length of minor axis
        figure
        set(gcf,'color','w');
        boxplot(boxPlt.Ellipsel, {'Supine', 'Tilt'}, 'color', 'rk');
        title('Length of minor axis obtained with ellipse method')
        ylim([0 15])
        disp(join(['P value: ', num2str(stats(1).Ellipsel.pvalue)]))

        % Length of major and minor axes together in one boxplot
        figure
        set(gcf,'color','w');
        boxplot(boxPlt.allEllipseL, 'color','rk', 'FactorGap', 5);
        set(gca,'xtick',[1.5 3.8])
        set(gca,'xticklabel',{'Major Axis','Minor Axis'})
        mybxplt = findall(gca,'Tag','Box');
        legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
        title('Normalized length of axes obtained with ellipse method')
        axis([0.5 5 0 200]);
        box off
        grid on

        % Slope of major axis
        figure
        set(gcf,'color','w');
        boxplot(boxPlt.EllipseSlope, {'Supine', 'Upright'}, 'color', 'rk');
        title('Slope of major axis obtained with ellipse method')
        ylabel('BRS (ms/mmHg)')
        ylim([0 50])
        box on
        disp(join(['P value: ', num2str(stats(1).EllipseSlope.pvalue)]))
        
        % Ellipse orientation (atan of slope)
        figure
        set(gcf,'color','w');
        boxplot(atand(boxPlt.EllipseSlope), {'Supine', 'Upright'}, 'color', 'rk');
        title('Slope of major axis obtained with ellipse method')
        ylabel('BRS (ms/mmHg)')
        ylim([70 91])
        box on
        
        %both methods together
        figure
        set(gcf,'color','w');
        boxplot([boxPlt.RegSlope boxPlt.EllipseSlope], 'color', 'rk', 'FactorGap', 5);
        title('Slope of major axis')
        set(gca,'xtick',[1.5 3.8])
        set(gca,'xticklabel',{'Regression method','Ellipse Method'})
        mybxplt = findall(gca,'Tag','Box');
        legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
        ylabel('BRS (ms/mmHg)')
        ylim([0 50])
        box off
        grid on
        
        figure
        set(gcf,'color','w');
        boxplot([boxPlt.RegL boxPlt.EllipseL], 'color', 'rk', 'FactorGap', 5);
        title('Normalized length of major axis')
        set(gca,'xtick',[1.5 3.8])
        set(gca,'xticklabel',{'Regression method','Ellipse Method'})
        mybxplt = findall(gca,'Tag','Box');
        legend([mybxplt(1), mybxplt(2)], {'Upright', 'Supine'});
        ylim([0 200])
        box off
        grid on
        
        % ellipse Area
       figure
       boxplot(boxPlt.ellipseArea, 'Labels', {'Supine', 'Upright'}, 'color', 'rk')
       ylim([0 850]);
       title('Area of ellipse')
       ylabel('[ms*mmHg]')
       box on
       grid off
       disp(join(['P value: ', num2str(stats(1).ellipseArea.pvalue)]))
       
       %projection angle of ellipse into circle
       figure
       boxplot(boxPlt.ProjAngle, 'color' , 'rk', 'PlotStyle', 'compact', 'Symbol', ' ')
       ylim([75 90]);
       title('Orientation of projection plane of ellipse into circle')
       ylabel('[°]')
       box off
       grid on
       disp(join(['P value: ', num2str(stats(1).ProjAngle.pvalue)]))
       
       % hysteresis magnitude
       figure
       boxplot(boxPlt.magnitudeH, 'Labels', {'Supine', 'Upright'}, 'color', 'rk')
       title('Hysteresis magnitude')
       ylim([0 0.25]);
       box on
       disp(join(['P value: ', num2str(stats(1).magnitudeH.pvalue)]))
       
       set(0,'DefaultAxesFontName','Arial');
       set(0, 'DefaultAxesFontSize', 12);
       set(0, 'defaultAxesFontWeight', 'normal') 
       
          %% delta BRS vs delta Setpoint: boxplot
          
        figure
        set(gcf,'color','w');
            yyaxis right
            boxplot(boxPlt.deltaBRS,  'color', [0 0 0; 0.5 0.5 0.5], 'PlotStyle', 'Compact', ...
                'Positions', [1.9 2.1], 'Symbol', ' '); hold on;
            ylabel('\Delta BRS (ms/mmHg)')
            ylim([-25 25])
            box on
            yyaxis left
            boxplot(boxPlt.setpoint,  'color', [0 0 0; 0.5 0.5 0.5], 'PlotStyle', 'Compact', ...
                'Positions', [0.9 1.1], 'Symbol', ' '); hold on;
            ylabel('\Delta Setpoint (ms) ')
            %title('$\Delta$ setpoint ', 'Interpreter', 'latex')
            box on
            ylim([-200 200])
            xlim([0.5 2.5])
            ax = gca;
            set(ax,'xtick',[1 2],'xticklabel',{' ', ' '});
            ax.YAxis(1).Color = 'k';
            ax.YAxis(2).Color = 'k';
            legend({'Supine', 'Standing'})
            
            hLegend = findall(gca,'Tag','Box');
            legend(hLegend([2, 1]), {'Supine', 'Standing'});

end 

%% All boxplots together 
lines = max([ length( store(1).SlopeUp ), ...
length(store(2).SlopeUp), ...
length( store(1).ellipseSlopeUp ), ...
length(store(2).ellipseSlopeUp), ...
length(store(1).SlopeDn), ...
length(store(2).SlopeDn), ...
length(store(1).ellipseSlopeDn), ...
length(store(2).ellipseSlopeDn) ]);

updn_bxplt = NaN(lines, 8);
updn_bxplt( 1:length( store(1).SlopeUp ), 1 ) =  store(1).SlopeUp ;
updn_bxplt( 1:length(store(2).SlopeUp), 2 ) = store(2).SlopeUp;
updn_bxplt( 1:length( store(1).ellipseSlopeUp ), 3 ) = store(1).ellipseSlopeUp;
updn_bxplt( 1:length(store(2).ellipseSlopeUp), 4 ) = store(2).ellipseSlopeUp;
updn_bxplt( 1:length(store(1).SlopeDn), 5 ) = store(1).SlopeDn;
updn_bxplt( 1:length(store(2).SlopeDn), 6 ) = store(2).SlopeDn;
updn_bxplt( 1:length(store(1).ellipseSlopeDn), 7 ) = store(1).ellipseSlopeDn;
updn_bxplt( 1:length(store(2).ellipseSlopeDn), 8 ) = store(2).ellipseSlopeDn;

lines = max([ length( store(1).SlopeUpC ), ...
length(store(2).SlopeUpC), ...
length( store(1).ellipseSlopeUpC ), ...
length(store(2).ellipseSlopeUpC), ...
length(store(1).SlopeDnC), ...
length(store(2).SlopeDnC), ...
length(store(1).ellipseSlopeDnC), ...
length(store(2).ellipseSlopeDnC) ]);

updnC_bxplt = NaN(lines, 8);
updnC_bxplt( 1:length( store(1).SlopeUpC ), 1 ) = store(1).SlopeUpC;
updnC_bxplt( 1:length(store(2).SlopeUpC), 2 ) = store(2).SlopeUpC;
updnC_bxplt( 1:length( store(1).ellipseSlopeUpC ), 3 ) = store(1).ellipseSlopeUpC;
updnC_bxplt( 1:length(store(2).ellipseSlopeUpC), 4 ) = store(2).ellipseSlopeUpC;
updnC_bxplt( 1:length(store(1).SlopeDnC), 5 ) = store(1).SlopeDnC;
updnC_bxplt( 1:length(store(2).SlopeDnC), 6 ) = store(2).SlopeDnC;
updnC_bxplt( 1:length(store(1).ellipseSlopeDnC), 7 ) = store(1).ellipseSlopeDnC;
updnC_bxplt( 1:length(store(2).ellipseSlopeDnC), 8 ) = store(2).ellipseSlopeDnC;

lines = max([ length(rmoutliers(store(1).SlopeAll)), ...
length(store(2).SlopeAll), ...
length(rmoutliers(store(1).ellipseSlopeAll)), ...
length(store(2).ellipseSlopeAll), ...
length(rmoutliers(store(1).EllipseSlope)), ...
length(rmoutliers(store(2).EllipseSlope)) ]);

suptilt_bxplt = NaN(lines, 6);
 suptilt_bxplt( 1:length(store(1).SlopeAll), 1 ) = store(1).SlopeAll;
 suptilt_bxplt( 1:length(store(2).SlopeAll), 2 ) = store(2).SlopeAll;
 suptilt_bxplt( 1:length( store(1).ellipseSlopeAll ), 3 ) = store(1).ellipseSlopeAll;
 suptilt_bxplt( 1:length(store(2).ellipseSlopeAll), 4 ) = store(2).ellipseSlopeAll;
 suptilt_bxplt( 1:length( store(1).EllipseSlope ), 5 ) = store(1).EllipseSlope;
 suptilt_bxplt( 1:length( store(2).EllipseSlope ), 6 ) = store(2).EllipseSlope;

lines = max([ length( [store(1).SlopeUpC; store(1).SlopeDnC] ), ...
length( [store(1).ellipseSlopeUpC; store(1).ellipseSlopeDnC] ), ...
length( [store(2).SlopeUpC; store(2).SlopeDnC] ), ...
length( [store(2).ellipseSlopeUpC; store(2).ellipseSlopeDnC] ) ]);

suptiltC_bxplt = NaN(lines, 4);
suptiltC_bxplt( 1:length( [store(1).SlopeUpC; store(1).SlopeDnC] ), 1 ) = [store(1).SlopeUpC; store(1).SlopeDnC];
suptiltC_bxplt( 1:length( [store(1).ellipseSlopeUpC; store(1).ellipseSlopeDnC] ), 3 ) = [store(1).ellipseSlopeUpC; store(1).ellipseSlopeDnC];
suptiltC_bxplt( 1:length(store(2).SlopeUpC) + length(store(2).SlopeDnC), 2 ) = [store(2).SlopeUpC; store(2).SlopeDnC];
suptiltC_bxplt( 1:length(store(2).ellipseSlopeUpC) + length(store(2).ellipseSlopeDnC), 4 ) = [store(2).ellipseSlopeUpC; store(2).ellipseSlopeDnC];

bxplt_colors = [0.6953 0.1328 0.1328; 0 0 0; 0.6953 0.1328 0.1328; 0 0 0; 0.6953 0.1328 0.1328; 0 0 0; 0.6953 0.1328 0.1328; 0 0 0];
bxplt_colors2 = [0.6953 0.1328 0.1328; 0 0 0; 0.6953 0.1328 0.1328; 0 0 0; 0.6953 0.1328 0.1328; 0 0 0];
bxplt_colors3 = [0.6953 0.1328 0.1328; 0 0 0; 0.6953 0.1328 0.1328; 0 0 0];

set(gcf, 'color', 'w')
ax2 = subplot(2, 2, 1);
boxplot(updn_bxplt, 'PlotStyle', 'compact', 'Colors', bxplt_colors, 'Symbol', ' ', 'Whisker', 0.2, ...
    'Positions', [0.9 1.1 1.9 2.1 3.9 4.1 4.9 5.1])
set(gca,'xtick',[1 2 3 4 5],'xticklabel',{'Ra', 'Ea', ' ', 'Ra', 'Ea'})
ylim([0 30])
yticks([0 5 10 15 20 25 30])
xline(3)
xlim([0.5 5.5])
title('Up vs Down')
hLegend = findall(gca,'Tag','Box');
legend(findall(ax2,'Tag','Box'), {'Standing','Supine'});
box on 
grid on

subplot(2, 2, 3)
boxplot(updnC_bxplt, 'PlotStyle', 'compact', 'Colors', bxplt_colors, 'Symbol', ' ', 'Whisker', 0.2, ...
    'Positions', [0.9 1.1 1.9 2.1 3.9 4.1 4.9 5.1])
set(gca,'xtick',[1 2 3 4 5],'xticklabel',{'Rc', 'Ec', ' ', 'Rc', 'Ec'});
ylim([0 30])
yticks([0 5 10 15 20 25 30])
xlim([0.5 5.5])
title('Up vs Dn')
xline(3)
box on 
grid on

subplot(2, 2, 2)
boxplot(suptilt_bxplt, 'PlotStyle', 'compact', 'Colors', bxplt_colors2, 'Symbol', ' ', 'Whisker', 0.2, ...
    'Positions', [0.9 1.1 1.9 2.1 2.9 3.1])
set(gca,'xtick',[1 2 3],'xticklabel',{'Ra', 'Ea', 'Ee'});
ylim([0 30])
yticks([0 5 10 15 20 25 30])
xlim([0.4 3.5])
title('Supine vs tilt')
box on 
grid on

subplot(2, 2, 4)
boxplot(suptiltC_bxplt, 'PlotStyle', 'compact', 'Colors', bxplt_colors3, 'Symbol', ' ', 'Whisker', 0.2, ...
    'Positions', [0.9 1.1 1.9 2.1])
set(gca,'xtick',[1 2],'xticklabel',{'Rc', 'Ec'});
ylim([0 30])
yticks([0 5 10 15 20 25 30])
xlim([0.5 2.4])
title('Supine vs tilt')
box on 
grid on


%% Trajectories of centre of mass 
debug = 1;

[res] = trajectoriesCM (res, debug);


%% Bar plots for lag (beat to beat slope)
debug = 1;
lag_analysis(debug, store, res(1).ID)

%% ellipse summary plot
debug = 1; % 0 for no plot, 1 for plot


ellipseSum = ellipseSummary(store, debug, []);


%% Dual axes analysis
theta_grid = linspace(-pi,pi);


figure   
set(gcf,'color','w');
    subplot(2, 1, 1)
    
    
    res(1).DAFSA_Q2 = DAFSA_ellipse_method(ellipseSum(1).outEllipse, ellipseSum(1).cntrd.median, 'supine', [0, 0, 0, 0.8], [0, 0.4470, 0.7410 0.8],'-', 0.5, 0);

    res(1).DAFSA_Q1 = DAFSA_ellipse_method(ellipseSum(1).inEllipse, ellipseSum(1).cntrd.median, 'supine', [0, 0, 0, 0.8], [0, 0.4470, 0.7410 0.8], '-', 0.5, 0);
    
   % res(1).DAFSA_mean = DAFSA_ellipse_method(ellipseSum(1).mEllipse, ellipseSum(1).cntrd.median, 'supine', [0, 0, 0, 0.8], [0, 0.4470, 0.7410 0.8], '-', 0.5, 0);
    
   % res(1).DAFSA_std = DAFSA_ellipse_method(ellipseSum(1).stdEllipse, ellipseSum(1).cntrd.median, 'supine', [0, 0, 0, 0.8], [0, 0.4470, 0.7410 0.8], '-', 0.5, 0);

     inBetween = [ellipseSum(1).inEllipse.Ellipse(2, :) + ellipseSum(1).cntrd.median(2), fliplr( ellipseSum(1).outEllipse.Ellipse(2, :)+ ellipseSum(1).cntrd.median(2) )];
    x2 = [rad2deg(theta_grid), fliplr(rad2deg(theta_grid))];
    fill(x2, -inBetween+778*2, [0, 0, 0], 'Facealpha',.2,'LineStyle','none');
    
    yyaxis right
    inBetween = [ellipseSum(1).inEllipse.Ellipse(1, :) + ellipseSum(1).cntrd.median(1), fliplr( ellipseSum(1).outEllipse.Ellipse(1, :) + ellipseSum(1).cntrd.median(1) )];
    fill(x2, -inBetween+108.1*2, [0, 0.4470, 0.7410], 'Facealpha',.2,'LineStyle','none');
    %ylim([-118 126])
    
    legend({'RR interval', 'Systolic BP'}, 'Box', 'off')
    
        res(1).DAFSA_median = DAFSA_ellipse_method(ellipseSum(1).midEllipse, ellipseSum(1).cntrd.median, 'supine', [0, 0, 0, 0.8], [0, 0.4470, 0.7410 0.8], '-', 1.5, 1);
   

    % standing 
    
    
   
    subplot(2, 1, 2)
    
    res(2).DAFSA_Q2 = DAFSA_ellipse_method(ellipseSum(2).outEllipse, ellipseSum(2).cntrd.median, 'standing',[0, 0, 0, 0.8], [0 0.4470 0.7410 0.8], '-', 0.5, 0);
    
    res(2).DAFSA_Q1 = DAFSA_ellipse_method(ellipseSum(2).inEllipse, ellipseSum(2).cntrd.median, 'standing',  [0, 0, 0, 0.8], [0, 0.4470, 0.7410, 0.8],  '-', 0.5, 0);
    
   % res(2).DAFSA_mean = DAFSA_ellipse_method(ellipseSum(2).mEllipse, ellipseSum(2).cntrd.median, 'standing',  [0, 0, 0, 0.8], [0, 0.4470, 0.7410, 0.8],  '-', 0.5, 0);
    
   % res(2).DAFSA_std = DAFSA_ellipse_method(ellipseSum(2).stdEllipse, ellipseSum(2).cntrd.median, 'standing',  [0, 0, 0, 0.8], [0, 0.4470, 0.7410, 0.8],  '-', 0.5, 0);
    
    
    inBetween = [ellipseSum(2).inEllipse.Ellipse(2, :) + ellipseSum(2).cntrd.median(2), fliplr( ellipseSum(2).outEllipse.Ellipse(2, :)+ ellipseSum(2).cntrd.median(2) )];
    x2 = [rad2deg(theta_grid), fliplr(rad2deg(theta_grid))];
    fill(x2, -inBetween + 624*2,  [0, 0, 0], 'Facealpha',.2,'LineStyle','none');
    
    yyaxis right
    inBetween = [ellipseSum(2).inEllipse.Ellipse(1, :) + ellipseSum(2).cntrd.median(1), fliplr( ellipseSum(2).outEllipse.Ellipse(1, :) + ellipseSum(2).cntrd.median(1) )];
    h = fill(x2, -inBetween+106.35*2, [0, 0.4470, 0.7410], 'Facealpha',.2,'LineStyle','none');
    %ylim([100 115])
    legend({'RR interval', 'Systolic BP'}, 'Box', 'off')
    
    % median signal
    res(2).DAFSA_median = DAFSA_ellipse_method(ellipseSum(2).midEllipse, ellipseSum(2).cntrd.median, 'standing', [0, 0, 0, 0.8], [0, 0.4470, 0.7410, 0.8],  '-', 1.5, 1);

   
    set(0,'DefaultAxesFontName','Arial');
    set(0, 'DefaultAxesFontSize', 12);
    set(0, 'defaultAxesFontWeight', 'normal')
        
%% H magnitude and ellipse area distribution   


% % FIRST RUN THIS CODE LINE BY LINE ONLY THEN able to plot

% [elHist] = ellipseHist (store);

% myxdata = elHist(1).area.Xdata;
% myydata = elHist(1).area.Ydata;
% % % % use curve fitting tool
%  elHist(1).fit = sup_area;
%  elHist(1).normY_area = feval(elHist(1).fit, linspace(50, 675) );

% myxdata = elHist(2).area.Xdata;
% myydata = elHist(2).area.Ydata;
% % % use curve fitting tool
% elHist(2).fit = tilt_area;
% elHist(2).normY_area = feval(elHist(2).fit, linspace(50, 675) );

% myxdata = elHist(1).H.Xdata;
% myydata = elHist(1).H.Ydata;
% % % % use curve fitting tool
%  elHist(1).fit_H = sup_H;
%  elHist(1).normY_H= feval(elHist(1).fit_H, linspace(0, 0.2) );

%  myxdata = elHist(2).H.Xdata;
%  myydata = elHist(2).H.Ydata;
% % % % use curve fitting tool
%  elHist(2).fit_H = tilt_H;
%  elHist(2).normY_H = feval(elHist(2).fit_H, linspace(0, 0.2) );
%     

 figure
    subplot(2, 1, 1)
    plt1 = plot(linspace(50, 675), elHist(1).normY_area ./ sum(elHist(1).normY_area) ); hold on;
    plt1.Color =  'r';
    plt1.LineWidth = 1 ;
    plt2 = plot(linspace(50, 675), elHist(2).normY_area ./ sum(elHist(2).normY_area) ); hold on;
    plt2.Color =  'k';
    plt2.LineWidth = 1 ;
    plt2.LineStyle = '--';
    legend([plt1, plt2], {'Supine', 'Standing'})
    ylabel(' p (1) ')
    xlabel('Ellipse area (ms*mmHg) ')
    xlim([50 675])
    %ylim([0 0.05])
    box on;
    
    subplot(2, 1, 2)
    plt1 = plot(linspace(0, 0.2), elHist(1).normY_H ./ sum(elHist(1).normY_H) ); hold on;
    plt1.Color =  'r';
    plt1.LineWidth = 1 ;
    plt2 = plot(linspace(0, 0.2), elHist(2).normY_H ./ sum(elHist(2).normY_H) ); hold on;
    plt2.Color =  'k';
    plt2.LineWidth = 1 ;
    plt2.LineStyle = '--';
    legend([plt1, plt2], {'Supine', 'Standing'})
    ylabel('p (1) ')
    xlabel('Hysteresis magnitude ')
    xlim([0 0.2])
    %ylim([0 0.05])
    box on;
    
    
    
%% Radar / spider plot

for iPosition = 1:2
    radarData(iPosition, 1) = stats(iPosition).ellipseArea.median;
    radarData(iPosition, 2) = stats(iPosition).EllipseSlope.median;
    radarData(iPosition, 3) = ellipseSum(iPosition).cntrd.median(1);
    radarData(iPosition, 4) = ellipseSum(iPosition).cntrd.median(2);
    radarData(iPosition, 5) = stats(iPosition).Dp.median;
    radarData(iPosition, 6) = stats(iPosition).magnitudeH.median;
    radarData(iPosition+2, 1) = stats(iPosition).ellipseArea.Q1;
    radarData(iPosition+2, 2) = stats(iPosition).EllipseSlope.Q1;
    radarData(iPosition+2, 3) = ellipseSum(iPosition).cntrd.Q1(1);
    radarData(iPosition+2, 4) = ellipseSum(iPosition).cntrd.Q1(2);
    radarData(iPosition+2, 5) = stats(iPosition).Dp.Q1;
    radarData(iPosition+2, 6) = stats(iPosition).magnitudeH.Q1;
    radarData(iPosition+4, 1) = stats(iPosition).ellipseArea.Q2;
    radarData(iPosition+4, 2) = stats(iPosition).EllipseSlope.Q2;
    radarData(iPosition+4, 3) = ellipseSum(iPosition).cntrd.Q2(1);
    radarData(iPosition+4, 4) = ellipseSum(iPosition).cntrd.Q2(2);
    radarData(iPosition+4, 5) = stats(iPosition).Dp.Q2;
    radarData(iPosition+4, 6) = stats(iPosition).magnitudeH.Q2;
end

featuredescriptor = {'Area (ms*mmHg)' 'Slope (ms/mmHg)', 'xc: Sp (mmHg)', 'yc: RR interval (ms)', 'Dp (mmHg)', 'Ratio of axes length'};
objectdescriptor = {'Supine', 'Upright'};
spider_plot(radarData, 'AxesLabels', featuredescriptor, 'Color', [1, 0, 0; 0, 0, 0; 1, 0, 0; 0, 0, 0; 1, 0, 0; 0, 0, 0], ...
    'LineWidth', [0.8, 0.8, 0.3, 0.3, 0.1, 0.1], 'LineStyle', {'none', 'none', 'none', 'none', 'none', 'none'}, ...
    'Marker', {'o', 'o', 'd', 'd', 's', 's'}, 'MarkerSize', [3, 3, 3, 3, 3, 3], 'FillTransparency', 0, ...
     'AxesLabelsEdge', 'none', 'LabelFontSize', 14, 'AxesDisplay', 'all')
legend('Median (Supine)', 'Median (Upright)', 'Q1 (Supine)', 'Q1 (Upright)', 'Q2 (Supine)', 'Q2 (Upright)', 'Location', 'southeast')
title('Comparing ellipse characteristics for EUROBAVAR data');

 
set(0,'DefaultAxesFontName','Arial');
set(0, 'DefaultAxesFontSize', 16);
set(0, 'defaultAxesFontWeight', 'normal')
set(gcf,'color','w');


%% bivariate histogram of distribution of Sp and RR for baroreflex cycles 
% debug = 1;
%  bivHist = distHist (store, debug);

%  myxdata = bivHist(1).myXData_Sp;
%  myydata = bivHist(1).myYData_Sp;
% % % use curve fitting tool
%  bivHist(1).fit_Sp = sup_sp_fit;
%  bivHist(1).normY_Sp = feval(sup_sp_fit, linspace(80, 170) );

%  myxdata = bivHist(1).myXData_RR;
%  myydata = bivHist(1).myYData_RR;
% % % % use curve fitting tool
%   bivHist(1).fit_RR = sup_RR_fit;
%  bivHist(1).normY_RR = feval(sup_RR_fit, linspace(550, 1200) );

%   myxdata = bivHist(2).myXData_RR;
%   myydata = bivHist(2).myYData_RR;
% % % % use curve fitting tool
%    bivHist(2).fit_RR = tilt_RR_fit;
%  bivHist(2).normY_RR = feval(tilt_RR_fit, linspace(550, 1200) );

%   myxdata = bivHist(2).myXData_Sp;
%   myydata = bivHist(2).myYData_Sp;
% % use curve fitting tool
%     bivHist(2).fit_Sp = tilt_Sp_fit;
%   bivHist(2).normY_Sp = feval(tilt_Sp_fit, linspace(80, 170) );

    figure
    subplot(2, 1, 1)
    %scatter(bivHist(1).myXData_Sp, bivHist(1).myYData_Sp ./ sum(bivHist(1).normY_Sp) , 20, 'k', 'o'); hold on;
    plt1 = plot(linspace(80, 170), bivHist(1).normY_Sp ./ sum(bivHist(1).normY_Sp) ); hold on;
    plt1.Color =  'r';
    plt1.LineWidth = 1 ;
    %scatter(bivHist(2).myXData_Sp, bivHist(2).myYData_Sp ./ sum(bivHist(2).normY_Sp), 20, 'k', 'o'); hold on;
    plt2 = plot(linspace(80, 170), bivHist(2).normY_Sp ./ sum(bivHist(2).normY_Sp) ); hold on;
    plt2.Color =  'k';
    plt2.LineWidth = 1 ;
    plt2.LineStyle = '--';
    legend([plt1, plt2], {'Supine', 'Standing'})
    ylabel('P (1) ')
    xlabel('Systolic BP (mmHg) ')
    xlim([90 140])
    ylim([0 0.05])
    box on;
    
    subplot(2, 1, 2)
    %scatter(bivHist(1).myXData_RR, bivHist(1).myYData_RR ./ sum(bivHist(1).normY_RR), 20, 'k', 'o'); hold on;
    plt1 = plot(linspace(550, 1200), bivHist(1).normY_RR ./ sum(bivHist(1).normY_RR) ); hold on;
    plt1.Color =  'r';
    plt1.LineWidth = 1 ;
    %scatter(bivHist(2).myXData_RR, bivHist(2).myYData_RR ./ sum(bivHist(2).normY_RR), 20, 'k', 'o'); hold on;
    plt2 = plot(linspace(550, 1200), bivHist(2).normY_RR ./ sum(bivHist(2).normY_RR)); hold on;
    plt2.Color =  'k';
    plt2.LineWidth = 1 ;
    plt2.LineStyle = '--';
    legend([plt1, plt2], {'Supine', 'Standing'})
    ylabel('P (1) ')
    xlabel('RR interval (ms) ')
    xlim([550 850])
    ylim([0 0.05])
    box on;

   %% Coefficient of viscoelasticity


for iPosition = 1:2
    [gHist(iPosition).YData, ~] = histcounts([store(iPosition).UpG; store(iPosition).DnG], 'BinEdges', 0:0.2:2);
               gHist(iPosition).XData  = 0.1:0.2:1.9;
               
               gHist(iPosition).YNorm = spline(gHist(iPosition).XData, gHist(iPosition).YData,linspace(0,2));
end          


figure
plot(linspace(0, 2), gHist(1).YNorm ./ sum(gHist(1).YNorm), 'r', 'LineWidth', 1.0); hold on;
plot(linspace(0, 2), gHist(2).YNorm ./ sum(gHist(2).YNorm), 'k--', 'LineWidth', 1.0); hold on;
yl = ylim;
line([1 1], ylim, 'Color', [0.4 0.4 0.4]); hold on;
xlabel('Coefficient of viscoelasticity');
ylabel('p (1)')
legend('Supine', 'Standing')

    
set(0,'DefaultAxesFontName','Arial');
set(0, 'DefaultAxesFontSize', 16);
set(0, 'defaultAxesFontWeight', 'normal')
set(gcf,'color','w');
