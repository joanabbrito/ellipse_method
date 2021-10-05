function [] = plotTheSeq(res, iSubject)

    figure
    for iPosition=1
        position = res(iPosition).position;

        ax(1) = subplot(2,1,1);
        %plot ecg signal
        plt1 = plot((1:length(res(iPosition).AB(iSubject).ecg))./res(iPosition).fs, res(iPosition).AB(iSubject).ecg,'b'); hold on ; 
        % plot up sequencing peaks and regions (intervals) of ECG
        for iSequence = 1: length(res(iPosition).BRS(iSubject).UpSeq)
            %plotting R peaks of sequence
            plt2 = plot(res(iPosition).BRS(iSubject).UpSeq(iSequence).RpLoc./1000, res(iPosition).BRS(iSubject).UpSeq(iSequence).Rp,'b*'); 
            plot((res(iPosition).BRS(iSubject).UpSeq(iSequence).RpLoc./1000), res(iPosition).BRS(iSubject).UpSeq(iSequence).Rp,'bo'); 
%             x1 = res(iPosition).BRS(iSubject).UpSeq(iSequence).int(1)/1000 - .1;
%             x2 = res(iPosition).BRS(iSubject).UpSeq(iSequence).int(2)/1000;
%             y1 = min(res(iPosition).AB(iSubject).ecg) - min(res(iPosition).AB(iSubject).ecg)*0.01;
%             y2 = max(res(iPosition).AB(iSubject).ecg) + max(res(iPosition).AB(iSubject).ecg)*0.01;
            %plot up sequences of rr intervals
            %plt(iPosition).myecg(3) = fill([x1 x1 x2 x2],[y1 y2 y2 y1],'g');
%             xlim([0 res(iPosition).BRS(iSubject).UpSeq(iSequence).RpLoc(end)/1000])
%             ylim([y1 y2])
            %set(plt(iPosition).myecg(3),'facealpha',.2)   
        end

        % plot down sequencing peaks and regions (intervals) of ecg
        for iSequence = 1: length(res(iPosition).BRS(iSubject).DnSeq)
            %plotting R peaks of sequence
            plt3 = plot( res(iPosition).BRS(iSubject).DnSeq(iSequence).RpLoc./1000 , res(iPosition).BRS(iSubject).DnSeq(iSequence).Rp,'k*');% devide to 1000 for second presentation
            plot((res(iPosition).BRS(iSubject).DnSeq(iSequence).RpLoc)./1000, res(iPosition).BRS(iSubject).DnSeq(iSequence).Rp,'ko')
%             x1 = res(iPosition).BRS(iSubject).DnSeq(iSequence).int(1)/1000 - .1;
%             x2 = res(iPosition).BRS(iSubject).DnSeq(iSequence).int(2)/1000;
%             y1 = min(res(iPosition).AB(iSubject).ecg) - min(res(iPosition).AB(iSubject).ecg)*0.01;
%             y2 = max(res(iPosition).AB(iSubject).ecg) + max(res(iPosition).AB(iSubject).ecg)*0.01;
            %plot up sequences of rr intervals
            %plt(iPosition).myecg(5)= fill([x1 x1 x2 x2],[y1 y2 y2 y1],'y');
%             xlim([0 res(iPosition).BRS(iSubject).DnSeq(iSequence).RpLoc(end)/1000])
%             ylim([y1 y2])
            %set(plt(iPosition).myecg(5),'facealpha',.2)   
        end
        ylabel("(mV)");
        xlabel("time (s)");
        title(join(['ECG signal for ' position ' position with marked BRS region for subject ' res(iPosition).ID(iSubject) ]));

       

        ax(2) = subplot(2,1,2);
        %plot bp signal
        plt4 = plot((1:length(res(iPosition).AB(iSubject).bp))./res(iPosition).fs, res(iPosition).AB(iSubject).bp,'k'); hold on
        
         % plot up sequencing peaks of bp
        for iSequence = 1: length(res(iPosition).BRS(iSubject).UpSeq)
            %plotting sp peaks of sequence
            plt5 = plot(res(iPosition).BRS(iSubject).UpSeq(iSequence).SpLoc./1000 , res(iPosition).BRS(iSubject).UpSeq(iSequence).Sp, 'b*'); hold on; % devide to 1000 for second presentation
            plot(res(iPosition).BRS(iSubject).UpSeq(iSequence).SpLoc./1000 , res(iPosition).BRS(iSubject).UpSeq(iSequence).Sp,'bo'); hold on;
%             x1 = res(iPosition).BRS(iSubject).UpSeq(iSequence).int(1)/1000;
%             x2 = max (res(iPosition).BRS(iSubject).UpSeq(iSequence).SpLoc)/1000;
%             y1 = min(res(iPosition).AB(iSubject).bp) - min(res(iPosition).AB(iSubject).bp)*0.01;
%             y2 = max(res(iPosition).AB(iSubject).bp) + max(res(iPosition).AB(iSubject).bp)*0.01;
            %plt(iPosition).mybp(3) = fill([x1 x1 x2 x2],[y1 y2 y2 y1],'g');
%             xlim([0 res(iPosition).BRS(iSubject).UpSeq(iSequence).RpLoc(end)/1000])
%             ylim([y1 y2])
            %set(plt(iPosition).mybp(3),'facealpha',.2)
        end
        
        % Down-sequencing peaks and regions presentation BP
        for iSequence = 1: length(res(iPosition).BRS(iSubject).DnSeq)
            %plotting sp peaks of sequence 
            plt6 = plot(res(iPosition).BRS(iSubject).DnSeq(iSequence).SpLoc./1000 , res(iPosition).BRS(iSubject).DnSeq(iSequence).Sp,'k*'); hold on; % devide to 1000 for second presentation
            plot(res(iPosition).BRS(iSubject).DnSeq(iSequence).SpLoc./1000 , res(iPosition).BRS(iSubject).DnSeq(iSequence).Sp,'ko'); hold on;
%             x1 = res(iPosition).BRS(iSubject).DnSeq(iSequence).int(1)/1000;
%             x2 = res(iPosition).BRS(iSubject).DnSeq(iSequence).SpLoc(end)/1000;
%             y1 = min(res(iPosition).AB(iSubject).bp) - min(res(iPosition).AB(iSubject).bp)*0.01;
%             y2 = max(res(iPosition).AB(iSubject).bp) + max(res(iPosition).AB(iSubject).bp)*0.01;
            %plotting ascending sequence
            %plt(iPosition).mybp(5) = fill([x1 x1 x2 x2],[y1 y2 y2 y1],'y');
%             xlim([0 res(iPosition).BRS(iSubject).DnSeq(iSequence).RpLoc(end)/1000])
%             ylim([y1 y2])
            %set(plt(iPosition).mybp(5),'facealpha',.2)
        end
        ylabel("(mm Hg)");
        xlabel("time(s)");
        title(join(['Blood pressure signal for ' position ' position with marked BRS region for subject ' res(iPosition).ID(iSubject) ]));
        linkaxes(ax, 'x');
        set(gcf,'position',[200,200,1500,800])
    end
    
    legend([plt1, plt2,  plt3], ...
           'ECG','Up-sequencing','Down-sequencing');
    legend([plt4, plt5, plt6], ...
            'Blood pressure', 'Up-sequencing', 'Down-sequencing');
        
        
end