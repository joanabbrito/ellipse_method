function res2 = my_baroreflex(res, debug, subjects)


    for iPosition = 1:2
        if debug == 1
            figure
        end
        
        for i = 1:length(subjects)
            iSubject = subjects(i);
          r = 1; 
          logic = 0;
            for iUp = 1:length( res(iPosition).BRS(iSubject).UpSeq )             
                for iDn = 1:length( res(iPosition).BRS(iSubject).DnSeq )
                serial1 = abs(res(iPosition).BRS(iSubject).DnSeq(iDn).RpNum(end) - res(iPosition).BRS(iSubject).UpSeq(iUp).RpNum(1) ) ;
                %serial2 = abs(res(iPosition).BRS(iSubject).DnSeq(iDn).RpNum(1) - res(iPosition).BRS(iSubject).UpSeq(iUp).RpNum(end) ) ;
                err2 = res(iPosition).BRS(iSubject).DnSeq(iDn).error ;
                err1 = res(iPosition).BRS(iSubject).UpSeq(iUp).error ;
                    if serial1 == 1 && err2 > 0.85 && err1 > 0.85
                        logic = 1;
                        % cycle
                        res2(iPosition).BRS(iSubject).BrsCycle(r).UpSeq = iUp;
                        res2(iPosition).BRS(iSubject).BrsCycle(r).DnSeq = iDn;
                        pgonAll = polyshape([ res(iPosition).BRS(iSubject).DnSeq(iDn).Sp; res(iPosition).BRS(iSubject).UpSeq(iUp).Sp], ...
                            [ res(iPosition).BRS(iSubject).DnSeq(iDn).rr; res(iPosition).BRS(iSubject).UpSeq(iUp).rr],'Simplify',false);
                        res2(iPosition).BRS(iSubject).BrsCycle(r).pgonAll = simplify(pgonAll);
                        res2(iPosition).BRS(iSubject).BrsCycle(r).area = area(pgonAll);
                        
                        res2(iPosition).BRS(iSubject).BrsCycle(r).deltaResp1 = sum(res(iPosition).BRS(iSubject).DnSeq(iDn).rr) + sum(res(iPosition).BRS(iSubject).UpSeq(iUp).rr) ;
                        res2(iPosition).BRS(iSubject).BrsCycle(r).deltaResp2 = res(iPosition).BRS(iSubject).UpSeq(iUp).SpLoc(end) - res(iPosition).BRS(iSubject).DnSeq(iDn).SpLoc(1);
                        
                        if debug == 1
                            figure
                            plot(regions(pgonAll), 'FaceColor',[1 1 1] ); hold on;
                            plot(res(iPosition).BRS(iSubject).UpSeq(iUp).Sp, res(iPosition).BRS(iSubject).UpSeq(iUp).rr, 'b*'); hold on;
                            plot(res(iPosition).BRS(iSubject).UpSeq(iUp).Sp, res(iPosition).BRS(iSubject).UpSeq(iUp).rr, 'bo'); hold on;
                            plot(res(iPosition).BRS(iSubject).DnSeq(iDn).Sp, res(iPosition).BRS(iSubject).DnSeq(iDn).rr, 'k*'); hold on;
                            plot(res(iPosition).BRS(iSubject).DnSeq(iDn).Sp, res(iPosition).BRS(iSubject).DnSeq(iDn).rr, 'ko'); hold on;
                            
                        end
                        
                        res2(iPosition).BRS(iSubject).BrsCycle(r).deltaBRS =  res(iPosition).BRS(iSubject).UpSeq(iUp).avg - res(iPosition).BRS(iSubject).DnSeq(iDn).avg ;
                        
                        res2(iPosition).BRS(iSubject).BrsCycle(r).reg = regression_method260720(res(iPosition).BRS(iSubject).UpSeq(iUp), res(iPosition).BRS(iSubject).DnSeq(iDn));
                        
                        xrange = [75 175];
                        yrange = [500 1500];
                       
                        res2(iPosition).BRS(iSubject).BrsCycle(r).ellipse = ellipse_method260720(xrange, yrange, pgonAll);
                        
                        r = r + 1;
                        
                       
                        
                    end
                    
                    

                end
            end 
            
            if logic == 0
                res2(iPosition).BRS(iSubject).BrsCycle = [];
            end
            
            
        end
    end    

end