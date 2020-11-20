function averages = computeAverage(data, fs, win_size, win_step)  
% Input: 
% data - data [time, data]
% fs - sampling rate
% win_size - window size in  seconds
% win_step - step size in seconds

time = data(:,1);  

% HR doesn't have fs so have to do it based on duration of previous point
if fs == 0
    convert_time = (data(:,1) - data(1,1))/1000;   % convert 
    duration = diff(convert_time);
    averages = [];
    
    i1 = 1;
    i2 = find(cumsum(duration)>=win_size,1);
    i3 = 1;
    
    while i2 <= length(data)
      averages(i3,2) = mean(data(i1:i2,2));
      averages(i3,1) = time(i1);
      i3=i3+1; 
      i1=i2+1;
      i2=find(cumsum(duration(i1:end))>=win_size,1) + i1-1;
      if isempty(i2), break, end
    end 
else 
    win_overlap = win_size - win_step; % Overlap 
    data_wins = buffer(data(:,2),win_size*fs,win_overlap*fs,'nodelay');

    averages(:,2) = mean(data_wins);
    time_idx = 1:win_step*fs:length(data);
    num_wins = size(data_wins,2);
    averages(:,1) = time(time_idx(1:num_wins));
end 

end 