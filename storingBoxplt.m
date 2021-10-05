function [boxPlt] = storingBoxplt(store)

%storing for boxplot
% 
% ellipse method for sequences minor axis length
% % sup up tilt up sup dn tilt dn
boxPlt.SeqEllipsel = NaN(max ([length(store(1).UpSeqEllipsel), length(store(2).UpSeqEllipsel), length(store(1).DnSeqEllipsel), length(store(2).DnSeqEllipsel)]) , 4);
boxPlt.SeqEllipsel(1:length(store(1).UpSeqEllipsel), 1) = store(1).UpSeqEllipsel;
boxPlt.SeqEllipsel(1:length(store(2).UpSeqEllipsel), 2) = store(2).UpSeqEllipsel;
boxPlt.SeqEllipsel(1:length(store(1).DnSeqEllipsel), 3) = store(1).DnSeqEllipsel;
boxPlt.SeqEllipsel(1:length(store(2).DnSeqEllipsel), 4) = store(2).DnSeqEllipsel;
% viscoelasticity coefficient of arteries
% % sup up tilt up sup dn tilt dn
boxPlt.G = NaN(max ([length(store(1).UpG), length(store(2).UpG), length(store(1).DnG), length(store(2).DnG)]) , 4);
boxPlt.G(1:length(store(1).UpG), 1) = store(1).UpG;
boxPlt.G(1:length(store(2).UpG), 2) = store(2).UpG;
boxPlt.G(1:length(store(1).DnG), 3) = store(1).DnG;
boxPlt.G(1:length(store(2).DnG), 4) = store(2).DnG;

%baroreflex: joining
    %error of estimate
boxPlt.error = NaN(max([length(store(1).errorUp), length(store(2).errorUp), length(store(1).errorDn), length(store(2).errorDn)]), 4);
boxPlt.error(1:length(store(1).errorUp), 1) = store(1).errorUp;
boxPlt.error(1:length(store(2).errorUp), 2) = store(2).errorUp;
boxPlt.error(1:length(store(1).errorDn), 3) = store(1).errorDn;
boxPlt.error(1:length(store(2).errorDn), 4) = store(2).errorDn;

    %error of estimate wo lag 0
boxPlt.error_wo = NaN(max([length(store(1).errorUp_wo), length(store(2).errorUp_wo), length(store(1).errorDn_wo), length(store(2).errorDn_wo)]), 4);
boxPlt.error_wo(1:length(store(1).errorUp_wo), 1) = store(1).errorUp_wo;
boxPlt.error_wo(1:length(store(2).errorUp_wo), 2) = store(2).errorUp_wo;
boxPlt.error_wo(1:length(store(1).errorDn_wo), 3) = store(1).errorDn_wo;
boxPlt.error_wo(1:length(store(2).errorDn_wo), 4) = store(2).errorDn_wo;

    %summed error of estimate
boxPlt.errorSum = NaN(max([length(store(1).errorSumUp), length(store(2).errorSumUp), length(store(1).errorSumDn), length(store(2).errorSumDn)]), 4);
boxPlt.errorSum(1:length(store(1).errorSumUp), 1) = store(1).errorSumUp;
boxPlt.errorSum(1:length(store(2).errorSumUp), 2) = store(2).errorSumUp;
boxPlt.errorSum(1:length(store(1).errorSumDn), 3) = store(1).errorSumDn;
boxPlt.errorSum(1:length(store(2).errorSumDn), 4) = store(2).errorSumDn;

    % sequence BRS with regression: up + dn separated
boxPlt.Slope = NaN(max([length(store(1).SlopeUp), length(store(2).SlopeUp), length(store(1).SlopeDn), length(store(2).SlopeDn)]), 4);
boxPlt.Slope(1:length(store(1).SlopeUp), 1) = store(1).SlopeUp;
boxPlt.Slope(1:length(store(2).SlopeUp), 2) = store(2).SlopeUp;
boxPlt.Slope(1:length(store(1).SlopeDn), 3) = store(1).SlopeDn;
boxPlt.Slope(1:length(store(2).SlopeDn), 4) = store(2).SlopeDn;

    % sequence BRS with regression: up + dn together
boxPlt.allSlope = NaN(max([length(store(1).SlopeUp) + length(store(1).SlopeDn), length(store(2).SlopeUp) + length(store(2).SlopeDn)]), 2);
boxPlt.allSlope(1: length(store(1).SlopeUp)+length(store(1).SlopeDn) , 1) = [store(1).SlopeUp; store(1).SlopeDn];
boxPlt.allSlope(1: length(store(2).SlopeUp)+length(store(2).SlopeDn), 2) = [store(2).SlopeUp; store(2).SlopeDn];

    %slope of regression line of sequence wo lag 0
boxPlt.Slope_wo = NaN(max([length(store(1).SlopeUp_wo), length(store(2).SlopeUp_wo), length(store(1).SlopeDn_wo), length(store(2).SlopeDn_wo)]), 4);
boxPlt.Slope_wo(1:length(store(1).SlopeUp_wo), 1) = store(1).SlopeUp_wo;
boxPlt.Slope_wo(1:length(store(2).SlopeUp_wo), 2) = store(2).SlopeUp_wo;
boxPlt.Slope_wo(1:length(store(1).SlopeDn_wo), 3) = store(1).SlopeDn_wo;
boxPlt.Slope_wo(1:length(store(2).SlopeDn_wo), 4) = store(2).SlopeDn_wo;

    % BRS of regression line of cycle sequences: differentiation up + dn
boxPlt.SlopeC = NaN(max([length(store(1).SlopeUpC), length(store(2).SlopeUpC), length(store(1).SlopeDnC), length(store(2).SlopeDnC)]), 4);
boxPlt.SlopeC(1:length(store(1).SlopeUpC), 1) = store(1).SlopeUpC;
boxPlt.SlopeC(1:length(store(2).SlopeUpC), 2) = store(2).SlopeUpC;
boxPlt.SlopeC(1:length(store(1).SlopeDnC), 3) = store(1).SlopeDnC;
boxPlt.SlopeC(1:length(store(2).SlopeDnC), 4) = store(2).SlopeDnC;

    % BRS of regression line of cycle sequences: wo differentiation up + dn
boxPlt.allSlopeC = NaN(max([length(store(1).SlopeUpC) + length(store(1).SlopeDnC), length(store(2).SlopeUpC) + length(store(2).SlopeDnC)]), 2);
boxPlt.allSlopeC(1: length(store(1).SlopeUpC)+length(store(1).SlopeDnC) , 1) = [store(1).SlopeUpC; store(1).SlopeDnC];
boxPlt.allSlopeC(1: length(store(2).SlopeUpC)+length(store(2).SlopeDnC), 2) = [store(2).SlopeUpC; store(2).SlopeDnC];

    %BRS of sequences in cycle with ellipse method: up + dn separated
boxPlt.ellipseSlopeC = NaN(max([length(store(1).ellipseSlopeUpC), length(store(2).ellipseSlopeUpC), length(store(1).ellipseSlopeDnC), length(store(2).ellipseSlopeDnC)]), 4);
boxPlt.ellipseSlopeC(1:length(store(1).ellipseSlopeUpC), 1) = store(1).ellipseSlopeUpC;
boxPlt.ellipseSlopeC(1:length(store(2).ellipseSlopeUpC), 2) = store(2).ellipseSlopeUpC;
boxPlt.ellipseSlopeC(1:length(store(1).ellipseSlopeDnC), 3) = store(1).ellipseSlopeDnC;
boxPlt.ellipseSlopeC(1:length(store(2).ellipseSlopeDnC), 4) = store(2).ellipseSlopeDnC;

    %BRS of sequences in cycle with ellipse method: up + dn together
boxPlt.allellipseSlopeC = NaN(max([length(store(1).ellipseSlopeUpC) + length(store(1).ellipseSlopeDnC), length(store(2).ellipseSlopeUpC) + length(store(2).ellipseSlopeDnC)]), 2);
boxPlt.allellipseSlopeC(1:length(store(1).ellipseSlopeUpC) + length(store(1).ellipseSlopeDnC) , 1) = [store(1).ellipseSlopeUpC; store(1).ellipseSlopeDnC];
boxPlt.allellipseSlopeC(1:length(store(2).ellipseSlopeUpC) + length(store(2).ellipseSlopeDnC) , 2) = [store(2).ellipseSlopeUpC; store(2).ellipseSlopeDnC];

    %BRS of all sequences with ellipse method: up + dn separated
boxPlt.ellipseSlopeSeq = NaN(max([length(store(1).ellipseSlopeUp), length(store(2).ellipseSlopeUp), length(store(1).ellipseSlopeDn), length(store(2).ellipseSlopeDn)]), 4);
boxPlt.ellipseSlopeSeq(1:length(store(1).ellipseSlopeUp), 1) = store(1).ellipseSlopeUp;
boxPlt.ellipseSlopeSeq(1:length(store(2).ellipseSlopeUp), 2) = store(2).ellipseSlopeUp;
boxPlt.ellipseSlopeSeq(1:length(store(1).ellipseSlopeDn), 3) = store(1).ellipseSlopeDn;
boxPlt.ellipseSlopeSeq(1:length(store(2).ellipseSlopeDn), 4) = store(2).ellipseSlopeDn;

    %BRS of all sequences with ellipse method: up + dn together
boxPlt.allellipseSlopeSeq = NaN(max([length(store(1).ellipseSlopeUp) + length(store(1).ellipseSlopeDn), length(store(2).ellipseSlopeUp) + length(store(2).ellipseSlopeDn)]), 2);
boxPlt.allellipseSlopeSeq(1:length(store(1).ellipseSlopeUp)+length(store(1).ellipseSlopeDn), 1) = [store(1).ellipseSlopeUp; store(1).ellipseSlopeDn];
boxPlt.allellipseSlopeSeq(1:length(store(2).ellipseSlopeUp)+length(store(2).ellipseSlopeDn), 2) = [store(2).ellipseSlopeUp; store(2).ellipseSlopeDn];

    %error of estimate for sequences which are part of a cycle
boxPlt.errorC = NaN(max([length(store(1).errorUpC), length(store(2).errorUpC), length(store(1).errorDnC), length(store(2).errorDnC)]), 4);
boxPlt.errorC(1:length(store(1).errorUpC), 1) = store(1).errorUpC;
boxPlt.errorC(1:length(store(2).errorUpC), 2) = store(2).errorUpC;
boxPlt.errorC(1:length(store(1).errorDnC), 3) = store(1).errorDnC;
boxPlt.errorC(1:length(store(2).errorDnC), 4) = store(2).errorDnC;

    %summed error of estimate for sequences which are part of a cycle
boxPlt.errorSumC = NaN(max([length(store(1).errorSumDnC), length(store(2).errorSumDnC), length(store(1).errorSumUpC), length(store(2).errorSumUpC)]), 4);
boxPlt.errorSumC (1:length(store(1).errorSumUpC), 1) = store(1).errorSumUpC;
boxPlt.errorSumC (1:length(store(2).errorSumUpC), 2) = store(2).errorSumUpC;
boxPlt.errorSumC (1:length(store(1).errorSumDnC), 3) = store(1).errorSumDnC;
boxPlt.errorSumC (1:length(store(2).errorSumDnC), 4) = store(2).errorSumDnC;

    %length of major regression axis of cycle
boxPlt.RegL = NaN(max ([length(store(1).RegL), length(store(2).RegL)]) , 2);
boxPlt.RegL(1:length(store(1).RegL), 1) = store(1).RegL;
boxPlt.RegL(1:length(store(2).RegL), 2) = store(2).RegL;

    %length of minor regression axis of cycle
boxPlt.Regl = NaN(max ([length(store(1).Regl), length(store(2).Regl)]) , 2);
boxPlt.Regl(1:length(store(1).Regl), 1) = store(1).Regl;
boxPlt.Regl(1:length(store(2).Regl), 2) = store(2).Regl;

    %length of major and minor regression axis of cycle together
boxPlt.allRegL = NaN(max([size(boxPlt.RegL, 1), size(boxPlt.Regl, 2)]), 4);
boxPlt.allRegL(1:length(store(1).RegL), 1) = store(1).RegL;
boxPlt.allRegL(1:length(store(2).RegL), 2) = store(2).RegL;
boxPlt.allRegL(1:length(store(1).Regl), 3) = store(1).Regl;
boxPlt.allRegL(1:length(store(2).Regl), 4) = store(2).Regl;

    %slope of major regression axis of cycle
boxPlt.RegSlope = NaN(max ([length(store(1).RegSlope), length(store(2).RegSlope)]) , 2);
boxPlt.RegSlope(1:length(store(1).RegSlope), 1) = store(1).RegSlope;
boxPlt.RegSlope(1:length(store(2).RegSlope), 2) = store(2).RegSlope;

%storing values for ellipse boxPltplots
    %length of major axis of ellipse
boxPlt.EllipseL = NaN(max ([length(store(1).EllipseL), length(store(2).EllipseL)]) , 2);
boxPlt.EllipseL(1:length(store(1).EllipseL), 1) = store(1).EllipseL;
boxPlt.EllipseL(1:length(store(2).EllipseL), 2) = store(2).EllipseL;

    %length of minor axis of ellipse
boxPlt.Ellipsel = NaN(max ([length(store(1).Ellipsel), length(store(2).Ellipsel)]) , 2);
boxPlt.Ellipsel(1:length(store(1).Ellipsel), 1) = store(1).Ellipsel;
boxPlt.Ellipsel(1:length(store(2).Ellipsel), 2) = store(2).Ellipsel;

    %length of major and minor axes of ellipse together
boxPlt.allEllipseL = NaN(max([size(boxPlt.EllipseL, 1), size(boxPlt.Ellipsel, 2)]), 4);
boxPlt.allEllipseL(1:length(store(1).EllipseL), 1) = store(1).EllipseL;
boxPlt.allEllipseL(1:length(store(2).EllipseL), 2) = store(2).EllipseL;
boxPlt.allEllipseL(1:length(store(1).Ellipsel), 3) = store(1).Ellipsel;
boxPlt.allEllipseL(1:length(store(2).Ellipsel), 4) = store(2).Ellipsel;
    %slope of major axis of ellipse
boxPlt.EllipseSlope = NaN(max ([length(store(1).EllipseSlope), length(store(2).EllipseSlope)]) , 2);
boxPlt.EllipseSlope(1:length(store(1).EllipseSlope), 1) = store(1).EllipseSlope;
boxPlt.EllipseSlope(1:length(store(2).EllipseSlope), 2) = store(2).EllipseSlope;

    % ellipse area
boxPlt.ellipseArea = NaN(max(length(store(1).ellipseArea), length(store(2).ellipseArea)), 2);
boxPlt.ellipseArea(1:length(store(1).ellipseArea), 1) = store(1).ellipseArea;
boxPlt.ellipseArea(1:length(store(2).ellipseArea), 2) = store(2).ellipseArea;

    % Projection angle of ellipse into circle 
boxPlt.ProjAngle = NaN(max(length(store(1).ProjAngle), length(store(2).ProjAngle)), 2);
boxPlt.ProjAngle(1:length(store(1).ProjAngle), 1) = store(1).ProjAngle;
boxPlt.ProjAngle(1:length(store(2).ProjAngle), 2) = store(2).ProjAngle;

    % Hysteresis magnitude
boxPlt.magnitudeH = NaN(max(length(store(1).magnitudeH), length(store(2).magnitudeH)), 2);
boxPlt.magnitudeH(1:length(store(1).magnitudeH), 1) = store(1).magnitudeH;
boxPlt.magnitudeH(1:length(store(2).magnitudeH), 2) = store(2).magnitudeH;

    %setpoint
boxPlt.setpoint = NaN( max( [length(store(1).setpoint), length(store(2).setpoint)] ), 2 );
boxPlt.setpoint(1:length(store(1).setpoint), 1) = store(1).setpoint;
boxPlt.setpoint(1:length(store(2).setpoint), 2) = store(2).setpoint;

    %delta BRS
boxPlt.deltaBRS = NaN( max( [length(store(1).deltaBRS), length(store(2).deltaBRS)] ), 2 );
boxPlt.deltaBRS(1:length(store(1).deltaBRS), 1) = store(1).deltaBRS;
boxPlt.deltaBRS(1:length(store(2).deltaBRS), 2) = store(2).deltaBRS;

end
