
function [BrsUpSeq,BrsDnSeq,BrsCycle] = baroreflex_calculation_260720(RpLoc, Rp, rrInt, SpLoc,...,
    Sp, minSeq, position, debug, dataNum, fs, lag)
%This function computes the ascending baroreflex sequences of both RR interval and systolic BP values 
% If an ascending and descending sequence are consecutive, it calculates
% the baroreflex cycle polygon and the BRS sensitivity using two geometric methods:
% regression and ellipse

% inputs :
%    Rp:          array of Rpeak values
%    RpLoc :      array with location of Rpeaks
%    rrInt :      array of RR-interval values
%    Sp:          array of systolic pressure values
%    SpLoc :      array with location of Sp peaks
%    minSeq:      integer, defines minimum size of valid baroreflex sequences
%    position:    string, 'supine' or 'upright'
%    debug:       logic value, to plot (1) or not to plot (0)
%    dataNum:     subject ID
%
% outputs:
%    BrsUpSeq:  Sequence of common ascending values of rr and
%       sp; struct as long as amount of sequences found for this subject/position, with fields rr and sp
%    BrsDnSeq:  Sequence of common descending values of rr and
%       sp, struct as long as amount of sequences found for this subject/position, with fields rr and sp
%    BrsCycle:  Cycle of successive ascending and descending sequences
%        struct that includes rr, sp, pgonAll (polyshape) as long as the number of cycles found for this subject/position

i = 1; % counter that goes through the Sp array of values
k = 0; % counter of increasing Sp values (with more than 3 elements)
p = 0; % counter of decreasing Sp values (with more than 3 elements)
n = 0; %  indexing of ascending sequences
q = 0; % indexing of descending sequences
r = 1; % indexing of cycles
BrsUpSeq = []; %ascending sequences, struct
BrsDnSeq = []; %descending sequences, struct
SpUpSeq = []; %ascending sequences of only Sp, struct
BrsCycle = []; % baroreflex cycles, struct
xrange_seq = [75 180]; % systolic bp
yrange_seq = [500 1200]; % rr interval


if strcmp(position, 'supine')
    color = [0.6350, 0.0780, 0.1840];
else
    color = 'k';
end

while i < length(Sp)-1

    j = i; %counter that checks for ascending values of Sp
    while (j < length(Sp)-1) && (Sp(j) < Sp(j+1))
        j = j +1;
    end


    %only interested in successives increasing Sp which have more than 3 elements
    if j-i >= 3
        k = k+1;
        SpUpSeq(k).start = i;
        SpUpSeq(k).stop = j;
        
        
        %find the RR intervals corresponding to found Sp values
        firstP = SpLoc(SpUpSeq(k).start);
        lastP = SpLoc(SpUpSeq(k).stop);
        SpUpSeq(k).rrNum = find(RpLoc > firstP & RpLoc <= lastP);
        
        if lag == 1
            SpUpSeq(k).rrNum = [SpUpSeq(k).rrNum(2:end); SpUpSeq(k).rrNum(end)+1];
            SpUpSeq(k).rrNum = SpUpSeq(k).rrNum( SpUpSeq(k).rrNum<length(Rp) );
        elseif lag == 2
            SpUpSeq(k).rrNum = [SpUpSeq(k).rrNum(3:end); SpUpSeq(k).rrNum(end)+1; SpUpSeq(k).rrNum(end)+2];
            SpUpSeq(k).rrNum = SpUpSeq(k).rrNum( SpUpSeq(k).rrNum<length(Rp) );
        end
        
        SpUpSeq(k).RpLoc = RpLoc(SpUpSeq(k).rrNum);   
        SpUpSeq(k).rrInt = rrInt(SpUpSeq(k).rrNum);
               
        ii = 1; %counter that goes through the corresponding RR intervals 
        while  ii < length(SpUpSeq(k).rrInt)
            jj = ii;  %counter that checks for ascending values in the corresponding RR intervals 
            
            while (jj < length(SpUpSeq(k).rrInt)) && (SpUpSeq(k).rrInt(jj) < SpUpSeq(k).rrInt(jj+1))
                jj = jj+1;
            end
            
            if jj-ii >= minSeq
                firstRr = SpUpSeq(k).RpLoc(ii); % lower limit of ascending sequence
                lastRr  = SpUpSeq(k).RpLoc(jj);  % upper limit of ascending sequence
                n = n+1;
                BrsUpSeq(n).rr = SpUpSeq(k).rrInt(ii:jj); %rr in ascending sequence
                BrsUpSeq(n).Sp =  Sp(i+ii:i+jj);    % Ps in ascending sequence
                BrsUpSeq(n).SpLoc = SpLoc(i+ii:i+jj); %location of Sp peaks of ascending sequence
             
                

                BrsUpSeq(n).int = [firstRr lastRr];        % RR intervals in ascending sequence
                BrsUpSeq(n).RpNum = find(RpLoc >= firstRr & RpLoc <= lastRr); %Rp locations indices corresponding to indexes of ascending sequence
                BrsUpSeq(n).Rp = Rp(BrsUpSeq(n).RpNum); % R peaks in ascending sequence
                BrsUpSeq(n).RpLoc = RpLoc(BrsUpSeq(n).RpNum); %location of r peaks of ascending sequence

                BrsUpSeq(n).coefficients = polyfit(BrsUpSeq(n).Sp, BrsUpSeq(n).rr, 1);  % regression line of ascending sequence
                BrsUpSeq(n).error = corrcoef(BrsUpSeq(n).Sp, BrsUpSeq(n).rr); %correlation coefficient
                BrsUpSeq(n).error = BrsUpSeq(n).error(2, 1);
                BrsUpSeq(n).coefficients_wo = polyfit(BrsUpSeq(n).Sp(2:end), BrsUpSeq(n).rr(2:end), 1); %regression excluding lag 0
                BrsUpSeq(n).avg = BrsUpSeq(n).coefficients(1);   % slope of ascending sequence
                BrsUpSeq(n).avg_wo = BrsUpSeq(n).coefficients_wo(1);   % slope excluding lag 0
                 
                a = -BrsUpSeq(n).coefficients(1);
                b = 1;
                c = -BrsUpSeq(n).coefficients(2);
                BrsUpSeq(n).dist = abs (a.*BrsUpSeq(n).Sp + b.*BrsUpSeq(n).rr + c) ./ sqrt(a^2 + b^2); % distance of each point of ascending sequence to regression line 
                    
                a = -BrsUpSeq(n).coefficients_wo(1);
                b = 1;
                c = -BrsUpSeq(n).coefficients_wo(2);
                BrsUpSeq(n).dist_wo = abs (a.*BrsUpSeq(n).Sp(2:end) + b.*BrsUpSeq(n).rr(2:end) + c) ./ sqrt(a^2 + b^2); % distance excluding lag 0
                    
                BrsUpSeq(:,n).beat = (BrsUpSeq(n).rr(2:end) - BrsUpSeq(n).rr(1:end-1))./..., % each beat to beat slope (lag) of ascending sequence
                    (BrsUpSeq(n).Sp(2:end) - BrsUpSeq(n).Sp(1:end-1));
                
                % ellipse method for up sequence
                BrsUpSeq(n).pgonAll = polyshape( BrsUpSeq(n).Sp, BrsUpSeq(n).rr, 'Simplify', false );
                BrsUpSeq(n).pgonAll = simplify( BrsUpSeq(n).pgonAll );
                if BrsUpSeq(n).pgonAll.NumRegions == 0
                    BrsUpSeq(n).ellipse = [];
                else
                    BrsUpSeq(n).ellipse =  ellipse_method260720( xrange_seq, yrange_seq, BrsUpSeq(n).pgonAll );
                end

%                      
            end
            
                ii= jj+1;
        end
        
    end
    
    m = j; %counter that checks for descending values of Sp 
    while (m < length(Sp)-1)&& (Sp(m) > Sp(m+1))
        m = m +1;
    end
    
    %only interested in successives decreasing Sp which have more than 3 elements
    if (m - j) >= 3
        p = p + 1;
        SpDnSeq(p).start = j;
        SpDnSeq(p).stop = m;
          
        %find the systolic pressure corresponding to found RR segments
        firstR = RpLoc(SpDnSeq(p).start);
        lastR = RpLoc(SpDnSeq(p).stop);
        SpDnSeq(p).rrNum = find(RpLoc > firstR & RpLoc <= lastR);        
        
        if lag == 1
            SpDnSeq(p).rrNum = SpDnSeq(p).rrNum(2:end);
        elseif lag == 2
            SpDnSeq(p).rrNum = SpDnSeq(p).rrNum(3:end); 
        end
        
        SpDnSeq(p).RpLoc = RpLoc(SpDnSeq(p).rrNum);
        SpDnSeq(p).rrInt = rrInt(SpDnSeq(p).rrNum);
        
         %find the RR intervals corresponding to found Sp values
        ii = 1; 
        while  ii < length(SpDnSeq(p).rrInt)
            jj = ii;  %counter that checks for descending values in the corresponding RR intervals 
            while (jj < length(SpDnSeq(p).rrInt))&&(SpDnSeq(p).rrInt(jj) > SpDnSeq(p).rrInt(jj+1))
                jj = jj+1;
            end
            if jj-ii >= minSeq
                 
                firstRr = SpDnSeq(p).RpLoc(ii); % lower limit of common descending interval
                lastRr = SpDnSeq(p).RpLoc(jj);  % upper limit of common descending interval
                q = q+1;
                BrsDnSeq(q).rr = SpDnSeq(p).rrInt(ii:jj); % Ps in common DnSequencing trend
                BrsDnSeq(q).Sp =  Sp(j+ii:j+jj);    % RR-intevals in common DnSequencing trend
                BrsDnSeq(q).SpLoc = SpLoc(j+ii:j+jj); %location of Sp peaks of descending sequence

                BrsDnSeq(q).int = [firstRr lastRr];        % common descending interval
                BrsDnSeq(q).RpNum = find(RpLoc >= firstRr & RpLoc <= lastRr); %Rp locations indices corresponding to indexes of descending sequence
                BrsDnSeq(q).Rp = Rp(BrsDnSeq(q).RpNum);% fs/3 to cover previous Rp           
                BrsDnSeq(q).RpLoc = RpLoc(BrsDnSeq(q).RpNum); %location of r peaks of descending sequence
                
                BrsDnSeq(q).coefficients = polyfit(BrsDnSeq(q).Sp, BrsDnSeq(q).rr, 1); % regression line of descending sequence
                BrsDnSeq(q).coefficients_wo = polyfit(BrsDnSeq(q).Sp(2:end), BrsDnSeq(q).rr(2:end), 1); % regression line of descending sequence
                BrsDnSeq(q).error = corrcoef(BrsDnSeq(q).Sp, BrsDnSeq(q).rr); %correlation coefficient
                BrsDnSeq(q).error = BrsDnSeq(q).error(2, 1);
                
                BrsDnSeq(q).avg = BrsDnSeq(q).coefficients(1);   % slope of descending sequence
                BrsDnSeq(q).avg_wo = BrsDnSeq(q).coefficients_wo(1);
                
                a = -BrsDnSeq(q).coefficients(1);
                b = 1;
                c = -BrsDnSeq(q).coefficients(2);
                BrsDnSeq(q).dist = abs (a.*BrsDnSeq(q).Sp + b.*BrsDnSeq(q).rr + c) ./ sqrt(a^2 + b^2); % distance of each point of descending sequence to regression line 
                
                a = -BrsDnSeq(q).coefficients_wo(1);
                b = 1;
                c = -BrsDnSeq(q).coefficients_wo(2);
                BrsDnSeq(q).dist_wo = abs (a.*BrsDnSeq(q).Sp(2:end) + b.*BrsDnSeq(q).rr(2:end) + c) ./ sqrt(a^2 + b^2);
                
                BrsDnSeq(:,q).beat = (BrsDnSeq(q).rr(2:end) - BrsDnSeq(q).rr(1:end-1))./..., % each beat to beat slope (lag) of descending sequence
                    (BrsDnSeq(q).Sp(2:end) - BrsDnSeq(q).Sp(1:end-1));
                
                % ellipse method for dn sequence
                BrsDnSeq(q).pgonAll = polyshape( BrsDnSeq(q).Sp, BrsDnSeq(q).rr, 'Simplify', false );
                BrsDnSeq(q).pgonAll = simplify( BrsDnSeq(q).pgonAll );
                if BrsDnSeq(q).pgonAll.NumRegions == 0
                    BrsDnSeq(q).ellipse = [];
                else
                    BrsDnSeq(q).ellipse =  ellipse_method260720( xrange_seq, yrange_seq, BrsDnSeq(q).pgonAll );
                end
          

                if ~isempty(BrsUpSeq) % in case of no upsequencing is available at first run
                    serialCheck = abs( BrsDnSeq(q).RpNum(1) - BrsUpSeq(n).RpNum(end) ); % plot just consecutive up and down sequences
                    
                    if ( serialCheck == 1 )   && ( BrsDnSeq(q).error > 0.85 ) && ( BrsUpSeq(n).error > 0.85 )  
                        
%                         if ( BrsUpSeq(n).Sp(1) - BrsDnSeq(q).Sp(end) > 0 ) && ( BrsUpSeq(n).rr(1) - BrsDnSeq(q).rr(end) > 0 )
%                             BrsUpSeq(n).Sp = [BrsDnSeq(q).Sp(end); BrsUpSeq(n).Sp];
%                             BrsUpSeq(n).SpLoc = [BrsDnSeq(q).Sp(end); BrsUpSeq(n).SpLoc];
%                             BrsUpSeq(n).rr = [BrsDnSeq(q).rr(end); BrsUpSeq(n).rr];
%                         elseif  ( BrsUpSeq(n).Sp(1) - BrsDnSeq(q).Sp(end) < 0 ) && ( BrsUpSeq(n).rr(1) - BrsDnSeq(q).rr(end) < 0 )
%                             BrsDnSeq(q).Sp = [BrsDnSeq(q).Sp; BrsUpSeq(n).Sp(1)];
%                             BrsDnSeq(q).rr = [BrsDnSeq(q).rr; BrsUpSeq(n).rr(1)];
%                         end
%                     
%                     if ( BrsUpSeq(n).Sp(end) - BrsDnSeq(q).Sp(1) < 0 ) && ( BrsUpSeq(n).rr(end) - BrsDnSeq(q).rr(1) < 0 )
%                         BrsUpSeq(n).Sp = [BrsUpSeq(n).Sp; BrsDnSeq(q).Sp(1)];
%                         BrsUpSeq(n).rr = [BrsUpSeq(n).rr; BrsDnSeq(q).rr(1)];
%                     elseif ( BrsUpSeq(n).Sp(end) - BrsDnSeq(q).Sp(1) > 0 ) && ( BrsUpSeq(n).rr(end) - BrsDnSeq(q).rr(1) > 0 )
%                         BrsDnSeq(q).Sp = [BrsUpSeq(n).Sp(end); BrsDnSeq(q).Sp];
%                         BrsDnSeq(q).rr = [BrsUpSeq(n).rr(end); BrsDnSeq(q).rr];    
%                     end
%                         
                        
                        BrsCycle(r).UpSeq = n;
                        BrsCycle(r).DnSeq = q;
                        pgonAll = polyshape([BrsDnSeq(q).Sp;BrsUpSeq(n).Sp], [BrsDnSeq(q).rr;BrsUpSeq(n).rr],'Simplify',false);
                        BrsCycle(r).pgonAll = simplify(pgonAll);
                        BrsCycle(r).area = area(pgonAll);
                        %if ~isempty(BrsDnSeq(q).ellipse) && ~isempty(BrsUpSeq(n).ellipse)
                            BrsCycle(r).deltaBRS =  BrsUpSeq(n).avg - BrsDnSeq(q).avg ;
                        %end
                        BrsCycle(r).deltaResp1 = sum(BrsDnSeq(q).rr) + sum(BrsUpSeq(n).rr) ;
                        BrsCycle(r).deltaResp2 = BrsDnSeq(q).SpLoc(end) - BrsUpSeq(n).SpLoc(1);
                        
                        
                        if debug == 1
                            figure() %each cycle in one figure
                            %plot(regions(pgonAll)); hold on;
                            plot(regions(pgonAll),'FaceColor',[1 1 1]  ); hold on;%,'FaceAlpha',0.1); hold on;
                            plot(BrsUpSeq(n).Sp, BrsUpSeq(n).rr, 'b*'); hold on;
                            plot(BrsUpSeq(n).Sp, BrsUpSeq(n).rr, 'bo'); hold on;
                            plot(BrsDnSeq(q).Sp, BrsDnSeq(q).rr, 'k*'); hold on;
                            plot(BrsDnSeq(q).Sp, BrsDnSeq(q).rr, 'ko'); hold on;
                            title(join(['Baroreflex cycle for ' position ' position, Subject : ' dataNum]))
                            %xlim([75 175])
                            %ylim([500 1500])
                            xlabel('Systolic blood pressure [mmHg]')
                            ylabel('RR interval [ms]')
                            hold on;
                        end
                        
                        % Regression method
                        
                        [BrsCycle(r).reg] = regression_method260720(BrsUpSeq(n), BrsDnSeq(q));
                        
                        if debug == 2 
                            figure()
                             %plot cycle
                            plot(regions(pgonAll),'FaceColor',[0.6 0.6 0.6]  ); hold on;
                            % plot sequences
                            plot(BrsUpSeq(n).Sp, BrsUpSeq(n).rr, 'b*'); hold on;
                            plot(BrsUpSeq(n).Sp, BrsUpSeq(n).rr, 'bo'); hold on;
                            plot(BrsDnSeq(q).Sp, BrsDnSeq(q).rr, 'k*'); hold on;
                            plot(BrsDnSeq(q).Sp, BrsDnSeq(q).rr, 'ko'); hold on;
                                %plot regression line of ascending seq
                            plot([BrsUpSeq(n).Sp(1), BrsUpSeq(n).Sp(end)], polyval(BrsUpSeq(n).coefficients, [BrsUpSeq(n).Sp(1), BrsUpSeq(n).Sp(end)]), 'b'); hold on;
                                %plot regression line of descending seq
                            plot([BrsDnSeq(q).Sp(end), BrsDnSeq(q).Sp(1)], polyval(BrsDnSeq(q).coefficients, [BrsDnSeq(q).Sp(end), BrsDnSeq(q).Sp(1)]), 'k'); hold on;
                                % plot main axis
                           % plot(BrsCycle(r).reg.majorX, BrsCycle(r).reg.majorY, 'Color', 'k', 'LineWidth', 1); hold on;
                                % plot minor axis
                           % plot(BrsCycle(r).reg.minorX, BrsCycle(r).reg.minorY, 'Color','k', 'LineWidth', 1); hold on;
                            
                            title(join(['Baroreflex cycle for ' position ' position, Subject : ' dataNum]))
                            xlim([75 175])
                            ylim([500 1500])
                            xlabel('Systolic blood pressure [mmHg]')
                            ylabel('RR interval [ms]')
                            hold on;
                        end
              
                    
                        % Ellipse method
                       xrange = [75 175];
                       yrange = [500 1500];
                       
                       BrsCycle(r).ellipse = ellipse_method260720(xrange, yrange, BrsCycle(r).pgonAll);
                       
                       
                       
                       if debug == 3 
                             figure
                            %plot cycle
                             plot(regions(pgonAll),'FaceColor',[1 1 1]  ); hold on;
                            %plot ellipse
                           plot(BrsCycle(r).ellipse.Ellipse(1, :) + BrsCycle(r).ellipse.Cntrd(1), ...
                               BrsCycle(r).ellipse.Ellipse(2, :) + BrsCycle(r).ellipse.Cntrd(2), ...
                               '-','Color', color, 'LineWidth', 0.9); hold on;
                           %plot major axis and minor axis
                           plot(BrsCycle(r).ellipse.majorAxis(1, :), BrsCycle(r).ellipse.majorAxis(2, :), 'Color', color, 'LineWidth', 0.9); hold on;
                           plot(BrsCycle(r).ellipse.minorAxis(1, :), BrsCycle(r).ellipse.minorAxis(2, :), 'Color', color, 'LineWidth', 0.9); hold on;
                           
                           title(join(['Baroreflex cycle for Subject : ' dataNum]))
                          % xlim([110 170])
                           % ylim([550 1000])
                           xlabel('Systolic blood pressure [mmHg]')
                           ylabel('RR interval [ms]')
                           hold on;
                       end 
                       
                       r = r + 1;                   
                       
        
                    end
                    
                end 
            end
            
            ii= jj+1;
            
        end
        
    end
    
    i = m ;
    
    % in case there are two equal values of Sp not include them in the sequence, in order to be able to
    % calculate beat to beat slope 
    if (Sp(m) == Sp(m+1)) 
        i = m+1;
    end 
    
end
  
end

