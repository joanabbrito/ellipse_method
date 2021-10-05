function [store] = storing(res, subjects)


    for iPosition = 1:2
        
        switch iPosition
            case 1
                mymed = 115.4;
            case 2
                mymed = 108.6;
        end
        % peaks info

        store(iPosition).sum = 0;
        store(iPosition).negative = 0;
        store(iPosition).positive = 0;
        store(iPosition).rrInt = []; % RRI
        store(iPosition).rrIntC = []; % RRI within cycle
        store(iPosition).Sp = [];  % SBP
        store(iPosition).SpC = []; % SBP within cycle
        store(iPosition).Dp = []; % DBP
        % sequence info
        store(iPosition).nUp = zeros(21,1);
        store(iPosition).nDn = zeros(21,1);
        store(iPosition).errorUp = []; % Error of estimate, up seq
        store(iPosition).errorDn = []; % Error of estimate, dn seq
        store(iPosition).errorSumUp = []; % Summed error of estimate, up seq
        store(iPosition).errorSumDn = []; % Summed error of estimate, dn seq
        store(iPosition).errorUp_wo = []; % Error of estimate, up seq, wo beat 1
        store(iPosition).errorDn_wo = []; % Error of estimate, dn seq, wo beat 1
        store(iPosition).SlopeUp = []; % BRS, up seq, lag 0
        store(iPosition).SlopeDn = []; % BRS, dn seq, lag 0
        store(iPosition).SlopeUp_wo = []; % BRS, up seq, wo beat 1, lag 0
        store(iPosition).SlopeDn_wo = []; % BRS, dn seq, wo beat 1, lag 0
        store(iPosition).SlopeAll = []; % BRS, all seq, lag 0
        store(iPosition).ellipseSlopeUp = []; % BRS, up seq, ellipse
        store(iPosition).ellipseSlopeDn = []; % BRS, dn seq, ellipse
        store(iPosition).ellipseSlopeAll = []; % BRS, all seq, ellipse
        
        % cycle info
        store(iPosition).ellipseSlopeAllC = []; % BRS, all seq, ellipse
        store(iPosition).errorUpC = []; % Error of estimate, up seq within cycle
        store(iPosition).errorDnC = [];  % Error of estimate, dn seq within cycle
        store(iPosition).errorSumUpC = [];  % Summed error of estimate, up seq within cycle
        store(iPosition).errorSumDnC = [];  % Summed error of estimate, up seq within cycle
        store(iPosition).SlopeAllC = [];  % BRS, up seq within cycle, lag 0
        store(iPosition).SlopeUpC = [];  % BRS, up seq within cycle, lag 0
        store(iPosition).SlopeDnC = []; % BRS, dn seq within cycle, lag 0
        store(iPosition).RegSlope = []; % BRS, reg, cycle, lag 0
        store(iPosition).EllipseSlope = []; % BRS, ellipse, cycle, lag 0
        store(iPosition).RegL = []; % Major axis, reg, cycle, lag 0
        store(iPosition).Regl = []; % Minor axis, reg, cycle, lag 0
        store(iPosition).EllipseL = []; % Major axis, ellipse, cycle, lag 0
        store(iPosition).EllipseL_e = []; % Major axis correct, ellipse, cycle, lag 0
        store(iPosition).Ellipsel = []; % Minor axis, ellipse, cycle, lag 0
        store(iPosition).nCycles = zeros(21, 1); % # cycles, lag 0
        store(iPosition).ellipseArea = []; % Area, ellipse, cycle, lag 0
        store(iPosition).area = []; % Area, polygon, cycle, lag 0
        store(iPosition).ProjAngle = []; % Projection angle into circle of ellipse, cycle, lag 0
        store(iPosition).magnitudeH = []; % Hysteresis magnitude, ellipse, cycle, lag 0
        store(iPosition).Centroids = []; % position of center of mass
        store(iPosition).deltaBRS = []; % difference in BRS from up seq to dn seq, ellipse method
        store(iPosition).setpoint = []; % difference in setpoint from up seq to dn seq, ellipse method
        store(iPosition).dist_ps = [];
        store(iPosition).dist_setpoint = [];
        
        % frequency domain
        store(iPosition).psd_alphaLF = []; % alphaLF
        store(iPosition).psd_alphaHF = []; %alphaHF
        store(iPosition).psd_LF = []; %LF, HRV spectrum
        store(iPosition).psd_HF = []; %HF, HRV spectrum
        store(iPosition).psd_csLF = []; %LF, cross spectrum
        store(iPosition).psd_csHF = []; %HF, cross spectrum
        store(iPosition).psd_nLF = []; %normalized LF, HRV spectrum
        store(iPosition).psd_nHF = []; %normalized HF, HRV spectrum
        store(iPosition).psd_fdRatio = []; %ratio of normalized LF/HF, HRV spectrum
        store(iPosition).psd_power = []; %power over all range of freq, HRV spectrum
        store(iPosition).coherence = [];
        
        store(iPosition).fft_alphaLF = []; % alphaLF
        store(iPosition).fft_alphaHF = []; %alphaHF
        store(iPosition).fft_LF = []; %LF, HRV spectrum
        store(iPosition).fft_HF = []; %HF, HRV spectrum
        store(iPosition).fft_csLF = []; %LF, cross spectrum
        store(iPosition).fft_csHF = []; %HF, cross spectrum
        store(iPosition).fft_nLF = []; %normalized LF, HRV spectrum
        store(iPosition).fft_nHF = []; %normalized HF, HRV spectrum
        store(iPosition).fft_fdRatio = []; %ratio of normalized LF/HF, HRV spectrum
        store(iPosition).fft_power = []; %power over all range of freq, HRV spectrum
        % lag analysis
        store(iPosition).nLag = zeros(21, 3); % # sequences of each lag for each subject
        store(iPosition).lag2 = []; % BRS, all seq, lag 2
        store(iPosition).lag1 = []; % BRS, all seq, lag 1
        store(iPosition).ellipseSlope_lag1 = []; % BRS, all seq, lag 1
        % beat analysis
        store(iPosition).allBeats = zeros(1, 21); % # beats for each subject
        store(iPosition).SPVUp = [];
        store(iPosition).SPVDn = [];
        store(iPosition).HRVUp = [];
        store(iPosition).HRVDn = [];
        store(iPosition).SPVUp_norm = [];
        store(iPosition).SPVDn_norm = [];
        store(iPosition).HRVUp_norm = [];
        store(iPosition).HRVDn_norm = [];
        store(iPosition).beatSpDn = []; % beat to beat SPV, dn seq, lag 0
        store(iPosition).beatSpUp = []; % beat to beat SPV, up seq, lag 0
        store(iPosition).beatRRDn = []; % beat to beat HRV, dn seq, lag 0
        store(iPosition).beatRRUp = []; % beat to beat HRV, up seq, lag 0
        store(iPosition).beatSpDn_norm = []; % beat to beat SPV, dn seq, lag 0
        store(iPosition).beatSpUp_norm = []; % beat to beat SPV, up seq, lag 0
        store(iPosition).beatRRDn_norm = []; % beat to beat HRV, dn seq, lag 0
        store(iPosition).beatRRUp_norm = []; % beat to beat HRV, up seq, lag 0
        store(iPosition).beatSpDnC = []; % beat to beat SPV, dn seq, lag 0
        store(iPosition).beatSpUpC = []; % beat to beat SPV, up seq, lag 0
        store(iPosition).beatRRDnC = []; % beat to beat HRV, dn seq within cycle, lag 0
        store(iPosition).beatRRUpC = []; % beat to beat HRV, up seq within cycle, lag 0
        store(iPosition).beatSpDnC_norm = []; % beat to beat SPV, dn seq, lag 0
        store(iPosition).beatSpUpC_norm = []; % beat to beat SPV, up seq, lag 0
        store(iPosition).beatRRDnC_norm = []; % beat to beat HRV, dn seq within cycle, lag 0
        store(iPosition).beatRRUpC_norm = []; % beat to beat HRV, up seq within cycle, lag 0
        store(iPosition).beatSpUp_lag1 = []; % beat to beat SPV, up seq, lag 1
        store(iPosition).beatSpDn_lag1 = []; % beat to beat SPV, dn seq, lag 1
        store(iPosition).beatRRUp_lag1 = []; % beat to beat HRV, up seq, lag 1
        store(iPosition).beatRRDn_lag1 = []; % beat to beat HRV, up seq, lag 1
        store(iPosition).beatRRUp_lag1_norm = []; % beat to beat HRV, up seq, lag 1
        store(iPosition).beatRRDn_lag1_norm = []; % beat to beat HRV, up seq, lag 1
        % ellipse method for sequences
        store(iPosition).UpSeqEllipseL = [];
        store(iPosition).UpSeqEllipsel = [];
        store(iPosition).DnSeqEllipseL = [];
        store(iPosition).DnSeqEllipsel = [];
        store(iPosition).UpG = [];
        store(iPosition).DnG = [];
        store(iPosition).ellipseSlopeDnC = [];
        store(iPosition).ellipseSlopeUpC = [];
        
        for i = 1:length(subjects)
            iSubject = subjects(i);
            store(iPosition).uniqueUpSeqC = [];
            store(iPosition).uniqueDnSeqC = [];
            % peaks
            store(iPosition).rrInt = [store(iPosition).rrInt; res(iPosition).AB(iSubject).rrInt];
            store(iPosition).Sp = [store(iPosition).Sp; res(iPosition).AB(iSubject).Sp];  
            store(iPosition).Dp = [store(iPosition).Dp; -res(iPosition).AB(iSubject).Dp];
            % frequency domain 
%             store(iPosition).psd_LF = [store(iPosition).psd_LF; res(iPosition).BRS(iSubject).psd.HrvLf]; 
%             store(iPosition).psd_HF = [store(iPosition).psd_HF; res(iPosition).BRS(iSubject).psd.HrvHf];
%             store(iPosition).psd_nLF = [store(iPosition).psd_nLF; res(iPosition).BRS(iSubject).psd.HrvLf_nu];
%             store(iPosition).psd_nHF = [store(iPosition).psd_nHF; res(iPosition).BRS(iSubject).psd.HrvHf_nu];
%             store(iPosition).psd_fdRatio = [store(iPosition).psd_fdRatio; res(iPosition).BRS(iSubject).psd.HrvSv];
%             store(iPosition).psd_power = [store(iPosition).psd_power; res(iPosition).BRS(iSubject).psd.total_power];

%             store(iPosition).fft_alphaLF = [store(iPosition).fft_alphaLF; res(iPosition).BRS(iSubject).fft.alphaLf]; 
%             store(iPosition).fft_alphaHF = [store(iPosition).fft_alphaHF; res(iPosition).BRS(iSubject).fft.alphaHf]; 
%             store(iPosition).fft_LF = [store(iPosition).fft_LF; res(iPosition).BRS(iSubject).fft.HrvLf]; 
%             store(iPosition).fft_HF = [store(iPosition).fft_HF; res(iPosition).BRS(iSubject).fft.HrvHf];
%             %store(iPosition).fft_csLF = [store(iPosition).fft_csLF; res(iPosition).BRS(iSubject).fft.CsLf];
%             %store(iPosition).fft_csHF = [store(iPosition).fft_csHF; res(iPosition).BRS(iSubject).fft.CsHf];
%             store(iPosition).fft_nLF = [store(iPosition).fft_nLF; res(iPosition).BRS(iSubject).fft.HrvLf_nu];
%             store(iPosition).fft_nHF = [store(iPosition).fft_nHF; res(iPosition).BRS(iSubject).fft.HrvHf_nu];
%             store(iPosition).fft_fdRatio = [store(iPosition).fft_fdRatio; res(iPosition).BRS(iSubject).fft.HrvSv];
%             store(iPosition).fft_power = [store(iPosition).fft_power; res(iPosition).BRS(iSubject).fft.total_power];
%              store(iPosition).psd_alphaLF = [store(iPosition).psd_alphaLF; res(iPosition).BRS(iSubject).psd.alphaLf]; 
%              store(iPosition).psd_alphaHF = [store(iPosition).psd_alphaHF; res(iPosition).BRS(iSubject).psd.alphaHf]; 

%    
%             if res(iPosition).BRS(iSubject).FreqDomain.cohereHf >= 0.5
%                 store(iPosition).psd_csHF = [store(iPosition).psd_csHF; res(iPosition).BRS(iSubject).psd.CsHf];
%             end
% %             if res(iPosition).BRS(iSubject).FreqDomain.cohereLf >= 0.5
%                 store(iPosition).psd_csLF = [store(iPosition).psd_csLF; res(iPosition).BRS(iSubject).psd.CsLf];
%                 store(iPosition).coherence = [store(iPosition).coherence; res(iPosition).BRS(iSubject).psd.cohereLf];
% %             end
            
            
            % sequence info
             for iSequence = 1:length(res(iPosition).BRS(iSubject).UpSeq) 
                if res(iPosition).BRS(iSubject).UpSeq(iSequence).error > 0.85 
                    store(iPosition).nUp(iSubject, 1) = store(iPosition).nUp(iSubject, 1) + 1;
                    
                    %regression
                    store(iPosition).errorUp = [store(iPosition).errorUp; res(iPosition).BRS(iSubject).UpSeq(iSequence).dist];
                    store(iPosition).errorUp_wo = [store(iPosition).errorUp_wo; res(iPosition).BRS(iSubject).UpSeq(iSequence).dist_wo];
                    store(iPosition).errorSumUp = [store(iPosition).errorSumUp; sum(res(iPosition).BRS(iSubject).UpSeq(iSequence).dist_wo)];
                    
                    store(iPosition).SlopeUp = [store(iPosition).SlopeUp; res(iPosition).BRS(iSubject).UpSeq(iSequence).avg];
                    store(iPosition).SlopeUp_wo = [store(iPosition).SlopeUp_wo; res(iPosition).BRS(iSubject).UpSeq(iSequence).avg_wo];
                    
                    % ellipse method for sequences
                    if ~isempty( res(iPosition).BRS(iSubject).UpSeq(iSequence).ellipse )
                        store(iPosition).ellipseSlopeUp = [store(iPosition).ellipseSlopeUp; tand(res(iPosition).BRS(iSubject).UpSeq(iSequence).ellipse.Orientation)];
                        store(iPosition).ellipseSlopeAll = [store(iPosition).ellipseSlopeAll; tand(res(iPosition).BRS(iSubject).UpSeq(iSequence).ellipse.Orientation)];
                        store(iPosition).SlopeAll = [store(iPosition).SlopeAll; res(iPosition).BRS(iSubject).UpSeq(iSequence).avg];
                        
                    end
                    
                    store(iPosition).nLag(iSubject, 1) = store(iPosition).nLag(iSubject, 1) + 1;
                    
                    % beat analysis
                    tempLagRRUp = NaN(1, 3);
                    tempLagSpUp = NaN(1, 3);
                    tempLagRRUp_norm = NaN(1, 3);
                    tempLagSpUp_norm = NaN(1, 3);
                    iLag = 1;
                    diffSpUp = diff(res(iPosition).BRS(iSubject).UpSeq(iSequence).Sp) ;
                    diffSpUp_norm = diff(res(iPosition).BRS(iSubject).UpSeq(iSequence).Sp) ./ res(iPosition).BRS(iSubject).UpSeq(iSequence).Sp(1:end-1);
                    diffRRUp = diff(res(iPosition).BRS(iSubject).UpSeq(iSequence).rr) ;
                    diffRRUp_norm = diff(res(iPosition).BRS(iSubject).UpSeq(iSequence).rr) ./ res(iPosition).BRS(iSubject).UpSeq(iSequence).rr(1:end-1);
                    while ( iLag <= length( res(iPosition).BRS(iSubject).UpSeq(iSequence).beat ) ) &&  ( iLag < 4 )
                        tempLagSpUp(1, iLag) = diffSpUp(iLag);
                        tempLagRRUp(1, iLag) = diffRRUp(iLag);
                        tempLagSpUp_norm(1, iLag) = diffSpUp_norm(iLag);
                        tempLagRRUp_norm(1, iLag) = diffRRUp_norm(iLag);
                        iLag = iLag + 1;
                    end
                    store(iPosition).beatSpUp = [store(iPosition).beatSpUp; tempLagSpUp];  
                    store(iPosition).beatRRUp = [store(iPosition).beatRRUp; tempLagRRUp]; 
                    store(iPosition).beatSpUp_norm = [store(iPosition).beatSpUp_norm; tempLagSpUp_norm];  
                    store(iPosition).beatRRUp_norm = [store(iPosition).beatRRUp_norm; tempLagRRUp_norm]; 
                end
                 

             end
             for iSequence = 1:length(res(iPosition).BRS(iSubject).DnSeq)
                 if res(iPosition).BRS(iSubject).DnSeq(iSequence).error > 0.85
                     store(iPosition).nDn(iSubject, 1) = store(iPosition).nDn(iSubject, 1) + 1;
                     
                    %regression
                    store(iPosition).errorDn = [store(iPosition).errorDn; res(iPosition).BRS(iSubject).DnSeq(iSequence).dist];
                    store(iPosition).errorDn_wo = [store(iPosition).errorDn_wo; res(iPosition).BRS(iSubject).DnSeq(iSequence).dist_wo];

                    store(iPosition).errorSumDn = [store(iPosition).errorSumDn; sum(res(iPosition).BRS(iSubject).DnSeq(iSequence).dist_wo)];
                    store(iPosition).SlopeDn = [store(iPosition).SlopeDn; res(iPosition).BRS(iSubject).DnSeq(iSequence).avg];
                    store(iPosition).SlopeDn_wo = [store(iPosition).SlopeDn_wo; res(iPosition).BRS(iSubject).DnSeq(iSequence).avg_wo];
                    
                    
                    store(iPosition).nLag(iSubject, 1) = store(iPosition).nLag(iSubject, 1) + 1;
                    
                     % ellipse method for sequences
                    if ~isempty( res(iPosition).BRS(iSubject).DnSeq(iSequence).ellipse )
                        store(iPosition).ellipseSlopeDn = [store(iPosition).ellipseSlopeDn; tand(res(iPosition).BRS(iSubject).DnSeq(iSequence).ellipse.Orientation)];
                        store(iPosition).ellipseSlopeAll = [store(iPosition).ellipseSlopeAll; tand(res(iPosition).BRS(iSubject).DnSeq(iSequence).ellipse.Orientation)];
                        store(iPosition).SlopeAll = [store(iPosition).SlopeAll; res(iPosition).BRS(iSubject).DnSeq(iSequence).avg];
                    end
                    
                    % beat analysis 
                    iLag = 1;
                    tempLagSpDn = NaN(1, 3);
                    tempLagRRDn = NaN(1, 3);
                    tempLagSpDn_norm = NaN(1, 3);
                    tempLagRRDn_norm = NaN(1, 3);
                    diffSpDn_norm = diff(res(iPosition).BRS(iSubject).DnSeq(iSequence).Sp) ./ res(iPosition).BRS(iSubject).DnSeq(iSequence).Sp(1:end-1);
                    diffRRDn_norm = diff(res(iPosition).BRS(iSubject).DnSeq(iSequence).rr) ./ res(iPosition).BRS(iSubject).DnSeq(iSequence).rr(1:end-1);
                    diffSpDn = diff(res(iPosition).BRS(iSubject).DnSeq(iSequence).Sp);
                    diffRRDn = diff(res(iPosition).BRS(iSubject).DnSeq(iSequence).rr);
                    while ( iLag <= length( res(iPosition).BRS(iSubject).DnSeq(iSequence).beat ) ) && ( iLag < 4 )
                        tempLagSpDn(1, iLag) = diffSpDn(iLag);
                        tempLagRRDn(1, iLag) = diffRRDn(iLag);
                        tempLagSpDn_norm(1, iLag) = diffSpDn_norm(iLag);
                        tempLagRRDn_norm(1, iLag) = diffRRDn_norm(iLag);
                        iLag = iLag + 1;
                    end
                    store(iPosition).beatSpDn = [store(iPosition).beatSpDn; tempLagSpDn];
                    store(iPosition).beatRRDn = [store(iPosition).beatRRDn; tempLagRRDn]; 
                    store(iPosition).beatSpDn_norm = [store(iPosition).beatSpDn_norm; tempLagSpDn_norm];
                    store(iPosition).beatRRDn_norm = [store(iPosition).beatRRDn_norm; tempLagRRDn_norm]; 
                 end 
                 

             end
             % cycle information
            store(iPosition).nCycles(iSubject) = length( res(iPosition).BRS(iSubject).BrsCycle );
            for iBRSCycle = 1:length(res(iPosition).BRS(iSubject).BrsCycle)
                
              % if ~isempty(res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse) && tand(res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.Orientation) <= 35 
                %regression method
                
                    store(iPosition).RegSlope = [store(iPosition).RegSlope; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).reg.Slope];
                    store(iPosition).RegL = [store(iPosition).RegL; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).reg.MjrAxisLength];
                    store(iPosition).Regl = [store(iPosition).Regl; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).reg.MnrAxisLength];
                    iUp = res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).UpSeq;
                    iDn = res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).DnSeq;
                

                    if ~ismember( iUp, store(iPosition).uniqueUpSeqC ) 
                        store(iPosition).uniqueUpSeqC = [store(iPosition).uniqueUpSeqC; iUp];

                        % brs, reg
                        store(iPosition).SlopeUpC = [store(iPosition).SlopeUpC; res(iPosition).BRS(iSubject).UpSeq(iUp).avg];

                        % ellipse for sequences
                        if ~isempty( res(iPosition).BRS(iSubject).UpSeq(iUp).ellipse ) 

                            % brs, ellipse
                            store(iPosition).ellipseSlopeUpC = [store(iPosition).ellipseSlopeUpC; tand(res(iPosition).BRS(iSubject).UpSeq(iUp).ellipse.Orientation)];
                            store(iPosition).UpSeqEllipseL = [store(iPosition).UpSeqEllipseL; 2*res(iPosition).BRS(iSubject).UpSeq(iUp).ellipse.MjrSemiAxis];
                            store(iPosition).UpSeqEllipsel = [store(iPosition).UpSeqEllipsel; 2*res(iPosition).BRS(iSubject).UpSeq(iUp).ellipse.MnrSemiAxis];
                            store(iPosition).SlopeAllC = [store(iPosition).SlopeAllC; res(iPosition).BRS(iSubject).UpSeq(iUp).avg];
                            store(iPosition).ellipseSlopeAllC = [store(iPosition).ellipseSlopeAllC; tand(res(iPosition).BRS(iSubject).UpSeq(iUp).ellipse.Orientation)];

                        end

                        % beat to beat
                        temp = abs(diff(res(iPosition).BRS(iSubject).UpSeq(iUp).rr))';
                        store(iPosition).HRVUp = [store(iPosition).HRVUp; res(iPosition).BRS(iSubject).UpSeq(iUp).rr(end)-res(iPosition).BRS(iSubject).UpSeq(iUp).rr(1)];
                        store(iPosition).HRVUp_norm = [store(iPosition).HRVUp_norm; ( res(iPosition).BRS(iSubject).UpSeq(iUp).rr(end)-res(iPosition).BRS(iSubject).UpSeq(iUp).rr(1) )/res(iPosition).BRS(iSubject).UpSeq(iUp).rr(1)];
                        if length(temp) > 2
                            store(iPosition).beatRRUpC = [store(iPosition).beatRRUpC; temp(1:3)]; % beat to beat HRV, dn seq within cycle, lag 0
                            store(iPosition).beatRRUpC_norm = [store(iPosition).beatRRUpC_norm; temp(1:3)./res(iPosition).BRS(iSubject).UpSeq(iUp).rr(1:3)'];
                        else
                            store(iPosition).beatRRUpC_norm = [store(iPosition).beatRRUpC_norm; [temp(1:2)./res(iPosition).BRS(iSubject).UpSeq(iUp).rr(1:2)' NaN] ];
                            store(iPosition).beatRRUpC = [store(iPosition).beatRRUpC; [temp(1:2) NaN] ];
                        end
                        temp = abs(diff(res(iPosition).BRS(iSubject).UpSeq(iUp).Sp))';
                        store(iPosition).SPVUp = [store(iPosition).SPVUp; res(iPosition).BRS(iSubject).UpSeq(iUp).Sp(end)-res(iPosition).BRS(iSubject).UpSeq(iUp).Sp(1)];
                        store(iPosition).SPVUp_norm = [store(iPosition).SPVUp_norm; (res(iPosition).BRS(iSubject).UpSeq(iUp).Sp(end)-res(iPosition).BRS(iSubject).UpSeq(iUp).Sp(1))/res(iPosition).BRS(iSubject).UpSeq(iUp).Sp(1)];
                        if length(temp) > 2
                            store(iPosition).beatSpUpC = [store(iPosition).beatSpUpC; temp(1:3)]; % beat to beat HRV, dn seq within cycle, lag 0
                            store(iPosition).beatSpUpC_norm = [store(iPosition).beatSpUpC_norm; temp(1:3)./res(iPosition).BRS(iSubject).UpSeq(iUp).Sp(1:3)'];
                        else
                            store(iPosition).beatSpUpC = [store(iPosition).beatSpUpC; [temp(1:2) NaN] ];
                            store(iPosition).beatSpUpC_norm = [store(iPosition).beatSpUpC_norm; [temp(1:2)./res(iPosition).BRS(iSubject).UpSeq(iUp).Sp(1:2)' NaN] ];
                        end 
                    end
                
                    if ~isempty( res(iPosition).BRS(iSubject).DnSeq(iDn).ellipse )
                            % magnitude H
                            G = (res(iPosition).BRS(iSubject).DnSeq(iDn).ellipse.MnrSemiAxis*2)/res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.MnrSemiAxis;
                            store(iPosition).DnG = [store(iPosition).DnG; G];
                            if G > 1
                                store(iPosition).sum = store(iPosition).sum + 1;
                            end
                    end
                 
                    if ~isempty( res(iPosition).BRS(iSubject).UpSeq(iUp).ellipse )
                            %magnitude H
                            G = (res(iPosition).BRS(iSubject).UpSeq(iUp).ellipse.MnrSemiAxis*2)/res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.MnrSemiAxis;
                            store(iPosition).UpG = [store(iPosition).UpG; G]; 
                            if G > 1
                                store(iPosition).sum = store(iPosition).sum + 1;
                            end
                    end
     
                   if ~ismember( iDn, store(iPosition).uniqueDnSeqC ) 

                       store(iPosition).uniqueDnSeqC = [store(iPosition).uniqueDnSeqC; iDn];

                       % brs, regression
                       store(iPosition).SlopeDnC = [store(iPosition).SlopeDnC; res(iPosition).BRS(iSubject).DnSeq(iDn).avg];
% 
%                        % ellipse of sequence
                       if ~isempty( res(iPosition).BRS(iSubject).DnSeq(iDn).ellipse )
                           % brs, ellipse
                            store(iPosition).ellipseSlopeDnC = [store(iPosition).ellipseSlopeDnC; tand(res(iPosition).BRS(iSubject).DnSeq(iDn).ellipse.Orientation)];
                            store(iPosition).DnSeqEllipseL = [store(iPosition).DnSeqEllipseL; 2*res(iPosition).BRS(iSubject).DnSeq(iDn).ellipse.MjrSemiAxis];
                            store(iPosition).DnSeqEllipsel = [store(iPosition).DnSeqEllipsel; 2*res(iPosition).BRS(iSubject).DnSeq(iDn).ellipse.MnrSemiAxis];
                            store(iPosition).ellipseSlopeAllC = [store(iPosition).ellipseSlopeAllC; tand(res(iPosition).BRS(iSubject).DnSeq(iDn).ellipse.Orientation)];
                            store(iPosition).SlopeAllC = [store(iPosition).SlopeAllC; res(iPosition).BRS(iSubject).DnSeq(iDn).avg];
                        end
                   
                       % beat to beat
                        temp = abs(diff(res(iPosition).BRS(iSubject).DnSeq(iDn).Sp))';
                        store(iPosition).SPVDn = [store(iPosition).SPVDn; res(iPosition).BRS(iSubject).DnSeq(iDn).Sp(end)-res(iPosition).BRS(iSubject).DnSeq(iDn).Sp(1)];
                        store(iPosition).SPVDn_norm = [store(iPosition).SPVDn_norm; ( res(iPosition).BRS(iSubject).DnSeq(iDn).Sp(end)-res(iPosition).BRS(iSubject).DnSeq(iDn).Sp(1) )/res(iPosition).BRS(iSubject).DnSeq(iDn).Sp(1)];
                        if length(temp) > 2
                            store(iPosition).beatSpDnC = [store(iPosition).beatSpDnC; temp(1:3)]; % beat to beat HRV, dn seq within cycle, lag 0
                            store(iPosition).beatSpDnC_norm = [store(iPosition).beatSpDnC_norm; temp(1:3)./res(iPosition).BRS(iSubject).DnSeq(iDn).Sp(1:3)']; % beat to beat HRV, dn seq within cycle, lag 0
                        else
                            store(iPosition).beatSpDnC = [store(iPosition).beatSpDnC; [temp(1:2) NaN] ];
                            store(iPosition).beatSpDnC_norm = [store(iPosition).beatSpDnC_norm; [temp(1:2)./res(iPosition).BRS(iSubject).DnSeq(iDn).Sp(1:2)' NaN] ];
                        end

                        temp = abs(diff(res(iPosition).BRS(iSubject).DnSeq(iDn).rr))';
                        store(iPosition).HRVDn = [store(iPosition).HRVDn; res(iPosition).BRS(iSubject).DnSeq(iDn).rr(end)-res(iPosition).BRS(iSubject).DnSeq(iDn).rr(1)];
                        store(iPosition).HRVDn_norm = [store(iPosition).HRVDn_norm; ( res(iPosition).BRS(iSubject).DnSeq(iDn).rr(end)-res(iPosition).BRS(iSubject).DnSeq(iDn).rr(1) )/res(iPosition).BRS(iSubject).DnSeq(iDn).rr(1)];
                        if length(temp) > 2
                            store(iPosition).beatRRDnC = [store(iPosition).beatRRDnC; temp(1:3)]; % beat to beat HRV, dn seq within cycle, lag 0
                            store(iPosition).beatRRDnC_norm = [store(iPosition).beatRRDnC_norm; temp(1:3)./res(iPosition).BRS(iSubject).DnSeq(iDn).rr(1:3)'];
                        else
                            store(iPosition).beatRRDnC = [store(iPosition).beatRRDnC; [temp(1:2) NaN] ];
                            store(iPosition).beatRRDnC_norm = [store(iPosition).beatRRDnC_norm; [temp(1:2)./res(iPosition).BRS(iSubject).DnSeq(iDn).rr(1:2)' NaN] ];
                        end
                   end

                    store(iPosition).errorUpC = [store(iPosition).errorUpC; res(iPosition).BRS(iSubject).UpSeq(iUp).dist_wo];
                    store(iPosition).errorSumUpC = [store(iPosition).errorSumUpC; sum(res(iPosition).BRS(iSubject).UpSeq(iUp).dist_wo)];
                    store(iPosition).errorSumDnC = [store(iPosition).errorSumDnC; sum(res(iPosition).BRS(iSubject).DnSeq(iDn).dist_wo)];
                    store(iPosition).errorDnC = [store(iPosition).errorDnC; res(iPosition).BRS(iSubject).DnSeq(iDn).dist_wo];
                    store(iPosition).SpC = [store(iPosition).SpC; res(iPosition).BRS(iSubject).UpSeq(iUp).Sp];
                    store(iPosition).SpC = [store(iPosition).SpC; res(iPosition).BRS(iSubject).DnSeq(iDn).Sp];
                    store(iPosition).rrIntC = [store(iPosition).rrIntC; res(iPosition).BRS(iSubject).UpSeq(iUp).rr];
                    store(iPosition).rrIntC = [store(iPosition).rrIntC; res(iPosition).BRS(iSubject).DnSeq(iDn).rr];
                    %ellipse method
                    if ~isempty( res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse ) 
                        store(iPosition).EllipseL = [store(iPosition).EllipseL; 2*res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.MjrSemiAxis ];
                        store(iPosition).Ellipsel = [store(iPosition).Ellipsel; 2*res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.MnrSemiAxis ];
                        store(iPosition).EllipseSlope = [store(iPosition).EllipseSlope; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.BRS ];
                       
                        Maxis = res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.MjrSemiAxis;
                        maxis = res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.MnrSemiAxis;
                        ratio = maxis/Maxis;
                        store(iPosition).magnitudeH = [store(iPosition).magnitudeH; ratio];
                        store(iPosition).ProjAngle = [store(iPosition).ProjAngle; acosd(ratio)]; % orientation angle of plane
                        area = pi * maxis * Maxis;
                        store(iPosition).ellipseArea = [store(iPosition).ellipseArea; area];
                        store(iPosition).area = [store(iPosition).area; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).area];
                        store(iPosition).Centroids = [store(iPosition).Centroids; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.Cntrd];
                        store(iPosition).deltaBRS = [store(iPosition).deltaBRS; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).deltaBRS]; 
                        store(iPosition).setpoint = [store(iPosition).setpoint; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.setpoint]; 
                        if res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.setpoint < 0
                            store(iPosition).negative = store(iPosition).negative + 1;
                        else
                            store(iPosition).positive = store(iPosition).positive + 1;
                        end
                        %new_setpoint = res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.dist_ps - median (res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.dist_ps) + mymed;
                        %store(iPosition).dist_ps = [store(iPosition).dist_ps; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.dist_ps'];
                        %store(iPosition).dist_setpoint = [store(iPosition).dist_setpoint; res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.dist_setpoint'];
                    end
              % else
                  % plot(res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).pgonAll); hold on;
                 %  plot(res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.Ellipse(1,:) + res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.Cntrd(1), res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.Ellipse(2,:) +  res(iPosition).BRS(iSubject).BrsCycle(iBRSCycle).ellipse.Cntrd(2)); hold on;

              % end
                    
            end 
            
            % Lag analysis
            for iSeq = 1:length( res(iPosition).BRS(iSubject).lag1_Up )
                if ~isempty ( res(iPosition).BRS(iSubject).lag1_Up(iSeq).ellipse )
                    store(iPosition).ellipseSlope_lag1 = [store(iPosition).ellipseSlope_lag1; tand( res(iPosition).BRS(iSubject).lag1_Up(iSeq).ellipse.Orientation ) ];
                end
                if res(iPosition).BRS(iSubject).lag1_Up(iSeq).error > 0.85
                   store(iPosition).lag1 = [store(iPosition).lag1; res(iPosition).BRS(iSubject).lag1_Up(iSeq).avg]; 
                   % storing # of sequences
                   store(iPosition).nLag(iSubject, 2) = store(iPosition).nLag(iSubject, 2) + 1;  
                   
                   % beat analysis 
                    iLag = 1;
                    tempLagSpUp = NaN(1, 3);
                    tempLagRRUp = NaN(1, 3);
                    tempLagRRUp_norm = NaN(1, 3);
                    diffSpUp = diff(res(iPosition).BRS(iSubject).lag1_Up(iSeq).Sp);
                    diffRRUp_norm = diff(res(iPosition).BRS(iSubject).lag1_Up(iSeq).rr) ./ res(iPosition).BRS(iSubject).lag1_Up(iSeq).rr(1:end-1);
                    diffRRUp = diff(res(iPosition).BRS(iSubject).lag1_Up(iSeq).rr) ;
                    while ( iLag <= length( res(iPosition).BRS(iSubject).lag1_Up(iSeq).beat ) ) && ( iLag < 4 )
                        tempLagSpUp(1, iLag) = diffSpUp(iLag);
                        tempLagRRUp(1, iLag) = diffRRUp(iLag);
                        tempLagRRUp_norm(1, iLag) = diffRRUp_norm(iLag);
                        iLag = iLag + 1;
                    end
                    store(iPosition).beatSpUp_lag1 = [store(iPosition).beatSpUp_lag1; tempLagSpUp];
                    store(iPosition).beatRRUp_lag1 = [store(iPosition).beatRRUp_lag1; tempLagRRUp]; 
                    store(iPosition).beatRRUp_lag1_norm = [store(iPosition).beatRRUp_lag1_norm; tempLagRRUp_norm];
                   
                end
            end
            for iSeq = 1:length( res(iPosition).BRS(iSubject).lag1_Dn )
                if ~isempty ( res(iPosition).BRS(iSubject).lag1_Dn(iSeq).ellipse)
                    store(iPosition).ellipseSlope_lag1 = [store(iPosition).ellipseSlope_lag1; tand( res(iPosition).BRS(iSubject).lag1_Dn(iSeq).ellipse.Orientation ) ];
                end
                if res(iPosition).BRS(iSubject).lag1_Dn(iSeq).error > 0.85
                   store(iPosition).lag1 = [store(iPosition).lag1; res(iPosition).BRS(iSubject).lag1_Dn(iSeq).avg]; 
                   store(iPosition).nLag(iSubject, 2) = store(iPosition).nLag(iSubject, 2) + 1;
                   % beat analysis 
                    iLag = 1;
                    tempLagSpDn = NaN(1, 3);
                    tempLagRRDn = NaN(1, 3);
                    tempLagRRDn_norm = NaN(1, 3);
                    diffSpDn = diff(res(iPosition).BRS(iSubject).lag1_Dn(iSeq).Sp);
                    diffRRDn_norm = diff(res(iPosition).BRS(iSubject).lag1_Dn(iSeq).rr) ./ res(iPosition).BRS(iSubject).lag1_Dn(iSeq).rr(1:end-1);
                    diffRRDn = diff(res(iPosition).BRS(iSubject).lag1_Dn(iSeq).rr) ;
                    while ( iLag <= length( res(iPosition).BRS(iSubject).lag1_Dn(iSeq).beat ) ) && ( iLag < 4 )
                        tempLagSpDn(1, iLag) = diffSpDn(iLag);
                        tempLagRRDn(1, iLag) = diffRRDn(iLag);
                        tempLagRRDn_norm(1, iLag) = diffRRDn_norm(iLag);
                        iLag = iLag + 1;
                    end
                    store(iPosition).beatSpDn_lag1 = [store(iPosition).beatSpDn_lag1; tempLagSpDn];
                    store(iPosition).beatRRDn_lag1 = [store(iPosition).beatRRDn_lag1; tempLagRRDn];
                    store(iPosition).beatRRDn_lag1_norm = [store(iPosition).beatRRDn_lag1_norm; tempLagRRDn_norm];
                end
            end
%             for iSeq = 1:length( res(iPosition).BRS(iSubject).lag2_Up )
%                 if res(iPosition).BRS(iSubject).lag2_Up(iSeq).error > 0.85
%                    store(iPosition).lag2 = [store(iPosition).lag2; res(iPosition).BRS(iSubject).lag2_Up(iSeq).avg]; 
%                    store(iPosition).nLag(iSubject, 3) = store(iPosition).nLag(iSubject, 3) + 1;
%                 end
%             end
%             for iSeq = 1:length( res(iPosition).BRS(iSubject).lag2_Dn )
%                 if res(iPosition).BRS(iSubject).lag2_Dn(iSeq).error > 0.85
%                    store(iPosition).lag2 = [store(iPosition).lag2; res(iPosition).BRS(iSubject).lag2_Dn(iSeq).avg_wo]; 
%                    store(iPosition).nLag(iSubject, 3) = store(iPosition).nLag(iSubject, 3) + 1;
%                 end
%             end

            % normalization of % sequence for 512 beats
            store(iPosition).allBeats(1, iSubject) = length( res(iPosition).AB(iSubject).Rp );
            store(iPosition).nLag(iSubject, :) = ( (store(iPosition).nLag(iSubject, :) ./ store(iPosition).allBeats(1, iSubject) ) ) .* 512;
        end
        store(iPosition).SlopeUp = rmoutliers(store(iPosition).SlopeUp);
        store(iPosition).SlopeDn= rmoutliers(store(iPosition).SlopeDn);
        store(iPosition).SlopeUpC = rmoutliers(store(iPosition).SlopeUpC);
        store(iPosition).SlopeDnC = rmoutliers(store(iPosition).SlopeDnC);
        store(iPosition).ellipseSlopeUp = rmoutliers(store(iPosition).ellipseSlopeUp);
        store(iPosition).ellipseSlopeDn = rmoutliers(store(iPosition).ellipseSlopeDn);
        store(iPosition).ellipseSlopeUpC = rmoutliers(store(iPosition).ellipseSlopeUpC);
        store(iPosition).ellipseSlopeDnC = rmoutliers(store(iPosition).ellipseSlopeDnC);
%          store(iPosition).EllipseSlope = store(iPosition).EllipseSlope/10;
%          store(iPosition).EllipseSlope = rmoutliers(store(iPosition).EllipseSlope);
        
    end
    
    %normalization of length of axes for regression and ellipse method
    %normalization factor is the biggest median of all axes
    normL = max ([median(store(1).RegL), median(store(2).RegL), median(store(1).EllipseL), median(store(2).EllipseL)]); 
    store(1).RegL_norm = store(1).RegL ./ normL;
    store(2).RegL_norm = store(2).RegL ./ normL;
    store(1).EllipseL_norm = store(1).EllipseL ./ normL;
    store(2).EllipseL_norm = store(2).EllipseL ./ normL;
    store(1).Regl_norm = store(1).Regl ./ normL;
    store(2).Regl_norm = store(2).Regl ./ normL;
    store(1).Ellipsel_norm = store(1).Ellipsel ./ normL;
    store(2).Ellipsel_norm = store(2).Ellipsel ./ normL;
    


end