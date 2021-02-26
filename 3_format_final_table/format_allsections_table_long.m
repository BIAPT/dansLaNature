% Dannie Fu Novemeber 23 2020
%
% This script formats the danslanature data into a long format so that it can be input into
% JASP or SAS and saves it as a csv file. 
%
% Note: baseline POMS needs to be added in manually.
%
% ------------------

clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/data/Journal_final_participants/';
OUT_DIR = '/Volumes/Seagate/danslaNature/analysis/statistical_analysis/2_final_analysis/DataTables/';
SAVE_NAME = 'dln_mixedmodel_long_witheffects';

stops = {'before_forest','after_forest','stop0_stumps_sitting','stop1_breathing','stop2_oldtree','stop3_ferns','stop4_pinetrees','walking3_barefoot'};
D = dir(LOAD_DIR);
participants = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

group1_participants = [1,2,3,4,5,6,7,8,9,10];
group2_participants = [11,12,13,14,15,16,17,18,19,20];
group3_participants = [21,22,23,24,25,26,27];
group4_participants = [28,29,30,31,32,35,36,37,38,39];
group5_participants = [33,34,40,41,42,43,44,45,46,47];
group6_participants = [48,49,50,51,52,53,54,55,56,57,58];

day1_temp = 3.95;
day2_temp = 19.5;
day3_temp = 20.45;

% Columns of table
participant = [];
group = [];
meanDailyTemperature = [];
stop = [];
stdEDAslopes = [];
medTEMPslopes = [];
medHRslopes = [];
aveHR = [];

% Init table with empty columns
dataTable = table(participant,group,meanDailyTemperature,stop,stdEDAslopes,medTEMPslopes,medHRslopes,aveHR);

tableRow = [];

% Loop through each participant 
for k=1:length(participants)
    
    % Get group of participant
    participant = str2double(participants(k))

    if any(ismember(group1_participants,participant))
        group = 1;
        meanDailyTemperature = day1_temp;
    elseif any(ismember(group2_participants,participant))
        group = 2;
        meanDailyTemperature = day1_temp;
    elseif any(ismember(group3_participants,participant))
        group = 3;  
        meanDailyTemperature = day2_temp;
    elseif any(ismember(group4_participants,participant))
        group = 4;
        meanDailyTemperature = day2_temp;
    elseif any(ismember(group5_participants,participant))
        group = 5;
        meanDailyTemperature = day3_temp;
    elseif any(ismember(group6_participants,participant))
        group = 6;
        meanDailyTemperature = day3_temp;
    end 
        
    % Load all sections except for the walking sections for this
    % participant
    for i=1:length(stops)

        % Load the slopes for EDA, HR, TEMP in that window
        try
            slopes = load(strcat(LOAD_DIR,char(participants(k)),'/',char(stops(i)),'_slopes.mat')); 
            aves = load(strcat(LOAD_DIR,char(participants(k)),'/',char(stops(i)),'_ave.mat')); 
                      
            % Compute the standard deviation of the EDA slopes and add to
            % column
            stdEDAslopes = std(slopes.EDA(:,2),'omitnan');

            % Compute the median of the HR and TEMP slopes and add to
            % column
            medianHRslopes = median(slopes.HR(:,2),'omitnan');
            medianTEMPslopes = median(slopes.TEMP(:,2),'omitnan');

            % Compute mean of HR
            meanHR = mean(aves.HR(:,2),'omitnan');
            
        catch 
            stdEDAslopes = nan;
            medianHRslopes = nan;
            medianTEMPslopes = nan;
            meanHR = nan;
        end 

        tableRow = [participant,group,meanDailyTemperature, stops(i), stdEDAslopes,medianTEMPslopes,medianHRslopes,meanHR];

        dataTable = [dataTable; tableRow];
        tableRow = [];
    end
    
end 

% Save as csv file
writetable(dataTable,strcat(OUT_DIR,SAVE_NAME,'.csv'));