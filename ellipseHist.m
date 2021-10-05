function [elHist] = ellipseHist (store)

    for i = 1:2

    elHist(i).area.h = histogram(store(i).ellipseArea, 'BinEdges', 50:62.5:675); 
    elHist(i).area.Xdata = 81.25:62.5:643.75;
    elHist(i).area.Ydata = elHist(i).area.h.Values;
    
    elHist(i).H.h = histogram(store(i).magnitudeH, 'BinEdges', 0:0.02:0.2); 
    elHist(i).H.Xdata = 0.01:0.02:0.19;
    elHist(i).H.Ydata = elHist(i).H.h.Values;
    
    end 
    
    close all
end