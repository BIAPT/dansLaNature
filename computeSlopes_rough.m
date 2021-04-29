% Dannie Fu April 2021
% 
% This script test different ways of computing slope. This script was
% mainly rough testing work. 

load("/Volumes/Seagate/danslaNature/analysis/data/Journal_final_participants/050/stop4_pinetrees.mat");
data = EDA_window;
fs = 15;
win_size = 60;
win_step = 1;

win_overlap = win_size - win_step; % Overlap 

data_wins = buffer(data(:,2),win_size*fs,win_overlap*fs,'nodelay');

time = data(:,1);

% 1. Divide slopes by 1/15 
slopes1 = diff(data_wins) .* 15;
aveSlopes1 = mean(slopes1(:,1:end-1)); % not taking the last slope 
stdEDAslopes1 = std(aveSlopes1,'omitnan');

time_idx = 1:win_step*fs:length(data);
num_wins = size(data_wins,2);
slopes_time = time(time_idx(1:num_wins-1));

% 2. Divide average slope in that window by 1/15
slopes2 = diff(data_wins);
aveSlopes2 = mean(slopes2(:,1:end-1)) .* 15 ; % not taking the last slope 
stdEDAslopes2 = std(aveSlopes2,'omitnan');

% 3. Divide std dev of slopes by 1/15
slopes3 = diff(data_wins);
aveSlopes3 = mean(slopes3(:,1:end-1)); % not taking the last slope 
stdEDAslopes3 = std(aveSlopes3,'omitnan')*15;

plot(unix_to_datetime(data(:,1)),data(:,2));


%% HR slopes
data = HR_window;
convert_time = (data(:,1) - data(1,1))/1000;   % convert to seconds
duration = diff(convert_time);
time = data(:,1);
i1 = 1;
i2 = find(cumsum(duration,'omitnan')>=win_size,1); % get index of last element in 60 second window
i3 = 1;

while i2 <= length(data)
    aveSlopes(i3,2) = mean(diff(data(i1:i2,2))./ diff(convert_time(i1:i2,1))); % average slopes in the window
    aveSlopes(i3,1) = time(i1);

    i3=i3+1; 
    i1=i2+1;
    i2=find(cumsum(duration(i1:end),'omitnan')>=win_size,1) + i1-1;
    if isempty(i2), break, end
end


    
   