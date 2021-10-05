function [stats] = statistics(store)
% This function calculates, from stored variables, their statistical values
% of interest

    % peaks
    % % RRI
%     stats(1).rrInt.mean = mean (store(1).rrInt) ; % mean
%     stats(2).rrInt.mean = mean (store(2).rrInt) ; 
%     stats(1).rrInt.std = std (store(1).rrInt) ; % standard deviation
%     stats(2).rrInt.std = std (store(2).rrInt) ; 
%     stats(1).rrInt.max = max (store(1).rrInt) ; % maximum
%     stats(2).rrInt.max = max (store(1).rrInt) ; 
%     stats(1).rrInt.min = min (store(1).rrInt) ; % minimum
%     stats(2).rrInt.min = min (store(1).rrInt) ; 
%     [~, stats(1).rrInt.pvalue] = ttest2(store(1).rrInt, store(2).rrInt ); % statistical significance, between sup and tilt
    % % RRI range for cycles
%     stats(1).rrIntC.max = max (store(1).rrIntC) ; % maximum
%     stats(2).rrIntC.max = max (store(2).rrIntC) ; 
%     stats(1).rrIntC.min = min (store(1).rrIntC) ; % minimum
%     stats(2).rrIntC.min = min (store(2).rrIntC) ; 
%     [~, stats(1).rrIntC.pvalue] = ttest2(store(1).rrIntC, store(2).rrIntC ); % statistical significance, between sup and tilt
%     % % heart rate variability
%     stats(1).hrv.mean = mean ( abs(diff(store(1).rrInt)) ) ; % mean 
%     stats(2).hrv.mean = mean ( abs(diff(store(2).rrInt)) ) ; 
%     stats(1).hrv.std = std ( abs(diff(store(1).rrInt)) ) ; % standard deviation
%     stats(2).hrv.std = std ( abs(diff(store(2).rrInt)) ) ; 
%     [~, stats(1).hrv.pvalue] = ttest2(abs(diff(store(1).rrInt)), abs(diff(store(2).rrInt)) ); % statistical significance, between sup and tilt
    % % DBP 
    stats(1).Dp.mean = mean (store(1).Dp) ; % mean
    stats(2).Dp.mean = mean (store(2).Dp) ; 
    stats(1).Dp.median = median (store(1).Dp) ; % median
    stats(2).Dp.median = median (store(2).Dp) ;
    stats(1).Dp.Q1 = quantile (store(1).Dp, 0.25) ; % 25th quartile
    stats(2).Dp.Q1 = quantile (store(2).Dp, 0.25) ;
    stats(1).Dp.Q2 = quantile (store(1).Dp, 0.75) ; % 75th quartile
    stats(2).Dp.Q2 = quantile (store(2).Dp, 0.75) ;
    stats(1).Dp.std = std (store(1).Dp) ; % standard deviation
    stats(2).Dp.std = std (store(2).Dp) ;
    stats(1).Dp.max = max (store(1).Dp) ; % maximum
    stats(2).Dp.max = max (store(2).Dp) ; 
    stats(1).Dp.min = min (store(1).Dp) ; % minimum
    stats(2).Dp.min = min (store(2).Dp);
    [~, stats(1).Dp.pvalue] = ttest2(store(2).Dp, store(1).Dp ); % statistical significance, between sup and tilt
    % % SBP
    stats(1).Sp.mean = mean (store(1).Sp) ; % mean
    stats(2).Sp.mean = mean (store(2).Sp) ; 
    stats(1).Sp.std = std (store(1).Sp) ; % standard deviation
    stats(2).Sp.std = std (store(2).Sp) ; 
    stats(1).Sp.max = max (store(1).Sp) ; % maximum
    stats(2).Sp.max = max (store(2).Sp) ; 
    stats(1).Sp.min = min (store(1).Sp) ; % minimum
    stats(2).Sp.min = min (store(2).Sp) ;
    [~, stats(1).Sp.pvalue] = ttest2(store(2).Sp, store(1).Sp ); % statistical significance, between sup and tilt
    % % SBP for cycles
    stats(1).SpC.max = max (store(1).SpC) ; % maximum
    stats(2).SpC.max = max (store(2).SpC) ; 
    stats(1).SpC.min = min (store(1).SpC) ; % minimum
    stats(2).SpC.min = min (store(2).SpC) ; 
    [~, stats(1).SpC.pvalue] = ttest2(store(1).SpC, store(2).SpC ); % statistical significance, between sup and tilt
    
    % frequency domain 
    % % alphaLF psd
    stats(1).psd_alphaLF.median = nanmedian (store(1).psd_alphaLF) ; % median
    stats(2).psd_alphaLF.median = nanmedian (store(2).psd_alphaLF) ;
    stats(1).psd_alphaLF.mean = nanmean (store(1).psd_alphaLF) ; % mean
    stats(2).psd_alphaLF.mean = nanmean (store(2).psd_alphaLF) ; 
    stats(1).psd_alphaLF.std = nanstd (store(1).psd_alphaLF) ;  % standard deviation
    stats(2).psd_alphaLF.std = nanstd (store(2).psd_alphaLF) ; 
    [~, stats(1).psd_alphaLF.pvalue] = ttest2 (store(1).psd_alphaLF, store(2).psd_alphaLF); % statistical significance, between sup and tilt
    % % alphaLF fft
    stats(1).fft_alphaLF.median = nanmedian (store(1).fft_alphaLF) ; % median
    stats(2).fft_alphaLF.median = nanmedian (store(2).fft_alphaLF) ;
    stats(1).fft_alphaLF.mean = nanmean (store(1).fft_alphaLF) ; % mean
    stats(2).fft_alphaLF.mean = nanmean (store(2).fft_alphaLF) ; 
    stats(1).fft_alphaLF.std = nanstd (store(1).fft_alphaLF) ;  % standard deviation
    stats(2).fft_alphaLF.std = nanstd (store(2).fft_alphaLF) ; 
    [~, stats(1).fft_alphaLF.pvalue] = ttest2 (store(1).fft_alphaLF, store(2).fft_alphaLF); % statistical significance, between sup and tilt
    % % alphaHF psd
    stats(1).psd_alphaHF.median = nanmedian (store(1).psd_alphaHF) ; % median
    stats(2).psd_alphaHF.median = nanmedian (store(2).psd_alphaHF) ;
    stats(1).psd_alphaHF.mean = nanmean (store(1).psd_alphaHF) ; % mean
    stats(2).psd_alphaHF.mean = nanmean (store(2).psd_alphaHF) ; 
    stats(1).psd_alphaHF.std = nanstd (store(1).psd_alphaHF) ;  % standard deviation
    stats(2).psd_alphaHF.std = nanstd (store(2).psd_alphaHF) ; 
    [~, stats(1).psd_alphaHF.pvalue] = ttest2 (store(1).psd_alphaHF, store(2).psd_alphaHF); % statistical significance, between sup and tilt
    % % alphaHF fft
    stats(1).fft_alphaHF.median = nanmedian (store(1).fft_alphaHF) ; % median
    stats(2).fft_alphaHF.median = nanmedian (store(2).fft_alphaHF) ;
    stats(1).fft_alphaHF.mean = nanmean (store(1).fft_alphaHF) ; % mean
    stats(2).fft_alphaHF.mean = nanmean (store(2).fft_alphaHF) ; 
    stats(1).fft_alphaHF.std = nanstd (store(1).fft_alphaHF) ;  % standard deviation
    stats(2).fft_alphaHF.std = nanstd (store(2).fft_alphaHF) ; 
    [~, stats(1).fft_alphaHF.pvalue] = ttest2 (store(1).fft_alphaHF, store(2).fft_alphaHF); % statistical significance, between sup and tilt
    % % csLF psd
    stats(1).psd_csHF.median = nanmedian (store(1).psd_csHF) ; % median
    stats(2).psd_csHF.median = nanmedian (store(2).psd_csHF) ;
    stats(1).psd_csHF.mean = nanmean (store(1).psd_csHF) ; % mean
    stats(2).psd_csHF.mean = nanmean (store(2).psd_csHF) ; 
    stats(1).psd_csHF.std = nanstd (store(1).psd_csHF) ;  % standard deviation
    stats(2).psd_csHF.std = nanstd (store(2).psd_csHF) ; 
    [~, stats(1).psd_csHF.pvalue] = ttest2 (store(1).psd_csHF, store(2).psd_csHF); % statistical significance, between sup and tilt
    % % csHF psd
    stats(1).psd_csLF.median = nanmedian (store(1).psd_csLF) ; % median
    stats(2).psd_csLF.median = nanmedian (store(2).psd_csLF) ;
    stats(1).psd_csLF.mean = nanmean (store(1).psd_csLF) ; % mean
    stats(2).psd_csLF.mean = nanmean (store(2).psd_csLF) ; 
    stats(1).psd_csLF.std = nanstd (store(1).psd_csLF) ;  % standard deviation
    stats(2).psd_csLF.std = nanstd (store(2).psd_csLF) ; 
    [~, stats(1).psd_csLF.pvalue] = ttest2 (store(1).psd_csLF, store(2).psd_csLF); % statistical significance, between sup and tilt
    % % LF psd
    stats(1).psd_LF.median = nanmedian (store(1).psd_LF) ; % median
    stats(2).psd_LF.median = nanmedian (store(2).psd_LF) ;
    stats(1).psd_LF.mean = nanmean (store(1).psd_LF) ; % mean
    stats(2).psd_LF.mean = nanmean (store(2).psd_LF) ; 
    stats(1).psd_LF.std = nanstd (store(1).psd_LF) ;  % standard deviation
    stats(2).psd_LF.std = nanstd (store(2).psd_LF) ; 
    [~, stats(1).psd_LF.pvalue] = ttest2 (store(1).psd_LF, store(2).psd_LF); % statistical significance, between sup and tilt
    % % LF fft
    stats(1).fft_LF.median = nanmedian (store(1).fft_LF) ; % median
    stats(2).fft_LF.median = nanmedian (store(2).fft_LF) ;
    stats(1).fft_LF.mean = nanmean (store(1).fft_LF) ; % mean
    stats(2).fft_LF.mean = nanmean (store(2).fft_LF) ; 
    stats(1).fft_LF.std = nanstd (store(1).fft_LF) ;  % standard deviation
    stats(2).fft_LF.std = nanstd (store(2).fft_LF) ; 
    [~, stats(1).fft_LF.pvalue] = ttest2 (store(1).fft_LF, store(2).fft_LF); % statistical significance, between sup and tilt
    % % HF psd
    stats(1).psd_HF.median = nanmedian (store(1).psd_HF) ; % median
    stats(2).psd_HF.median = nanmedian (store(2).psd_HF) ;
    stats(1).psd_HF.mean = nanmean (store(1).psd_HF) ; % mean
    stats(2).psd_HF.mean = nanmean (store(2).psd_HF) ; 
    stats(1).psd_HF.std = nanstd (store(1).psd_HF) ;  % standard deviation
    stats(2).psd_HF.std = nanstd (store(2).psd_HF) ; 
    [~, stats(1).psd_HF.pvalue] = ttest2 (store(1).psd_HF, store(2).psd_HF); % statistical significance, between sup and tilt
    % % HF fft
    stats(1).fft_HF.median = nanmedian (store(1).fft_HF) ; % median
    stats(2).fft_HF.median = nanmedian (store(2).fft_HF) ;
    stats(1).fft_HF.mean = nanmean (store(1).fft_HF) ; % mean
    stats(2).fft_HF.mean = nanmean (store(2).fft_HF) ; 
    stats(1).fft_HF.std = nanstd (store(1).fft_HF) ;  % standard deviation
    stats(2).fft_HF.std = nanstd (store(2).fft_HF) ; 
    [~, stats(1).fft_HF.pvalue] = ttest2 (store(1).fft_HF, store(2).fft_HF); % statistical significance, between sup and tilt
     % % ratio psd
     stats(1).psd_fdRatio.median = nanmedian (store(1).psd_fdRatio) ; % median
    stats(2).psd_fdRatio.median = nanmedian (store(2).psd_fdRatio) ;
    stats(1).psd_fdRatio.mean = nanmean (store(1).psd_fdRatio) ; % mean
    stats(2).psd_fdRatio.mean = nanmean (store(2).psd_fdRatio) ; 
    stats(1).psd_fdRatio.std = nanstd (store(1).psd_fdRatio) ;  % standard deviation
    stats(2).psd_fdRatio.std = nanstd (store(2).psd_fdRatio) ; 
    [~, stats(1).psd_fdRatio.pvalue] = ttest2 (store(1).psd_fdRatio, store(2).psd_fdRatio); % statistical significance, between sup and tilt
    % % ratio fft
    stats(1).fft_fdRatio.median = nanmedian (store(1).fft_fdRatio) ; % median
    stats(2).fft_fdRatio.median = nanmedian (store(2).fft_fdRatio) ;
    stats(1).fft_fdRatio.mean = nanmean (store(1).fft_fdRatio) ; % mean
    stats(2).fft_fdRatio.mean = nanmean (store(2).fft_fdRatio) ; 
    stats(1).fft_fdRatio.std = nanstd (store(1).fft_fdRatio) ;  % standard deviation
    stats(2).fft_fdRatio.std = nanstd (store(2).fft_fdRatio) ; 
    [~, stats(1).fft_fdRatio.pvalue] = ttest2 (store(1).fft_fdRatio, store(2).fft_fdRatio); % statistical significance, between sup and tilt
     % % nLF psd
     stats(1).psd_nLF.median = nanmedian (store(1).psd_nLF) ; % median
    stats(2).psd_nLF.median = nanmedian (store(2).psd_nLF) ; 
    stats(1).psd_nLF.mean = nanmean (store(1).psd_nLF) ; % mean
    stats(2).psd_nLF.mean = nanmean (store(2).psd_nLF) ; 
    stats(1).psd_nLF.std = nanstd (store(1).psd_nLF) ;  % standard deviation
    stats(2).psd_nLF.std = nanstd (store(2).psd_nLF) ; 
    [~, stats(1).psd_nLF.pvalue] = ttest2 (store(1).psd_nLF, store(2).psd_nLF); % statistical significance, between sup and tilt
    % % nLF fft
    stats(1).fft_nLF.median = nanmedian (store(1).fft_nLF) ; % median
    stats(2).fft_nLF.median = nanmedian (store(2).fft_nLF) ; 
    stats(1).fft_nLF.mean = nanmean (store(1).fft_nLF) ; % mean
    stats(2).fft_nLF.mean = nanmean (store(2).fft_nLF) ; 
    stats(1).fft_nLF.std = nanstd (store(1).fft_nLF) ;  % standard deviation
    stats(2).fft_nLF.std = nanstd (store(2).fft_nLF) ; 
    [~, stats(1).fft_nLF.pvalue] = ttest2 (store(1).fft_nLF, store(2).fft_nLF); % statistical significance, between sup and tilt
    % % nHF psd
    stats(1).psd_nHF.median = nanmedian (store(1).psd_nHF) ; % median
    stats(2).psd_nHF.median = nanmedian (store(2).psd_nHF) ; 
    stats(1).psd_nHF.mean = nanmean (store(1).psd_nHF) ; % mean
    stats(2).psd_nHF.mean = nanmean (store(2).psd_nHF) ; 
    stats(1).psd_nHF.std = nanstd (store(1).psd_nHF) ;  % standard deviation
    stats(2).psd_nHF.std = nanstd (store(2).psd_nHF) ; 
    [~, stats(1).psd_nHF.pvalue] = ttest2 (store(1).psd_nHF, store(2).psd_nHF); % statistical significance, between sup and tilt
    % % nHF fft
    stats(1).fft_nHF.median = nanmedian (store(1).fft_nHF) ; % median
    stats(2).fft_nHF.median = nanmedian (store(2).fft_nHF) ; 
    stats(1).fft_nHF.mean = nanmean (store(1).fft_nHF) ; % mean
    stats(2).fft_nHF.mean = nanmean (store(2).fft_nHF) ; 
    stats(1).fft_nHF.std = nanstd (store(1).fft_nHF) ;  % standard deviation
    stats(2).fft_nHF.std = nanstd (store(2).fft_nHF) ; 
    [~, stats(1).fft_nHF.pvalue] = ttest2 (store(1).fft_nHF, store(2).fft_nHF); % statistical significance, between sup and tilt
    % % total power psd
    stats(1).psd_power.median = nanmedian (store(1).psd_power) ; % median
    stats(2).psd_power.median = nanmedian (store(2).psd_power) ; 
    stats(1).psd_power.mean = nanmean (store(1).psd_power) ; % mean
    stats(2).psd_power.mean = nanmean (store(2).psd_power) ; 
    stats(1).psd_power.std = nanstd (store(1).psd_power) ;  % standard deviation
    stats(2).psd_power.std = nanstd (store(2).psd_power) ; 
    [~, stats(1).psd_power.pvalue] = ttest2 (store(1).psd_power, store(2).psd_power); % statistical significance, between sup and tilt
    % % total power fft
    stats(1).fft_power.median = nanmedian (store(1).fft_power) ; % median
    stats(2).fft_power.median = nanmedian (store(2).fft_power) ; 
    stats(1).fft_power.mean = nanmean (store(1).fft_power) ; % mean
    stats(2).fft_power.mean = nanmean (store(2).fft_power) ; 
    stats(1).fft_power.std = nanstd (store(1).fft_power) ;  % standard deviation
    stats(2).fft_power.std = nanstd (store(2).fft_power) ; 
    [~, stats(1).fft_power.pvalue] = ttest2 (store(1).fft_power, store(2).fft_power); % statistical significance, between sup and tilt
    
%     % Sequence baroreflex
%     stats(1).BRS.median = median( store(1).SlopeAll ); % median
%     stats(2).BRS.median = median ( store(2).SlopeAll ); 
%     stats(1).BRS.mean = mean( store(1).SlopeAll ); % mean
%     stats(2).BRS.mean = mean ( store(2).SlopeAll ); 
%     stats(1).BRS.std = std (store(1).SlopeAll ) ; % standard deviation
%     stats(2).BRS.std = std (store(2).SlopeAll ) ; 
%     [~, stats(1).BRS.pvalue] = ttest2 (store(1).SlopeAll, store(2).SlopeAll) ; % statistical significance, between sup and tilt
%     
%     % Error of estimate
%     % % ascending sequence
%     stats(1).errorUp.median = nanmedian(store(1).errorUp); % median
%     stats(2).errorUp.median = nanmedian(store(2).errorUp);
%     stats(1).errorUp.mean = nanmean(store(1).errorUp); % mean
%     stats(2).errorUp.mean = nanmean(store(2).errorUp);
%     stats(1).errorUp.std = nanstd(store(1).errorUp); % standard deviation
%     stats(2).errorUp.std = nanstd(store(2).errorUp);
%     [~, stats(1).errorUp.pvalue] = ttest2 (store(1).errorUp, store(2).errorUp) ; % statistical significance, between sup and tilt
%     
%     % % descending sequence
%     stats(1).errorDn.median = nanmedian(store(1).errorDn); % median
%     stats(2).errorDn.median = nanmedian(store(2).errorDn);
%     stats(1).errorDn.mean = nanmean(store(1).errorDn); % mean
%     stats(2).errorDn.mean = nanmean(store(2).errorDn);
%     stats(1).errorDn.std = nanstd(store(1).errorDn); % standard deviation
%     stats(2).errorDn.std = nanstd(store(2).errorDn);
%     [~, stats(1).errorDn.pvalue] = ttest2 (store(1).errorDn, store(2).errorDn) ; % statistical significance, between sup and tilt
%     
%     
%     % Error of estimate without lag 0
%     % % ascending sequence
%     stats(1).errorUp_wo.median = nanmedian(store(1).errorUp_wo); % median
%     stats(2).errorUp_wo.median = nanmedian(store(2).errorUp_wo);
%     stats(1).errorUp_wo.mean = nanmean(store(1).errorUp_wo); % mean
%     stats(2).errorUp_wo.mean = nanmean(store(2).errorUp_wo);
%     stats(1).errorUp_wo.std = nanstd(store(1).errorUp_wo); % standard deviation
%     stats(2).errorUp_wo.std = nanstd(store(2).errorUp_wo);
%     [~, stats(1).errorUp_wo.pvalue] = ttest2 (store(1).errorUp_wo, store(2).errorUp_wo) ; % statistical significance, between sup and tilt
% %     
%     % % descending sequence
%     stats(1).errorDn_wo.median = nanmedian(store(1).errorDn_wo); % median
%     stats(2).errorDn_wo.median = nanmedian(store(2).errorDn_wo);
%     stats(1).errorDn_wo.mean = nanmean(store(1).errorDn_wo); % mean
%     stats(2).errorDn_wo.mean = nanmean(store(2).errorDn_wo);
%     stats(1).errorDn_wo.std = nanstd(store(1).errorDn_wo); % standard deviation
%     stats(2).errorDn_wo.std = nanstd(store(2).errorDn_wo);
%     [~, stats(1).errorDn_wo.pvalue] = ttest2 (store(1).errorDn_wo, store(2).errorDn_wo) ; % statistical significance, between sup and tilt
%     
%     
%     % Summed error of estimate
%     % % ascending sequence
%     stats(1).errorSumUp.median = nanmedian(store(1).errorSumUp); % median
%     stats(2).errorSumUp.median = nanmedian(store(2).errorSumUp);
%     stats(1).errorSumUp.mean = nanmean(store(1).errorSumUp); % mean
%     stats(2).errorSumUp.mean = nanmean(store(2).errorSumUp);
%     stats(1).errorSumUp.std = nanstd(store(1).errorSumUp); % standard deviation
%     stats(2).errorSumUp.std = nanstd(store(2).errorSumUp);
%     [~, stats(1).errorSumUp.pvalue] = ttest2 (store(1).errorSumUp, store(2).errorSumUp) ; % statistical significance, between sup and tilt
%     % % descending sequence
%     stats(1).errorSumDn.median = nanmedian(store(1).errorSumDn); % median
%     stats(2).errorSumDn.median = nanmedian(store(2).errorSumDn);
%     stats(1).errorSumDn.mean = nanmean(store(1).errorSumDn); % mean
%     stats(2).errorSumDn.mean = nanmean(store(2).errorSumDn);
%     stats(1).errorSumDn.std = nanstd(store(1).errorSumDn); % standard deviation
%     stats(2).errorSumDn.std = nanstd(store(2).errorSumDn);
%     [~, stats(1).errorSumDn.pvalue] = ttest2 (store(1).errorSumDn, store(2).errorSumDn) ; % statistical significance, between sup and tilt
%     
    % Slope of sequence 
    % % ascending sequence
    
    stats(1).SlopeUp.median = nanmedian( store(1).SlopeUp ); % median
    stats(2).SlopeUp.median = nanmedian( store(2).SlopeUp );
    stats(1).SlopeUp.mean = nanmean( store(1).SlopeUp ); % mean
    stats(2).SlopeUp.mean = nanmean( store(2).SlopeUp );
    stats(1).SlopeUp.std = nanstd( store(1).SlopeUp ); % standard deviation
    stats(2).SlopeUp.std = nanstd( store(2).SlopeUp );
    % % descending sequence
    stats(1).SlopeDn.median = nanmedian( store(1).SlopeDn ); % median
    stats(2).SlopeDn.median = nanmedian( store(2).SlopeDn );
    stats(1).SlopeDn.mean = nanmean( store(1).SlopeDn ); % mean
    stats(2).SlopeDn.mean = nanmean( store(2).SlopeDn );
    stats(1).SlopeDn.std = nanstd( store(1).SlopeDn ); % standard deviation
    stats(2).SlopeDn.std = nanstd( store(2).SlopeDn );
   
    [~, stats(1).SlopeUp.pvalue] = ttest2( store(1).SlopeUp, store(2).SlopeUp ); % statistical significance, between sup and tilt
    [~, stats(1).SlopeDn.pvalue] = ttest2( store(1).SlopeDn, store(2).SlopeDn );
    
    stats(1).SlopeUp.pvalue_W = ranksum( store(1).SlopeUp, store(2).SlopeUp ); % statistical significance, between sup and tilt
    stats(1).SlopeDn.pvalue_W = ranksum( store(1).SlopeDn, store(2).SlopeDn );
    
    stats(1).SlopeUp.n = length( store(1).SlopeUp ); 
    stats(1).SlopeDn.n = length( store(1).SlopeDn ); 
    stats(2).SlopeUp.n = length( store(2).SlopeUp );
    stats(2).SlopeDn.n = length( store(2).SlopeDn );
    
    % Slope of sequence with beat 1, regression method
    % % ascending sequence
    stats(1).SlopeUpC.median = nanmedian( store(1).SlopeUpC ); % median
    stats(2).SlopeUpC.median = nanmedian( store(2).SlopeUpC );
    stats(1).SlopeUpC.mean = nanmean( store(1).SlopeUpC ); % mean
    stats(2).SlopeUpC.mean = nanmean( store(2).SlopeUpC );
    stats(1).SlopeUpC.std = nanstd( store(1).SlopeUpC ); % standard deviation
    stats(2).SlopeUpC.std = nanstd( store(2).SlopeUpC );
    % % descending sequence
    stats(1).SlopeDnC.median = nanmedian( store(1).SlopeDnC ); % median
    stats(2).SlopeDnC.median = nanmedian( store(2).SlopeDnC );
    stats(1).SlopeDnC.mean = nanmean( store(1).SlopeDnC ); % mean
    stats(2).SlopeDnC.mean = nanmean( store(2).SlopeDnC );
    stats(1).SlopeDnC.std = nanstd( store(1).SlopeDnC ); % standard deviation
    stats(2).SlopeDnC.std = nanstd( store(2).SlopeDnC );
   
    [~, stats(1).SlopeUpC.pvalue] = ttest2( store(1).SlopeUpC, store(2).SlopeUpC ); % statistical significance, between sup and tilt
    [~, stats(1).SlopeDnC.pvalue] = ttest2( store(1).SlopeDnC, store(2).SlopeDnC );
    
    stats(1).SlopeUpC.pvalue_W = ranksum( store(1).SlopeUpC, store(2).SlopeUpC ); % statistical significance, between sup and tilt
    stats(1).SlopeDnC.pvalue_W = ranksum( store(1).SlopeDnC, store(2).SlopeDnC );
    
    stats(1).SlopeUpC.n = length( store(1).SlopeUpC ); 
    stats(1).SlopeDnC.n = length( store(1).SlopeDnC ); 
    stats(2).SlopeUpC.n = length( store(2).SlopeUpC );
    stats(2).SlopeDnC.n = length( store(2).SlopeDnC );
    
    % Slope of sequence with beat 1
   % % ascending sequence
    stats(1).ellipseSlopeUpC.median = nanmedian( store(1).ellipseSlopeUpC ); % median
    stats(2).ellipseSlopeUpC.median = nanmedian( store(2).ellipseSlopeUpC );
    stats(1).ellipseSlopeUpC.mean = nanmean( store(1).ellipseSlopeUpC ); % mean
    stats(2).ellipseSlopeUpC.mean = nanmean( store(2).ellipseSlopeUpC );
    stats(1).ellipseSlopeUpC.std = nanstd( store(1).ellipseSlopeUpC ); % standard deviation
    stats(2).ellipseSlopeUpC.std = nanstd( store(2).ellipseSlopeUpC );
    % % descending sequence
    stats(1).ellipseSlopeDnC.median = nanmedian( store(1).ellipseSlopeDnC ); % median
    stats(2).ellipseSlopeDnC.median = nanmedian( store(2).ellipseSlopeDnC );
    stats(1).ellipseSlopeDnC.mean = nanmean( store(1).ellipseSlopeDnC ); % mean
    stats(2).ellipseSlopeDnC.mean = nanmean( store(2).ellipseSlopeDnC );
    stats(1).ellipseSlopeDnC.std = nanstd( store(1).ellipseSlopeDnC ); % standard deviation
    stats(2).ellipseSlopeDnC.std = nanstd( store(2).ellipseSlopeDnC );
   
    [~, stats(1).ellipseSlopeUpC.pvalue] = ttest2( store(1).ellipseSlopeUpC, store(2).ellipseSlopeUpC ); % statistical significance, between sup and tilt
    [~, stats(1).ellipseSlopeDnC.pvalue] = ttest2( store(1).ellipseSlopeDnC, store(2).ellipseSlopeDnC );
    
    stats(1).ellipseSlopeUpC.pvalue_W = ranksum( store(1).ellipseSlopeUpC, store(2).ellipseSlopeUpC ); % statistical significance, between sup and tilt
    stats(1).ellipseSlopeDnC.pvalue_W = ranksum( store(1).ellipseSlopeDnC, store(2).ellipseSlopeDnC );
    
    stats(1).ellipseSlopeUpC.n = length( store(1).ellipseSlopeUpC ); 
    stats(1).ellipseSlopeDnC.n = length( store(1).ellipseSlopeDnC ); 
    stats(2).ellipseSlopeUpC.n = length( store(2).ellipseSlopeUpC );
    stats(2).ellipseSlopeDnC.n = length( store(2).ellipseSlopeDnC );
    
    % Slope of sequence forn ellipse method
    % % ascending sequence
    stats(1).ellipseSlopeUp.median = nanmedian( store(1).ellipseSlopeUp ); % median
    stats(2).ellipseSlopeUp.median = nanmedian( store(2).ellipseSlopeUp );
    stats(1).ellipseSlopeUp.mean = nanmean( store(1).ellipseSlopeUp ); % mean
    stats(2).ellipseSlopeUp.mean = nanmean( store(2).ellipseSlopeUp );
    stats(1).ellipseSlopeUp.std = nanstd( store(1).ellipseSlopeUp ); % standard deviation
    stats(2).ellipseSlopeUp.std = nanstd( store(2).ellipseSlopeUp );
    % % descending sequence
    stats(1).ellipseSlopeDn.median = nanmedian( store(1).ellipseSlopeDn ); % median
    stats(2).ellipseSlopeDn.median = nanmedian( store(2).ellipseSlopeDn );
    stats(1).ellipseSlopeDn.mean = nanmean( store(1).ellipseSlopeDn ); % mean
    stats(2).ellipseSlopeDn.mean = nanmean( store(2).ellipseSlopeDn );
    stats(1).ellipseSlopeDn.std = nanstd( store(1).ellipseSlopeDn ); % standard deviation
    stats(2).ellipseSlopeDn.std = nanstd( store(2).ellipseSlopeDn );
   
    [~, stats(1).ellipseSlopeUp.pvalue] = ttest2( store(1).ellipseSlopeUp, store(2).ellipseSlopeUp ); % statistical significance, between sup and tilt
    [~, stats(1).ellipseSlopeDn.pvalue] = ttest2( store(1).ellipseSlopeDn, store(2).ellipseSlopeDn );
    
    stats(1).ellipseSlopeUp.pvalue_W = ranksum( store(1).ellipseSlopeUp, store(2).ellipseSlopeUp ); % statistical significance, between sup and tilt
    stats(1).ellipseSlopeDn.pvalue_W = ranksum( store(1).ellipseSlopeDn, store(2).ellipseSlopeDn );
    
    stats(1).ellipseSlopeUp.n = length( store(1).ellipseSlopeUp ); 
    stats(1).ellipseSlopeDn.n = length( store(1).ellipseSlopeDn ); 
    stats(2).ellipseSlopeUp.n = length( store(2).ellipseSlopeUp );
    stats(2).ellipseSlopeDn.n = length( store(2).ellipseSlopeDn );
    
%     % Slope of sequence within cycle 
%     % % ascending sequence
%     stats(1).SlopeUp_wo.median = nanmedian(store(1).SlopeUp_wo); % median
%     stats(2).SlopeUp_wo.median = nanmedian(store(2).SlopeUp_wo);
%     stats(1).SlopeUp_wo.mean = nanmean(store(1).SlopeDn); % mean
%     stats(2).SlopeUp_wo.mean = nanmean(store(2).SlopeUp_wo);
%     stats(1).SlopeUp_wo.std = nanstd(store(1).SlopeUp_wo); % standard deviation
%     stats(2).SlopeUp_wo.std = nanstd(store(2).SlopeUp_wo);
%     % % descending sequence
%     stats(1).SlopeDn_wo.median = nanmedian(store(1).SlopeDn_wo); % median
%     stats(2).SlopeDn_wo.median = nanmedian(store(2).SlopeDn_wo);
%     stats(1).SlopeDn_wo.mean = nanmean(store(1).SlopeDn_wo); % mean
%     stats(2).SlopeDn_wo.mean = nanmean(store(2).SlopeDn_wo);
%     stats(1).SlopeDn_wo.std = nanstd(store(1).SlopeDn_wo); % standard deviation
%     stats(2).SlopeDn_wo.std = nanstd(store(2).SlopeDn_wo);
%     
%     [~, stats(1).SlopeUp_wo.pvalue] = ttest2(store(1).SlopeUp_wo, store(2).SlopeUp_wo); % statistical significance, between sup and tilt
%     [~, stats(1).SlopeDn_wo.pvalue] = ttest2(store(1).SlopeDn_wo, store(2).SlopeDn_wo);
%     
    % Error of estimate for sequences within cycle
%     % % ascending sequence
%     stats(1).errorUpC(1).median = nanmedian(store(1).errorUpC); % median
%     stats(2).errorUpC(2).median = nanmedian(store(2).errorUpC);
%     stats(1).errorUpC(1).mean = nanmean(store(1).errorUpC); % mean
%     stats(2).errorUpC(2).mean = nanmean(store(2).errorUpC);
%     stats(1).errorUpC(1).std = nanstd(store(1).errorUpC); % standard deviation  
%     stats(2).errorUpC(2).std = nanstd(store(2).errorUpC);
%     % % descending sequence
%     stats(1).errorDnC.median = nanmedian(store(1).errorDnC); % median
%     stats(2).errorDnC.median = nanmedian(store(2).errorDnC);
%     stats(1).errorDnC.mean = nanmean(store(1).errorDnC); % mean
%     stats(2).errorDnC.mean = nanmean(store(2).errorDnC);
%     stats(1).errorDnC.std = nanstd(store(1).errorDnC); % standard deviation
%     stats(2).errorDnC.std = nanstd(store(2).errorDnC);
%     
%     [~, stats(1).errorUpC.pvalue] = ttest2(store(1).errorUpC, store(2).errorUpC); % statistical significance, between sup and tilt
%     [~, stats(1).errorDnC.pvalue] = ttest2(store(1).errorDnC, store(2).errorDnC);
%     
%     % Summed error of estimate for sequences within cycle
%     % % ascending sequence
%     stats(1).errorSumUpC.median = nanmedian(store(1).errorSumUpC); % median
%     stats(2).errorSumUpC.median = nanmedian(store(2).errorSumUpC);
%     stats(1).errorSumUpC.mean = nanmean(store(1).errorSumUpC); % mean
%     stats(2).errorSumUpC.mean = nanmean(store(2).errorSumUpC);
%     stats(1).errorSumUpC.std = nanstd(store(1).errorSumUpC); % standard deviation
%     stats(2).errorSumUpC.std = nanstd(store(2).errorSumUpC);
%     % % descending sequence
%     stats(1).errorSumDnC.median = nanmedian(store(1).errorSumDnC); % median
%     stats(2).errorSumDnC.median = nanmedian(store(2).errorSumDnC);
%     stats(1).errorSumDnC.mean = nanmean(store(1).errorSumDnC); % mean
%     stats(2).errorSumDnC.mean = nanmean(store(2).errorSumDnC);
%     stats(1).errorSumDnC.std = nanstd(store(1).errorSumDnC); % standard deviation
%     stats(2).errorSumDnC.std = nanstd(store(2).errorSumDnC);
%     
%     [~, stats(1).errorSumUpC.pvalue] = ttest2(store(1).errorSumUpC, store(2).errorSumUpC); % statistical significance, between sup and tilt
%     [~, stats(1).errorSumDnC.pvalue] = ttest2(store(1).errorSumDnC, store(2).errorSumDnC);
%     
%     % Slope of cycle for regression method
%     stats(1).RegSlope.median = nanmedian(store(1).RegSlope); % median
%     stats(2).RegSlope.median = nanmedian(store(2).RegSlope);
%     stats(1).RegSlope.mean = nanmean(store(1).RegSlope); % mean
%     stats(2).RegSlope.mean = nanmean(store(2).RegSlope);
%     stats(1).RegSlope.std = nanstd(store(1).RegSlope); % standard deviation 
%     stats(2).RegSlope.std = nanstd(store(2).RegSlope);
%     [~,  stats(1).RegSlope.pvalue] = ttest2(store(1).RegSlope, store(2).RegSlope);
%     
    % Slope of cycle for ellipse method
    stats(1).EllipseSlope.median = nanmedian( store(1).EllipseSlope ); % median
    stats(2).EllipseSlope.median = nanmedian(store(2).EllipseSlope); 
    stats(1).EllipseSlope.mean = nanmean( store(1).EllipseSlope ); % mean
    stats(2).EllipseSlope.mean = nanmean(store(2).EllipseSlope);
    stats(1).EllipseSlope.std = nanstd( store(1).EllipseSlope ); % standard deviation
    stats(2).EllipseSlope.std = nanstd(store(2).EllipseSlope);
    stats(1).EllipseSlope.Q1 = quantile(store(1).EllipseSlope, 0.25); % 25th quartile
    stats(2).EllipseSlope.Q1 = quantile(store(2).EllipseSlope, 0.25);
    stats(1).EllipseSlope.Q2 = quantile(store(1).EllipseSlope, 0.75); % 75th quartile
    stats(2).EllipseSlope.Q2 = quantile(store(2).EllipseSlope, 0.75);
    
    [~,  stats(1).EllipseSlope.pvalue] = ttest2(store(1).EllipseSlope, store(2).EllipseSlope);
    stats(1).EllipseSlope.pvalue_W = ranksum(store(1).EllipseSlope, store(2).EllipseSlope);
%     
%     % Length of axes for regression method
%     % % normalized major axis length for ellipse method 
%     stats(1).RegL.median = nanmedian(store(1).RegL); % median
%     stats(2).RegL.median = nanmedian(store(2).RegL);
%     stats(1).RegL.mean = nanmean(store(1).RegL); % mean
%     stats(2).RegL.mean = nanmean(store(2).RegL);
%     stats(1).RegL.std = nanstd(store(1).RegL); % standard deviation
%     stats(2).RegL.std = nanstd(store(2).RegL);
%     [~,  stats(1).RegL.pvalue] = ttest2(store(1).RegL, store(2).RegL);
%     % % normalized major axis length for ellipse method 
%     stats(1).RegL_norm.median = nanmedian(store(1).RegL_norm); % median
%     stats(2).RegL_norm.median = nanmedian(store(2).RegL_norm);
%     stats(1).RegL_norm.mean = nanmean(store(1).RegL_norm); % mean
%     stats(2).RegL_norm.mean = nanmean(store(2).RegL_norm);
%     stats(1).RegL_norm.std = nanstd(store(1).RegL_norm); % standard deviation 
%     stats(2).RegL_norm.std = nanstd(store(2).RegL_norm);
%     [~,  stats(1).RegL_norm.pvalue] = ttest2(store(1).RegL_norm, store(2).RegL_norm);
%     % % minor axis length for ellipse method 
%     stats(1).Regl.median = nanmedian(store(1).Regl); % median
%     stats(2).Regl.median = nanmedian(store(2).Regl);
%     stats(1).Regl.mean = nanmean(store(1).Regl); % mean
%     stats(2).Regl.mean = nanmean(store(2).Regl);
%     stats(1).Regl.std = nanstd(store(1).Regl); % standard deviation
%     stats(2).Regl.std = nanstd(store(2).Regl);
%     [~,  stats(1).Regl.pvalue] = ttest2(store(1).Regl, store(2).Regl);
%     % % normalized minor axis length for ellipse method 
%     stats(1).Regl_norm.median = nanmedian(store(1).Regl_norm); % median
%     stats(2).Regl_norm.median = nanmedian(store(2).Regl_norm);
%     stats(1).Regl_norm.mean = nanmean(store(1).Regl_norm); % mean
%     stats(2).Regl_norm.mean = nanmean(store(2).Regl_norm);
%     stats(1).Regl_norm.std = nanstd(store(1).Regl_norm); % standard deviation 
%     stats(2).Regl_norm.std = nanstd(store(2).Regl_norm);
%     [~,  stats(1).Regl_norm.pvalue] = ttest2(store(1).Regl_norm, store(2).Regl_norm);
%     
    % Length of axes for ellipse method
    % % major axis length for ellipse method
    stats(1).EllipseL.median = nanmedian(store(1).EllipseL); % median
    stats(2).EllipseL.median = nanmedian(store(2).EllipseL);
    stats(1).EllipseL.mean = nanmean(store(1).EllipseL); % mean
    stats(2).EllipseL.mean = nanmean(store(2).EllipseL);
    stats(1).EllipseL.std = nanstd(store(1).EllipseL); % standard deviation
    stats(2).EllipseL.std = nanstd(store(2).EllipseL);
    [~,  stats(1).EllipseL.pvalue] = ttest2(store(1).EllipseL, store(2).EllipseL);
    % % normalized major axis length for ellipse method 
%     stats(1).EllipseL_norm.median = nanmedian(store(1).EllipseL_norm); % median
%     stats(2).EllipseL_norm.median = nanmedian(store(2).EllipseL_norm);
%     stats(1).EllipseL_norm.mean = nanmean(store(1).EllipseL_norm); % mean
%     stats(2).EllipseL_norm.mean = nanmean(store(2).EllipseL_norm);
%     stats(1).EllipseL_norm.std = nanstd(store(1).EllipseL_norm); % standard deviation
%     stats(2).EllipseL_norm.std = nanstd(store(2).EllipseL_norm);
%     [~,  stats(1).EllipseL_norm.pvalue] = ttest2(store(1).EllipseL_norm, store(2).EllipseL_norm);
%     % % major axis correct length for ellipse method
%     stats(1).EllipseL_e.median = nanmedian(store(1).EllipseL_e); % median
%     stats(2).EllipseL_e.median = nanmedian(store(2).EllipseL_e);
%     stats(1).EllipseL_e.mean = nanmean(store(1).EllipseL_e); % mean
%     stats(2).EllipseL_e.mean = nanmean(store(2).EllipseL_e);
%     stats(1).EllipseL_e.std = nanstd(store(1).EllipseL_e); % standard deviation
%     stats(2).EllipseL_e.std = nanstd(store(2).EllipseL_e);
%     [~,  stats(1).EllipseL_e.pvalue] = ttest2(store(1).EllipseL_e, store(2).EllipseL_e);
    % % minor axis length for ellipse method
    stats(1).Ellipsel.median = nanmedian(store(1).Ellipsel); % median
    stats(2).Ellipsel.median = nanmedian(store(2).Ellipsel);
    stats(1).Ellipsel.mean = nanmean(store(1).Ellipsel); % mean
    stats(2).Ellipsel.mean = nanmean(store(2).Ellipsel);
    stats(1).Ellipsel.std = nanstd(store(1).Ellipsel); % standard deviation
    stats(2).Ellipsel.std = nanstd(store(2).Ellipsel);
    [~,  stats(1).Ellipsel.pvalue] = ttest2(store(1).Ellipsel, store(2).Ellipsel);
    % % normalized minor axis length for ellipse method
%     stats(1).Ellipsel_norm.median = nanmedian(store(1).Ellipsel_norm); % median
%     stats(2).Ellipsel_norm.median = nanmedian(store(2).Ellipsel_norm);
%     stats(1).Ellipsel_norm.mean = nanmean(store(1).Ellipsel_norm); % mean
%     stats(2).Ellipsel_norm.mean = nanmean(store(2).Ellipsel_norm);
%     stats(1).Ellipsel_norm.std = nanstd(store(1).Ellipsel_norm); % standard deviation
%     stats(2).Ellipsel_norm.std = nanstd(store(2).Ellipsel_norm);
%     [~,  stats(1).Ellipsel_norm.pvalue] = ttest2(store(1).Ellipsel_norm, store(2).Ellipsel_norm);
    
    % Area of ellipse for ellipse method
    stats(1).ellipseArea.median = nanmedian(store(1).ellipseArea); % median
    stats(2).ellipseArea.median = nanmedian(store(2).ellipseArea); 
    stats(1).ellipseArea.mean = nanmean(store(1).ellipseArea); % mean
    stats(2).ellipseArea.mean = nanmean(store(2).ellipseArea); 
    stats(1).ellipseArea.std = nanstd(store(1).ellipseArea); % standard deviation
    stats(2).ellipseArea.std = nanstd(store(2).ellipseArea); 
    stats(1).ellipseArea.Q1 = quantile(store(1).ellipseArea, 0.25); % standard deviation
    stats(2).ellipseArea.Q1 = quantile(store(2).ellipseArea, 0.25); 
    stats(1).ellipseArea.Q2 = quantile(store(1).ellipseArea, 0.75); % standard deviation
    stats(2).ellipseArea.Q2 = quantile(store(2).ellipseArea, 0.75); 
    [~,  stats(1).ellipseArea.pvalue] = ttest2(store(1).ellipseArea, store(2).ellipseArea);
%     
%     % Projection angle of ellipse 
%     stats(1).ProjAngle.median = nanmedian(store(1).ProjAngle); % median
%     stats(2).ProjAngle.median = nanmedian(store(2).ProjAngle); 
%     stats(1).ProjAngle.mean = nanmean(store(1).ProjAngle); % mean
%     stats(2).ProjAngle.mean = nanmean(store(2).ProjAngle); 
%     stats(1).ProjAngle.std = nanstd(store(1).ProjAngle); % standard deviation
%     stats(2).ProjAngle.std = nanstd(store(2).ProjAngle); 
%     stats(1).ProjAngle.Q1 = quantile(store(1).ProjAngle, 0.25); % standard deviation
%     stats(2).ProjAngle.Q1 = quantile(store(2).ProjAngle, 0.25); 
%     stats(1).ProjAngle.Q2 = quantile(store(1).ProjAngle, 0.75); % standard deviation
%     stats(2).ProjAngle.Q2 = quantile(store(2).ProjAngle, 0.75); 
%     [~,  stats(1).ProjAngle.pvalue] = ttest2(store(1).ProjAngle, store(2).ProjAngle);
   
    % Hysteresis magnitude of ellipse
    stats(1).magnitudeH.median = nanmedian(store(1).magnitudeH); % median
    stats(2).magnitudeH.median = nanmedian(store(2).magnitudeH); 
    stats(1).magnitudeH.mean = nanmean(store(1).magnitudeH); % mean
    stats(2).magnitudeH.mean = nanmean(store(2).magnitudeH); 
    stats(1).magnitudeH.std = nanstd(store(1).magnitudeH); % standard deviation
    stats(2).magnitudeH.std = nanstd(store(2).magnitudeH); 
    stats(1).magnitudeH.Q1 = quantile(store(1).magnitudeH, 0.25); % standard deviation
    stats(2).magnitudeH.Q1 = quantile(store(2).magnitudeH, 0.25); 
    stats(1).magnitudeH.Q2 = quantile(store(1).magnitudeH, 0.75); % standard deviation
    stats(2).magnitudeH.Q2 = quantile(store(2).magnitudeH, 0.75);
    [~,  stats(1).magnitudeH.pvalue] = ttest2(store(1).magnitudeH, store(2).magnitudeH);
    
%     % Beat to beat analysis 
%     % % SPV
%     stats(1).beatSpUp.std = nanstd(store(1).beatSpUp);
%     stats(2).beatSpUp.std = nanstd(store(2).beatSpUp);
%     stats(1).beatSpDn.std = nanstd(store(1).beatSpDn);
%     stats(2).beatSpDn.std = nanstd(store(2).beatSpDn);
%     [~, stats(1).beatSpUp.pvalue] = ttest2(store(1).beatSpUp, store(2).beatSpUp); % statistical significance, between sup and tilt
%     [~, stats(1).beatSpDn.pvalue] = ttest2(store(1).beatSpDn, store(2).beatSpDn); % statistical significance, between sup and tilt
%     % % HRV
%     stats(1).beatRRUp.std = nanstd(store(1).beatRRUp);
%     stats(2).beatRRUp.std = nanstd(store(2).beatRRUp);
%     stats(1).beatRRDn.std = nanstd(store(1).beatRRDn);
%     stats(2).beatRRDn.std = nanstd(store(2).beatRRDn);
%     [~, stats(1).beatRRUp.pvalue] = ttest2(store(1).beatRRUp, store(2).beatRRUp); % statistical significance, between sup and tilt
%     [~, stats(1).beatRRDn.pvalue] = ttest2(store(1).beatRRDn, store(2).beatRRDn); % statistical significance, between sup and tilt
%     
%     % Lag analysis 
%     [~, stats(1).lag1.pvalue] = ttest2(store(1).lag1, store(2).lag1); % statistical significance, between sup and tilt
%     [~, stats(1).lag2.pvalue] = ttest2(store(1).lag2, store(2).lag2); % statistical significance, between sup and tilt
%     
%     
%     % Ellipse method for sequences
%     % % minor axis Up sequence
%     stats(1).UpSeqEllipsel.median = nanmedian(store(1).UpSeqEllipsel); % median
%     stats(2).UpSeqEllipsel.median = nanmedian(store(2).UpSeqEllipsel);
%     stats(1).UpSeqEllipsel.mean = nanmean(store(1).UpSeqEllipsel); % mean
%     stats(2).UpSeqEllipsel.mean = nanmean(store(2).UpSeqEllipsel);
%     stats(1).UpSeqEllipsel.std = nanstd(store(1).UpSeqEllipsel); % standard deviation 
%     stats(2).UpSeqEllipsel.std = nanstd(store(2).UpSeqEllipsel);
%     [~, stats(1).UpSeqEllipsel.pvalue] = ttest2(store(1).UpSeqEllipsel, store(2).UpSeqEllipsel); % statistical significance, between sup and tilt
%     % % minor axis down sequence
%     stats(1).DnSeqEllipsel.median = nanmedian(store(1).DnSeqEllipsel); % median
%     stats(2).DnSeqEllipsel.median = nanmedian(store(2).DnSeqEllipsel);
%     stats(1).DnSeqEllipsel.mean = nanmean(store(1).DnSeqEllipsel); % mean
%     stats(2).DnSeqEllipsel.mean = nanmean(store(2).DnSeqEllipsel);
%     stats(1).DnSeqEllipsel.std = nanstd(store(1).DnSeqEllipsel); % standard deviation
%     stats(2).DnSeqEllipsel.std = nanstd(store(2).DnSeqEllipsel);
%     [~, stats(1).DnSeqEllipsel.pvalue] = ttest2(store(1).DnSeqEllipsel, store(2).DnSeqEllipsel); % statistical significance, between sup and tilt
%     % % viscosity coefficient of arteries, up sequence
%     stats(1).UpG.median = nanmedian(store(1).UpG); % median
%     stats(2).UpG.median = nanmedian(store(2).UpG);
%     stats(1).UpG.mean = nanmean(store(1).UpG); % mean
%     stats(2).UpG.mean = nanmean(store(2).UpG);
%     stats(1).UpG.std = nanstd(store(1).UpG); % standard deviation 
%     stats(2).UpG.std = nanstd(store(2).UpG);
%     [~, stats(1).UpG.pvalue] = ttest2(store(1).UpG, store(2).UpG); % statistical significance, between sup and tilt
%     % % viscosity coefficient of arteries, down sequence
%     stats(1).DnG.median = nanmedian(store(1).DnG); % median
%     stats(2).DnG.median = nanmedian(store(2).DnG);
%     stats(1).DnG.mean = nanmean(store(1).DnG); % mean
%     stats(2).DnG.mean = nanmean(store(2).DnG);
%     stats(1).DnG.std = nanstd(store(1).DnG); % standard deviation
%     stats(2).DnG.std = nanstd(store(2).DnG);
%     [~, stats(1).DnG.pvalue] = ttest2(store(1).DnG, store(2).DnG); % statistical significance, between sup and tilt
%     
    %deltaBRS
    stats(1).deltaBRS.median = nanmedian(store(1).deltaBRS); % median
    stats(2).deltaBRS.median = nanmedian(store(2).deltaBRS);
    stats(1).deltaBRS.mean = nanmean(store(1).deltaBRS); % mean
    stats(2).deltaBRS.mean = nanmean(store(2).deltaBRS);
    stats(1).deltaBRS.std = nanstd(store(1).deltaBRS); % standard deviation
    stats(2).deltaBRS.std = nanstd(store(2).deltaBRS);
    [~, stats(1).deltaBRS.pvalue] = ttest2(store(1).deltaBRS, store(2).deltaBRS); % statistical significance, between sup and tilt
    %setpoint
    stats(1).setpoint.median = nanmedian(store(1).setpoint); % median
    stats(2).setpoint.median = nanmedian(store(2).setpoint);
    stats(1).setpoint.mean = nanmean(store(1).setpoint); % mean
    stats(2).setpoint.mean = nanmean(store(2).setpoint);
    stats(1).setpoint.std = nanstd(store(1).setpoint); % standard deviation
    stats(2).setpoint.std = nanstd(store(2).setpoint);
    [~, stats(1).setpoint.pvalue] = ttest2(store(1).setpoint, store(2).setpoint); % statistical significance, between sup and tilt
    
       
end 
