function aveSlopes = computeSlopes(data, fs, win_size, win_step)  
% Input: 
% data - data [time, data]
% fs - sampling rate
% winsize - window size in seconds
% winstep - step size in seconds

time = data(:,1);
aveSlopes = [];


% HR doesn't have fs so have to do it based on duration of previous point
if fs == 0
    convert_time = (data(:,1) - data(1,1))/1000;   % convert 
    duration = diff(convert_time);
    
    i1 = 1;
    i2 = find(cumsum(duration)>=win_size,1);
    i3 = 1;
    
    while i2 <= length(data)
        aveSlopes(i3,2) = mean(diff(data(i1:i2,2))); % average slopes
        aveSlopes(i3,1) = time(i1);
        
        i3=i3+1; 
        i1=i2+1;
        i2=find(cumsum(duration(i1:end),'omitnan')>=win_size,1) + i1-1;
        if isempty(i2), break, end
    end
else 
    win_overlap = win_size - win_step; % Overlap 
    
    % Buffer will 0 pad the last window if there are not enough samples to fill it in. 
    % This will make the last slope extremely large compared to the rest -
    % need to remove it
    data_wins = buffer(data(:,2),win_size*fs,win_overlap*fs,'nodelay');

    slopes = diff(data_wins);
    aveSlopes(:,2) = mean(slopes(:,1:end-1)); % not taking the last slope 
    time_idx = 1:win_step*fs:length(data);
    num_wins = size(data_wins,2);
    aveSlopes(:,1) = time(time_idx(1:num_wins-1));
    
end 

end 

    
   