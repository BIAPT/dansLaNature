% Dannie Fu Novemeber 23 2020
%
% This script formats the danslanature data so that it can be input into
% JASP and saves it as a csv file. 
%
% ------------------

% Good participants: 1,2,8,9,11,13,16,21,37,54
clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/data/final_participants/';
OUT_DIR = '/Volumes/Seagate/danslaNature/JASP_analysis/';
sections = {'before_forest','after_forest','stop0_stumps_sitting','stop1_breathing','stop2_oldtree','stop3_ferns','stop4_pinetrees','walking3_barefoot'};
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

% Columns of JASP table
Participants = [];
EDA_before = [];
EDA_after = [];
EDA_stop0 = [];
EDA_stop1 = [];
EDA_stop2 = [];
EDA_stop3 = [];
EDA_stop4= [];
EDA_barefoot= [];
TEMP_before = [];
TEMP_after = [];
TEMP_stop0 = [];
TEMP_stop1 = [];
TEMP_stop2 = [];
TEMP_stop3 = [];
TEMP_stop4= [];
TEMP_barefoot= [];
HR_before = [];
HR_after = [];
HR_stop0 = [];
HR_stop1 = [];
HR_stop2 = [];
HR_stop3 = [];
HR_stop4= [];
HR_barefoot= [];
HRVZY_before = [];
HRVZY_after = [];
HRVZY_stop0 = [];
HRVZY_stop1 = [];
HRVZY_stop2 = [];
HRVZY_stop3 = [];
HRVZY_stop4= [];
HRVZY_barefoot= [];

% Init table with empty columns
JASPtable = table(Participants,EDA_before,TEMP_before,HR_before,HRVZY_before, ... 
    EDA_after,TEMP_after,HR_after,HRVZY_after, ...
    EDA_stop0,TEMP_stop0,HR_stop0,HRVZY_stop0, ...
    EDA_stop1,TEMP_stop1,HR_stop1,HRVZY_stop1, ...
    EDA_stop2,TEMP_stop2,HR_stop2,HRVZY_stop2, ...
    EDA_stop3,TEMP_stop3,HR_stop3,HRVZY_stop3,...
    EDA_stop4,TEMP_stop4,HR_stop4,HRVZY_stop4, ...
    EDA_barefoot,TEMP_barefoot,HR_barefoot,HRVZY_barefoot);

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
        
        % Compute mean of HRVZY values and add to column
        meanHRVZY = mean(aves.HRVZY(:,2),'omitnan');

        tableRow = [tableRow,stdEDAslopes,medianTEMPslopes,medianHRslopes,meanHRVZY];
    end
    
    JASPtable = [JASPtable; tableRow];
    tableRow = [];
    
end 

% Save as csv file
writetable(JASPtable,strcat(OUT_DIR,'JASPtable.csv'));