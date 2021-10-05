function [res] = Datasort

%% Initialisation 

load('ROBAVARData.mat');
load('A004SC.mat');

%% Data allocation

if ~ exist('res','var')
    res(1).position = 'supine';
    res(2).position = 'upright';
    res(1).fs = 500; %sampling frequency, in Hz
    res(2).fs = 500; %sampling frequency, in Hz
    res(1).ID = strings(21, 1);
    res(2).ID = strings(21, 1);
    % Group A
    for iSubject = 1:8
        res(1).AB(iSubject).ecg = ROBAVARData(iSubject).ALC(:,2);     % ALC stands for "A" group,"L" position (laying) & "C" curve (vs beat to beat)
        res(1).AB(iSubject).bp = ROBAVARData(iSubject).ALC(:,1);  
        res(1).ID(iSubject) = ['A', num2str(iSubject)];
        
        res(2).AB(iSubject).ecg = ROBAVARData(iSubject).ASC(:,2);     % ASC stands for "A" group,"S" position (standing) & "C" curve (vs beat to beat)
        res(2).AB(iSubject).bp = ROBAVARData(iSubject).ASC(:,1);
        res(2).ID(iSubject) = ['A', num2str(iSubject)];
    end
    
    % Group B
    for iSubject = 1:13
        res(1).AB(8 + iSubject).ecg = ROBAVARData(iSubject).BLC(:,2);   % BLC stands for "B" group,"L" position (laying) & "C" curve (vs beat to beat)
        res(1).AB(8 + iSubject).bp = ROBAVARData(iSubject).BLC(:,1);
        res(1).ID(8 + iSubject) = ['B', num2str(iSubject)];
        
        res(2).AB(8 + iSubject).ecg = ROBAVARData(iSubject).BSC(:,2);   % BSC stands for "B" group,"S" position (standing) & "C" curve (vs beat to beat)
        res(2).AB(8 + iSubject).bp = ROBAVARData(iSubject).BSC(:,1);
        res(2).ID(8 + iSubject) = ['B', num2str(iSubject)];
    end
    
    % manual allocation of data A004SC 
    A004SC = table2array(A004SC);
    res(2).AB(4).ecg = A004SC(:,2);
    res(2).AB(4).bp = A004SC(:,1);

end