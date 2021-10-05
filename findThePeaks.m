function res = findThePeaks(res)

%  Detection of R peaks (ECG) and systolic and diastolic BP peaks

    for iPosition =1:2
        for iSubject=1:21
            % sampling from signal to define MinPeakProminence (MPP)
            [RpTemp, ~] = findpeaks(res(iPosition).AB(iSubject).ecg(1:20*res(iPosition).fs), 'MinPeakDistance',200);
            MPP = 0.6* mean(RpTemp);
            % R_peak detection (Rp)
            [res(iPosition).AB(iSubject).Rp, res(iPosition).AB(iSubject).RpLoc] = findpeaks(res(iPosition).AB(iSubject).ecg,'MinPeakDistance',200,'MinPeakProminence', MPP, ...
                'Annotate','extents');
            % Systolic pressure (Sp) peaks detection
            
            [res(iPosition).AB(iSubject).Sp, res(iPosition).AB(iSubject).SpLoc] = findpeaks(res(iPosition).AB(iSubject).bp,'MinPeakProminence',10,'MinPeakDistance',200, ...
                'Annotate', 'extents');
            %find the disastolic pressure (Dp) peaks detection
            [res(iPosition).AB(iSubject).Dp, res(iPosition).AB(iSubject).DpLoc] = findpeaks(- res(iPosition).AB(iSubject).bp,'MinPeakProminence',10,'MinPeakDistance',200, ...
                'Annotate', 'extents');
                        
            % bp correction for detected Sp before the first Rp in ECG
            while(res(iPosition).AB(iSubject).SpLoc(1) < res(iPosition).AB(iSubject).RpLoc(1))
                res(iPosition).AB(iSubject).Sp(1)= [];
                res(iPosition).AB(iSubject).SpLoc(1) = [];
            end
            % remove extra Sp from end
            while (res(iPosition).AB(iSubject).RpLoc(end) < res(iPosition).AB(iSubject).SpLoc(end))
                res(iPosition).AB(iSubject).SpLoc(end) = [];
                res(iPosition).AB(iSubject).Sp(end)= [];
            end
            
            %RR_intervals (rrInt) calculation
            res(iPosition).AB(iSubject).rrInt =  res(iPosition).AB(iSubject).RpLoc(2:end) - res(iPosition).AB(iSubject).RpLoc(1:end-1) ;
            res(iPosition).AB(iSubject).rrInt = res(iPosition).AB(iSubject).rrInt .* 2;       
            
            % blood pressure deflection (Pm) calculation
            sizeT = min(length(res(iPosition).AB(iSubject).Sp) , length(res(iPosition).AB(iSubject).Dp));
            res(iPosition).AB(iSubject).Pm = (res(iPosition).AB(iSubject).Sp(1:sizeT) + 2* res(iPosition).AB(iSubject).Dp(1:sizeT))/3;
        end 
    end
    
end 
   