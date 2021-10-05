function [BRSPSD, BRSFFT] = ...
    BP_HRV_Frequency_Domain(RpLoc, rrInt, SpLoc, Sp, position, debug, dataNum)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculates HRV, SPV power spectra and BRS values in the frequency domain
% using both pwelch and fft
%
% INPUT:
% rrInt            - vector of RR in ms
% RpLoc            - vector of R peaks locations in ms
% SpLoc            - vector of systolic pressure peaks locations in ms
% Sp               - vector of systolic pressure values in mmHg
% position         - supine or tilt, for plotting
% debug            - logical value, 0 no plot / 1 plot
% dataNum          - subject ID, for plotting
%
% RETURN VALUES:
%                    density of RR Tachogram in ms²
% BRSPSD            -  values using pwelch. Struct with fields:
%  BRSPSD.psd_spectrum  - vector of HRV power spectral density (psd) in
%  ms²/Hz
%  BRSPSD.psd_f         - vector of frequencies at which psd was calculated
%  in Hz
%  BRSPSD.HrvLf         - spectral power in the LF range in ms²
%  BRSPSD.HrvHf         - spectral power in the HF range in ms²
%  BRSPSD.total_power   - total spectral power (VLF + LF + HF) in ms²
%  BRSPSD.HrvLf_nu      - normalized spectral power in the LF range
%  BRSPSD.HrvHf_nu      - normalized spectral power in the HF range
%  BRSPSD.HrvSv         - LF/HF ratio, sympathovagal balance
% BRSFFT            -  values using pwelch. Struct with same fields as BRSPSD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% frequency range
HRV_veryLF_low   = 0.01;
HRV_veryLF_high   = 0.04;
HRV_LF_low   = 0.04;
HRV_LF_high  = 0.15;
HRV_HF_low   = 0.15;
HRV_HF_high  = 0.4;

debug = 0; % change here for 0 plot/ 1 no plot
f_int = 4 ; % frequency of interpolation in Hz

beatpos = RpLoc - RpLoc(1); % in order to start at time 0 
beatpos = beatpos./1000 ; % from ms to s

t_rrInt =beatpos(1):1/f_int:beatpos(end-1);
%resampling at 4 Hz
rrIntRes = interp1(beatpos(1:end-1), rrInt, t_rrInt);

if debug == 1 % Plot of equidistant RR time series (after interpolation)
    figure;
    stem(beatpos(1:end-1), rrInt, 'r');
    hold on;
    stem(t_rrInt, rrIntRes, 'g*');
    hold off
    xlabel("Time (s)");
    ylabel("RR-interval (ms)");
    title(['HRV ' position '  position  No:' num2str(dataNum)])
    legend('Original HRV','Interpolated HRV')
end

% calculate HRV power spectral density using psd
% use of a hamming window of length 512 with 50% overlap (207)
[RR_FFT, f_FFT] = pwelch((rrIntRes(1:end-10) - nanmean(rrIntRes)), hamming(512), 207, 1024, f_int);

BRSPSD.psd_spectrum = RR_FFT;
BRSPSD.psd_f = f_FFT;
BRSPSD.HrvLf  =  sum(RR_FFT((f_FFT <= HRV_LF_high)  & (f_FFT >= HRV_LF_low))) * f_int/1024    ;
BRSPSD.HrvHf  =  sum(RR_FFT((f_FFT <= HRV_HF_high)  & (f_FFT >= HRV_HF_low))) * f_int/1024   ;
nu = (sum(RR_FFT((f_FFT <= HRV_HF_high)  & (f_FFT >= HRV_veryLF_low))) - sum(RR_FFT((f_FFT <= HRV_veryLF_high)  & (f_FFT >= HRV_veryLF_low))) ) * f_int/1024   ;
BRSPSD.total_power = nu;
BRSPSD.HrvLf_nu = BRSPSD.HrvLf / nu;
BRSPSD.HrvHf_nu = BRSPSD.HrvHf / nu;
BRSPSD.HrvSv  = BRSPSD.HrvLf_nu / BRSPSD.HrvHf_nu;

% calculate HRV power spectral density using fft
L =  length(rrIntRes)-10;
Y = fft(rrIntRes(1:end-10) - nanmean(rrIntRes) );
Y_FFT = abs( Y(1:L/2 + 1)./ L );
Y_FFT(2:end-1) = 2 .* Y_FFT(2:end-1);
Y_FFT = Y_FFT .* Y_FFT ;
F_FFT = (0:L/2) * f_int/L;

BRSFFT.fft_spectrum = Y_FFT;
BRSFFT.fft_f = F_FFT;
BRSFFT.HrvLf  =  sum(Y_FFT((F_FFT <= HRV_LF_high)  & (F_FFT >= HRV_LF_low)))     ;
BRSFFT.HrvHf  =  sum(Y_FFT((F_FFT <= HRV_HF_high)  & (F_FFT >= HRV_HF_low)))    ;
nu = (sum(Y_FFT((F_FFT <= HRV_HF_high)  & (F_FFT >= HRV_veryLF_low))) - sum(Y_FFT((F_FFT <= HRV_veryLF_high)  & (F_FFT >= HRV_veryLF_low))) )    ;
BRSFFT.total_power = nu;
BRSFFT.HrvLf_nu = BRSFFT.HrvLf / nu;
BRSFFT.HrvHf_nu = BRSFFT.HrvHf / nu;
BRSFFT.HrvSv  = BRSFFT.HrvLf_nu / BRSFFT.HrvHf_nu;

% Ps 
pspos = SpLoc - SpLoc(1); % to start at time 0
pspos = pspos./1000 ; % from ms to s

t_ps_int =pspos(1):1/f_int:pspos(end);
%resampling with 4 Hz
ps_int = interp1(pspos, Sp, t_ps_int);

if debug ==1 % Plot of equidistant Sp time series (after interpolation)
    figure;
    stem(pspos, Sp, 'r');
    hold on;
    stem(t_ps_int, ps_int, 'g*');
    hold off
    xlabel("Time (s)");
    ylabel("Ps (mmHg)");
    title(['Systolic blood pressure ' position ' position' ' No:' num2str(dataNum)])
    legend('Original Ps','Interpolated Ps')
end

% calculate SPV power spectral density using psd
% use of a hamming window of length 512 with 50% overlap (207) -> this
% should match HRV
[PS_FFT, fp_FFT] = pwelch(ps_int(1:end-10) - nanmean(ps_int), hamming(512), 207, 1024, f_int);

BRSPSD.PsvLf  =  sum(PS_FFT((fp_FFT <= HRV_LF_high)  & (fp_FFT >= HRV_LF_low))) * f_int/401    ;
BRSPSD.PsvHf  =  sum(PS_FFT((fp_FFT <= HRV_HF_high)  & (fp_FFT >= HRV_HF_low))) * f_int/401   ;

BRSPSD.alphaLf  =  sqrt(BRSPSD.HrvLf/BRSPSD.PsvLf)  ;
BRSPSD.alphaHf  =  sqrt(BRSPSD.HrvHf/BRSPSD.PsvHf)   ;

L =  length(ps_int)-10;
X = fft(ps_int(1:end-10) - nanmean(ps_int) );
X_FFT = abs( X(1:L/2 + 1)./ L );
X_FFT(2:end-1) = 2 .* X_FFT(2:end-1);
X_FFT = X_FFT .* X_FFT ;
Fp_FFT = (0:L/2) * f_int/L;


BRSFFT.PsvLf = sum(X_FFT((Fp_FFT <= HRV_LF_high)  & (Fp_FFT >= HRV_LF_low)))  ;
BRSFFT.PsvHf  = sum(X_FFT((Fp_FFT <= HRV_HF_high)  & (Fp_FFT >= HRV_HF_low)))  ;

BRSFFT.alphaLf  =  sqrt(BRSFFT.HrvLf/BRSFFT.PsvLf)  ;
BRSFFT.alphaHf  =  sqrt(BRSFFT.HrvHf/BRSFFT.PsvHf)   ;

[CS_FFT, fcs_FFT] = cpsd( rrIntRes( 1:min( [length(ps_int), length(rrIntRes)])-10 ) - nanmean(rrIntRes), ...
    ps_int( 1:min( [length(ps_int), length(rrIntRes)] )-10 ) - nanmean(ps_int),   hamming(512)  , 207, 1024, f_int);

CS_FFT = sqrt(abs(CS_FFT));

CsLf = mean( CS_FFT( (fcs_FFT <= HRV_LF_high)  & (fcs_FFT >= HRV_LF_low) ) )  ;
CsHf  = mean( CS_FFT( (fcs_FFT <= HRV_HF_high)  & (fcs_FFT >= HRV_HF_low) ) ) ;

BRSPSD.CsLf = CsLf   ;
BRSPSD.CsHf = CsHf ;

BRSPSD.cohereLf = 0;
BRSPSD.cohereHf = 0;

[cohere_FFT,fcohere_FFT] = mscohere(  rrIntRes( 1:min( [length(ps_int), length(rrIntRes)])-10 ) - nanmean(rrIntRes), ...
    ps_int( 1:min( [length(ps_int), length(rrIntRes)] )-10 ) - nanmean(ps_int),  hamming(512), 207, 1024, f_int);

BRSPSD.cohereLf = sum( cohere_FFT( (fcohere_FFT <= HRV_LF_high)  & (fcohere_FFT >= HRV_LF_low) )  ...
    .* fcohere_FFT( (fcohere_FFT <= HRV_LF_high)  & (fcohere_FFT >= HRV_LF_low) ) ) ...
    / sum( fcohere_FFT( (fcohere_FFT <= HRV_LF_high)  & (fcohere_FFT >= HRV_LF_low) ) );

BRSPSD.cohereHf = sum( cohere_FFT( (fcohere_FFT <= HRV_HF_high)  & (fcohere_FFT >= HRV_HF_low) )  ...
    .* fcohere_FFT( (fcohere_FFT <= HRV_HF_high)  & (fcohere_FFT >= HRV_HF_low) ) ) ...
    / sum( fcohere_FFT( (fcohere_FFT <= HRV_HF_high)  & (fcohere_FFT >= HRV_HF_low) ) );

end