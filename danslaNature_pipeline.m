% Dannie Fu September 15 2020
% This script computes 2 basic measures (average level, average slope) for
% EDA, TEMP, HRV over a 5 minute window
%
% 
% ------------------
clear

LOAD_DIR = '/Volumes/Seagate/danslaNature/Participants/';
OUT_DIR = '/Volumes/Seagate/danslaNature/Participants/';
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

% TODO: compute nEDR, HR 
% TODO: allow to select 5 minute window 

% Loop through each participant folder 
for i=1:length(subfolders)
    files = load(strcat(subfolders(i), "/clean.mat")); % Load preprocessed data (e.g. clean.mat) which has EDA, TEMP, HRVZY, HR 

    % Compute sliding averages. computeAverage[data,fs,windowsize,stepsize]
     ave.EDA = computeAverage(files.EDA, 15, 5, 1);
     ave.TEMP = computeAverage(files.TEMP, 15, 5, 1);
     ave.HRVZY = computeAverage(files.HRVZY, 4, 5, 1);
    
    % Compute sliding slopes 
    slopes.EDA = computeSlopes(files.EDA, 15, 5, 1);
    slopes.TEMP = computeSlopes(files.TEMP, 15, 5, 1);
    slopes.HRV = computeSlopes(files.HRVZY, 4, 5, 1);
    
    % Save into struct 
    save(strcat(OUT_DIR,char(subfolders(i)),'/','ave.mat'),'-struct','ave');
    save(strcat(OUT_DIR,char(subfolders(i)),'/','slopes.mat'),'-struct','slopes');
    
end 


function averages = computeAverage(data, fs, win_size, win_step)  
% Input: 
% data - data [time, data]
% fs - sampling rate
% win)size - window size in minutes
% win_step - step size in minutes

win_overlap = win_size - win_step; % Overlap 
data_wins = buffer(data(:,2),win_size*60*fs,win_overlap*60*fs,'nodelay');

averages = mean(data_wins);

end 

function aveSlopes = computeSlopes(data, fs, win_size, win_step)  
% Input: 
% data - data [time, data]
% fs - sampling rate
% winsize - window size in minutes
% winstep - step size in minutes

win_overlap = win_size - win_step; % Overlap 
data_wins = buffer(data(:,2),win_size*60*fs,win_overlap*60*fs,'nodelay');

slopes = diff(data_wins);
aveSlopes = mean(slopes);

end 

    
    