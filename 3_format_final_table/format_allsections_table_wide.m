% Dannie Fu Novemeber 23 2020
%
% This script formats the danslanature data in wide format so that it can be input into
% JASP or SAS and saves it as a csv file. 
%
% ------------------

clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/Journal_final_participants/';
OUT_DIR = '/Volumes/Seagate/danslaNature/JASP_analysis/allsection/mixed_model/';
SAVE_NAME = 'dln_finalparticipants_long';

sections = {'before_forest','after_forest','stop0_stumps_sitting','stop1_breathing','stop2_oldtree','stop3_ferns','stop4_pinetrees','walking3_barefoot'};
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

% Columns of table
Participants = [];
stdEDAslopes_before = [];
stdEDAslopes_after = [];
stdEDAslopes_stop0 = [];
stdEDAslopes_stop1 = [];
stdEDAslopes_stop2 = [];
stdEDAslopes_stop3 = [];
stdEDAslopes_stop4= [];
stdEDAslopes_barefoot= [];
medTEMPslopes_before = [];
medTEMPslopes_after = [];
medTEMPslopes_stop0 = [];
medTEMPslopes_stop1 = [];
medTEMPslopes_stop2 = [];
medTEMPslopes_stop3 = [];
medTEMPslopes_stop4= [];
medTEMPslopes_barefoot= [];
medHRslopes_before = [];
medHRslopes_after = [];
medHRslopes_stop0 = [];
medHRslopes_stop1 = [];
medHRslopes_stop2 = [];
medHRslopes_stop3 = [];
medHRslopes_stop4= [];
medHRslopes_barefoot= [];
aveHRVYZ_before = [];
aveHRVYZ_after = [];
aveHRVYZ_stop0 = [];
aveHRVYZ_stop1 = [];
aveHRVYZ_stop2 = [];
aveHRVYZ_stop3 = [];
aveHRVYZ_stop4= [];
aveHRVYZ_barefoot= [];
aveHRVZ_before = [];
aveHRVZ_after = [];
aveHRVZ_stop0 = [];
aveHRVZ_stop1 = [];
aveHRVZ_stop2 = [];
aveHRVZ_stop3 = [];
aveHRVZ_stop4= [];
aveHRVZ_barefoot= [];
aveHR_before = [];
aveHR_after = [];
aveHR_stop0 = [];
aveHR_stop1 = [];
aveHR_stop2 = [];
aveHR_stop3 = [];
aveHR_stop4= [];
aveHR_barefoot= [];

% Init table with empty columns
JASPtable = table(Participants,stdEDAslopes_before,medTEMPslopes_before,medHRslopes_before,aveHR_before,aveHRVYZ_before, aveHRVZ_before,... 
    stdEDAslopes_after,medTEMPslopes_after,medHRslopes_after,aveHR_after,aveHRVYZ_after,aveHRVZ_after,...
    stdEDAslopes_stop0,medTEMPslopes_stop0,medHRslopes_stop0,aveHR_stop0,aveHRVYZ_stop0,aveHRVZ_stop0, ...
    stdEDAslopes_stop1,medTEMPslopes_stop1,medHRslopes_stop1,aveHR_stop1,aveHRVYZ_stop1,aveHRVZ_stop1, ...
    stdEDAslopes_stop2,medTEMPslopes_stop2,medHRslopes_stop2,aveHR_stop2,aveHRVYZ_stop2,aveHRVZ_stop2, ...
    stdEDAslopes_stop3,medTEMPslopes_stop3,medHRslopes_stop3,aveHR_stop3,aveHRVYZ_stop3,aveHRVZ_stop3,...
    stdEDAslopes_stop4,medTEMPslopes_stop4,medHRslopes_stop4,aveHR_stop4,aveHRVYZ_stop4,aveHRVZ_stop4, ...
    stdEDAslopes_barefoot,medTEMPslopes_barefoot,medHRslopes_barefoot,aveHR_barefoot,aveHRVYZ_barefoot,aveHRVZ_barefoot);

tableRow = [];

% Loop through each participant 
for k=1:length(subfolders)
    
    tableRow = [tableRow,subfolders(k)];
    
    % Load all sections except for the walking sections for this
    % participant
    for i=1:length(sections)
        
        % Load the slopes for EDA, HR, TEMP in that window
        slopes = load(strcat(LOAD_DIR,char(subfolders(k)),'/',char(sections(i)),'_slopes.mat')); 
        aves = load(strcat(LOAD_DIR,char(subfolders(k)),'/',char(sections(i)),'_ave.mat')); 

        % Compute the standard deviation of the EDA slopes and add to
        % column
        stdEDAslopes = std(slopes.EDA(:,2),'omitnan');

        % Compute the median of the HR and TEMP slopes and add to
        % column
        medianHRslopes = median(slopes.HR(:,2),'omitnan');
        medianTEMPslopes = median(slopes.TEMP(:,2),'omitnan');
        
        % Compute mean of HR and HRVYZ and HRVZ values and add to column
        meanHRVYZ = mean(aves.HRVYZ(:,2),'omitnan');
        meanHR = mean(aves.HR(:,2),'omitnan');
        meanHRVZ = mean(aves.HRVZ(:,2),'omitnan');
        
        tableRow = [tableRow,stdEDAslopes,medianTEMPslopes,medianHRslopes,meanHR,meanHRVYZ,meanHRVZ];
    end
    
    JASPtable = [JASPtable; tableRow];
    tableRow = [];
    
end 

% Save as csv file
writetable(JASPtable,strcat(OUT_DIR,SAVE_NAME));