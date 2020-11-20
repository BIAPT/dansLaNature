% Dannie Fu September 15 2020
% This script computes 2 basic measures (average level, average slope) for
% EDA, TEMP, HRV over a specified time interval
%
% ------------------

%% Input Params 
clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/2020-09-19/group1/';
OUT_DIR = LOAD_DIR;

segment_name = "stop0_stumps_sitting";
t1 = '2020-09-19 10:53:00';
t2 = '2020-09-19 11:05:00';

%%

start_time = datetime(t1,'InputFormat','yyyy-MM-dd HH:mm:ss','TimeZone','America/New_York'); 
end_time = datetime(t2,'InputFormat','yyyy-MM-dd HH:mm:ss','TimeZone','America/New_York');

% Get subfolders (participants)
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

% Loop through each participant folder 
for i=1:length(subfolders)
    try
        load(strcat(LOAD_DIR, subfolders(i), "/full.mat"));
    catch
        load(strcat(LOAD_DIR, subfolders(i), "/clean.mat"));
    end 
    
    % Find the window in data by finding the closest time to t1 and t2.
    EDA_time = unix_to_datetime(EDA(:,1));
    [~, EDA_idx_start] = min(abs(EDA_time - start_time));
    [~, EDA_idx_end] = min(abs(EDA_time - end_time));
    segment.EDA_window = [EDA(EDA_idx_start:EDA_idx_end, 1) EDA(EDA_idx_start:EDA_idx_end, 2)];
    segmentIdxs.EDA_idx = [EDA_idx_start EDA_idx_end];
    
    % Check if there is enough data (min 60 seconds/ 900 samples) in the window; if not, skip to next participant
    if (EDA_idx_end - EDA_idx_start < 900)
        continue
    end 

    TEMP_time = unix_to_datetime(TEMP(:,1));
    [~, TEMP_idx_start] = min(abs(TEMP_time - start_time));
    [~, TEMP_idx_end] = min(abs(TEMP_time - end_time));
    segment.TEMP_window = [TEMP(TEMP_idx_start:TEMP_idx_end, 1) TEMP(TEMP_idx_start:TEMP_idx_end, 2)];
    segmentIdxs.TEMP_idx = [TEMP_idx_start TEMP_idx_end];

    HR_time = unix_to_datetime(HR(:,1));
    [~, HR_idx_start] = min(abs(HR_time - start_time));
    [~, HR_idx_end] = min(abs(HR_time - end_time));
    segment.HR_window = [HR(HR_idx_start:HR_idx_end, 1) HR(HR_idx_start:HR_idx_end, 2)];
    segmentIdxs.HR_idx = [HR_idx_start HR_idx_end];

    HRVZY_time = unix_to_datetime(HRVZY(:,1));
    [~, HRVZY_idx_start] = min(abs(HRVZY_time - start_time));
    [~, HRVZY_idx_end] = min(abs(HRVZY_time - end_time));
    segment.HRVZY_window = [HRVZY(HRVZY_idx_start:HRVZY_idx_end, 1) HRVZY(HRVZY_idx_start:HRVZY_idx_end, 2)];
    segmentIdxs.HRVZY_idx = [HRVZY_idx_start HRVZY_idx_end];
    
    % Compute sliding averages. computeAverage[data,fs,windowsize(sec),stepsize(sec)]
    ave.EDA = computeAverage(segment.EDA_window, 15, 60, 1);
    ave.TEMP = computeAverage(segment.TEMP_window, 15, 60, 1);
    ave.HR = computeAverage(segment.HR_window, 0, 60, 1);
    ave.HRVZY = computeAverage(segment.HRVZY_window, 4, 60, 1);
   
    % Compute sliding slopes 
    slopes.EDA = computeSlopes(segment.EDA_window, 15, 60, 1);
    slopes.TEMP = computeSlopes(segment.TEMP_window, 15, 60, 1);
    slopes.HR = computeSlopes(segment.HR_window, 0, 60, 1);
    
    % Save the windows and idxs
    save(strcat(OUT_DIR,char(subfolders(i)),'/',segment_name,'.mat'),'-struct', 'segment');
    save(strcat(OUT_DIR,char(subfolders(i)),'/',segment_name,'_idxs','.mat'),'-struct', 'segmentIdxs');

    % Save aves and slopes into struct 
    save(strcat(OUT_DIR,char(subfolders(i)),'/',segment_name,'_ave.mat'),'-struct','ave');
    save(strcat(OUT_DIR,char(subfolders(i)),'/',segment_name,'_slopes.mat'),'-struct','slopes');
    
end 