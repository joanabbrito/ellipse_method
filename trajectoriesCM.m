function [res] = trajectoriesCM (res, debug)
k = 1;
    for iSubject = 1:21
        for iPosition = 1:2     
            res(iPosition).BRS(iSubject).Trajectory = [];
            for iCycle = 1:length(res(iPosition).BRS(iSubject).BrsCycle)     
                res(iPosition).BRS(iSubject).Trajectory = [res(iPosition).BRS(iSubject).Trajectory; res(iPosition).BRS(iSubject).BrsCycle(iCycle).ellipse.Cntrd];
            end
            
        end
        
    
    if size(res(1).BRS(iSubject).Trajectory, 1) > 10 && size(res(2).BRS(iSubject).Trajectory, 1) > 10 && debug == 1
                subplot(4, 2, k)
                k = k+1;
                plot(res(1).BRS(iSubject).Trajectory(:, 1), res(1).BRS(iSubject).Trajectory(:, 2), 'r'); hold on;
                plot(res(2).BRS(iSubject).Trajectory(:, 1), res(2).BRS(iSubject).Trajectory(:, 2), 'k'); hold on;
                ylabel('RR interval [ms]', 'FontSize', 12)
                xlabel('Systolic BP [mmHg]', 'FontSize', 12)
                xlim([75 175])
                ylim([500 1150])
                title(res(iPosition).ID(iSubject));
                legend({'Supine', 'Upright'}, 'box', 'off', 'FontSize', 10)
                grid on
    end 
    
    end
    
    if debug == 1
        sgtitle('Trajectory of centre of mass of BRS cycle', 'FontSize', 14)
    end




end