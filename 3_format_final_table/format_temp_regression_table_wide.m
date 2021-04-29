% Dannie Fu March 5 2021
% This script will format a data table with the following columns:
% participant | medTEMPslopes | medTEMP | aveTEMP | stdChangeBetweenStops | meanDailyTemperature | TimeofDay
%
% Note: median, means, std are taken across all stops for each participant.
% ------------------

clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/data/Journal_final_participants/';
OUT_DIR = '/Volumes/Seagate/danslaNature/analysis/statistical_analysis/2_final_analysis/DataTables/';
SAVE_NAME = 'dln_tempregression_wide';

D = dir(LOAD_DIR);
participants = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

% Columns of table 
Participant = [];
medTEMPslopes = [];
medTEMP = [];
aveTEMP = [];
stdChangeBetweenStops = [];
meanDailyTemperature = [];
TimeofDay = [];

% Init table with empty columns
dataTable = table(Participant,medTEMPslopes,medTEMP,aveTEMP,stdChangeBetweenStops,meanDailyTemperature,TimeofDay);

stops = {'before_forest','stop0_stumps_sitting','stop1_breathing','stop2_oldtree','walking3_barefoot','stop3_ferns','stop4_pinetrees','after_forest'};
group1_participants = [1,2,3,4,5,6,7,8,9,10];
group2_participants = [11,12,13,14,15,16,17,18,19,20];
group3_participants = [21,22,23,24,25,26,27];
group4_participants = [28,29,30,31,32,35,36,37,38,39];
group5_participants = [33,34,40,41,42,43,44,45,46,47];
group6_participants = [48,49,50,51,52,53,54,55,56,57,58];
day1_temp = 3.95;
day2_temp = 19.5;
day3_temp = 20.45;

% Loop through each participant 
for k=1:length(participants)
    
    % Get group of participant
    participant = str2double(participants(k));

    if any(ismember(group1_participants,participant))
        TimeofDay = 1;
        meanDailyTemperature = day1_temp;
    elseif any(ismember(group2_participants,participant))
        TimeofDay = 2;
        meanDailyTemperature = day1_temp;
    elseif any(ismember(group3_participants,participant))
        TimeofDay = 1;
        meanDailyTemperature = day2_temp;
    elseif any(ismember(group4_participants,participant))
        TimeofDay = 2;
        meanDailyTemperature = day2_temp;
    elseif any(ismember(group5_participants,participant))
        TimeofDay = 1;
        meanDailyTemperature = day3_temp;
    elseif any(ismember(group6_participants,participant))
        TimeofDay = 2;
        meanDailyTemperature = day3_temp;
    end 
        

    allMedianTempSlopeVals = zeros(1,8);
    allMedianTempAveVals = zeros(1,8);
    allMeanTempAveVals = zeros(1,8);
    
    % Load all stops except for the walking sections for this
    % participant
    for i=1:length(stops)  
        try
            slopes = load(strcat(LOAD_DIR,char(participants(k)),'/',char(stops(i)),'_slopes.mat')); 
            aves = load(strcat(LOAD_DIR,char(participants(k)),'/',char(stops(i)),'_ave.mat')); 
        catch
            slopes.TEMP = [nan, nan];
            aves.TEMP = [nan, nan];
        end 
            allMedianTempSlopeVals(i) = median(slopes.TEMP(:,2),'omitnan');
            allMedianTempAveVals(i) = median(aves.TEMP(:,2),'omitnan');
            allMeanTempAveVals(i) = mean(aves.TEMP(:,2),'omitnan');      
    end 
    
    % Compute median, mean, std of temperature over all stops
    medTEMPslopes = median(allMedianTempSlopeVals,'omitnan');
    medTEMP = median(allMedianTempAveVals,'omitnan');
    aveTEMP = mean(allMeanTempAveVals,'omitnan');
    stdChangeBetweenStops = std(diff(allMedianTempAveVals),'omitnan');
    
    tableRow = {participant,medTEMPslopes,medTEMP,aveTEMP,stdChangeBetweenStops,meanDailyTemperature,TimeofDay};
    
    dataTable = [dataTable; tableRow];
    tableRow = [];
end 

% Save as csv file
writetable(dataTable,strcat(OUT_DIR,SAVE_NAME,'.csv'));
