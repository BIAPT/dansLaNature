% Dannie Fu September 15 2020
% This script computes 2 basic measures (average level, average slope) for
% EDA, TEMP, HRV over a specified time interval
%
% ------------------

%% Input Params 
clear;

% Load table with timstamps for a group
timestamps = readtable('/Users/biomusic/OneDrive - McGill University/dansLaNature/Section Timestamps/sept19_group1_timestamps.csv','PreserveVariableNames',true);
LOAD_DIR = "/Volumes/Seagate/danslaNature/analysis/2020-09-19/group1/testgroup/";
OUT_DIR = LOAD_DIR;

%%

% Get subfolders (participants)
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

% Loop through each participant folder 
for i=1:length(subfolders)
    load(strcat(LOAD_DIR, subfolders(i), "/clean.mat"));
    
    % Loop through the rows of the timestamps table. Each row is a section.
    for j = 1:size(timestamps,1)
        start_time = datetime(timestamps.start(j),'InputFormat','yyyy-MM-dd HH:mm:ss','TimeZone','America/New_York');
        end_time = datetime(timestamps.end(j),'InputFormat','yyyy-MM-dd HH:mm:ss','TimeZone','America/New_York');
        segment_name = char(timestamps.stop(j));
        
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

        HRVYZ_time = unix_to_datetime(HRVYZ(:,1));
        [~, HRVYZ_idx_start] = min(abs(HRVYZ_time - start_time));
        [~, HRVYZ_idx_end] = min(abs(HRVYZ_time - end_time));
        segment.HRVYZ_window = [HRVYZ(HRVYZ_idx_start:HRVYZ_idx_end, 1) HRVYZ(HRVYZ_idx_start:HRVYZ_idx_end, 2)];
        segmentIdxs.HRVYZ_idx = [HRVYZ_idx_start HRVYZ_idx_end];

        HRVZ_time = unix_to_datetime(HRVZ(:,1));
        [~, HRVZ_idx_start] = min(abs(HRVZ_time - start_time));
        [~, HRVZ_idx_end] = min(abs(HRVZ_time - end_time));
        segment.HRVZ_window = [HRVZ(HRVZ_idx_start:HRVZ_idx_end, 1) HRVZ(HRVZ_idx_start:HRVZ_idx_end, 2)];
        segmentIdxs.HRVZ_idx = [HRVZ_idx_start HRVZ_idx_end];

        % Compute sliding averages. computeAverage[data,fs,windowsize(sec),stepsize(sec)]
        ave.EDA = computeAverage(segment.EDA_window, 15, 60, 1);
        ave.TEMP = computeAverage(segment.TEMP_window, 15, 60, 1);
        ave.HR = computeAverage(segment.HR_window, 0, 60, 1);
        ave.HRVYZ = computeAverage(segment.HRVYZ_window, 4, 60, 1);
        ave.HRVZ = computeAverage(segment.HRVZ_window, 4, 60, 1);

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
            
end 
     
    
 