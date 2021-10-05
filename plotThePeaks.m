function [] = plotThePeaks(res, iSubject)

    for iPosition =1:2
        %time vector
        plt(iPosition).t = (1:length(res(iPosition).AB(iSubject).ecg))/500;
        ax(1) = subplot(2,2,iPosition);
        %plot ecg 
        plot(plt(iPosition).t, res(iPosition).AB(iSubject).ecg); hold on;
        plot(res(iPosition).AB(iSubject).RpLoc/res(iPosition).fs, res(iPosition).AB(iSubject).Rp,'v', ...
            'MarkerSize', 5, 'MarkerFaceColor',  [0 0.4470 0.7410], 'MarkerEdgeColor', [0 0.4470 0.7410]);
        xlabel("time(s)");
        ylabel('(mV)');
        legend("ECG", 'R peaks');
        title(['ECG signal for ' res(iPosition).position ' position, subject: ' num2str(res(iPosition).ID(iSubject))]);
        
        ax(2) = subplot(2,2,iPosition+2);
        %plot blood pressure + systolic and diastolic peaks
        plot(plt(iPosition).t, res(iPosition).AB(iSubject).bp,'k', res(iPosition).AB(iSubject).SpLoc/res(iPosition).fs, res(iPosition).AB(iSubject).Sp,...,
            'r*',res(iPosition).AB(iSubject).DpLoc/res(iPosition).fs, -res(iPosition).AB(iSubject).Dp ,'g*');
        xlabel("time (s)");
        ylabel("(mm Hg)");
        legend("BP", 'Systolic peaks', 'Diastolic peaks');
        title(['Blood pressure signal for ' res(iPosition).position ' position, subject: ' num2str(res(iPosition).ID(iSubject))]);
        linkaxes(ax, 'x');
        set(gcf,'position',[200,200,1500,600])
    end


end 