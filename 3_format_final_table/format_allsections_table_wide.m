% Dannie Fu March 1 2021
% Format data table into wide format from all sections long table
% Need to run format_allsections_table_long.m first. The output table of
% that script will be the input of this script.
%
% ---------------------

T = readtable('/Volumes/Seagate/danslaNature/analysis/statistical_analysis/2_final_analysis/DataTables/dln_mixedmodel_long.csv'); % Make sure this is the same table that was output when you ran format_allsections_table_long.m 
OUT_DIR = '/Volumes/Seagate/danslaNature/analysis/statistical_analysis/2_final_analysis/DataTables/';
SAVE_NAME = 'dln_mixedmodel_wide';

% Columns of new table 
Participants = [];
Group = [];
meanDailyTemperature = [];
stdEDAslopes_before = [];
medTEMPslopes_before = [];
medHRslopes_before = [];
aveHR_before = [];
stdEDAslopes_stop0 = [];
medTEMPslopes_stop0 = [];
medHRslopes_stop0 = [];
aveHR_before_stop0 = [];
stdEDAslopes_stop1 = [];
medTEMPslopes_stop1 = [];
medHRslopes_stop1 = [];
aveHR_before_stop1 = [];
stdEDAslopes_stop2 = [];
medTEMPslopes_stop2 = [];
medHRslopes_stop2 = [];
aveHR_before_stop2 = [];
stdEDAslopes_barefoot = [];
medTEMPslopes_barefoot = [];
medHRslopes_barefoot = [];
aveHR_before_barefoot = [];
stdEDAslopes_stop3 = [];
medTEMPslopes_stop3 = [];
medHRslopes_stop3 = [];
aveHR_before_stop3 = [];
stdEDAslopes_stop4 = [];
medTEMPslopes_stop4 = [];
medHRslopes_stop4 = [];
aveHR_before_stop4 = [];
stdEDAslopes_after = [];
medTEMPslopes_after = [];
medHRslopes_after = [];
aveHR_before_after = [];

% Init table with empty columns
newT = table(Participants,Group,meanDailyTemperature,...
    stdEDAslopes_before,medTEMPslopes_before,medHRslopes_before,aveHR_before, ...
    stdEDAslopes_stop0,medTEMPslopes_stop0,medHRslopes_stop0,aveHR_before_stop0, ...
    stdEDAslopes_stop1,medTEMPslopes_stop1,medHRslopes_stop1,aveHR_before_stop1, ...
    stdEDAslopes_stop2,medTEMPslopes_stop2,medHRslopes_stop2,aveHR_before_stop2, ...
    stdEDAslopes_barefoot,medTEMPslopes_barefoot,medHRslopes_barefoot,aveHR_before_barefoot, ...
    stdEDAslopes_stop3,medTEMPslopes_stop3,medHRslopes_stop3,aveHR_before_stop3, ...
    stdEDAslopes_stop4,medTEMPslopes_stop4,medHRslopes_stop4,aveHR_before_stop4, ...
    stdEDAslopes_after,medTEMPslopes_after,medHRslopes_after,aveHR_before_after);

for i=1:8:size(T,1) % Number of stops is 8
        
    tableRow = {T.participant(i),T.group(i), T.meanDailyTemperature(i), ...
        T.stdEDAslopes(i), T.medTEMPslopes(i),T.medHRslopes(i), T.aveHR(i), ...         % before = i
        T.stdEDAslopes(i+1), T.medTEMPslopes(i+1),T.medHRslopes(i+1), T.aveHR(i+1), ... % stop0 = i+1
        T.stdEDAslopes(i+2), T.medTEMPslopes(i+2),T.medHRslopes(i+2), T.aveHR(i+2), ... % stop1 = i+2
        T.stdEDAslopes(i+3), T.medTEMPslopes(i+3),T.medHRslopes(i+3), T.aveHR(i+3), ... % stop2 = i+3
        T.stdEDAslopes(i+4), T.medTEMPslopes(i+4),T.medHRslopes(i+4), T.aveHR(i+4), ... % barefoot = i+4
        T.stdEDAslopes(i+5), T.medTEMPslopes(i+5),T.medHRslopes(i+5), T.aveHR(i+5), ... % stop3 = i+5
        T.stdEDAslopes(i+6), T.medTEMPslopes(i+6),T.medHRslopes(i+6), T.aveHR(i+6), ... % stop4 = i+6
        T.stdEDAslopes(i+7), T.medTEMPslopes(i+7),T.medHRslopes(i+7), T.aveHR(i+7), ... % after = i+7
        };
    
    newT = [newT; tableRow];

end 

% Save as csv file
writetable(newT,strcat(OUT_DIR,SAVE_NAME,'.csv'));