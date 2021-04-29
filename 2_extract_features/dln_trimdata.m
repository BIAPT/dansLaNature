% Dannie Fu April 20 2021
% This script trims the start and end by a specified length of time and saves it  
%
% ------------------

clear;
file = "/Volumes/Seagate/danslaNature/analysis/data/Journal_final_participants/056/stop0_stumps_sitting";

load(strcat(file,".mat"));

% Length to remove in seconds 
end_length=330;
start_length=0;

% Remove end
section.EDA_window = unpadEnd(EDA_window,end_length, 15);
section.TEMP_window = unpadEnd(TEMP_window, end_length, 15);
section.HR_window = unpadEnd(HR_window, end_length, 0.3);
section.HRVZ_window = unpadEnd(HRVZ_window,end_length, 4);
section.HRVYZ_window = unpadEnd(HRVYZ_window, end_length, 4);

% Remove start
section.EDA_window = unpadBeginning(section.EDA_window,start_length, 15);
section.TEMP_window = unpadBeginning(section.TEMP_window, start_length, 15);
section.HR_window = unpadBeginning(section.HR_window, start_length, 0.3);
section.HRVZ_window = unpadBeginning(section.HRVZ_window,start_length, 4);
section.HRVYZ_window = unpadBeginning(section.HRVYZ_window,start_length, 4);

%Plot 
figure
subplot(5,1,1)
plot(unix_to_datetime(section.EDA_window(:,1)),section.EDA_window(:,2),'LineWidth',1, 'Color', '#f6a753')
ylabel("EDA (us)")
set(gca,'FontSize',14)

subplot(5,1,2)  

plot(unix_to_datetime(section.TEMP_window(:,1)),section.TEMP_window(:,2),'LineWidth',1,'Color', '#699bdd')
ylabel("Temperature (C)")
set(gca,'FontSize',14)

subplot(5,1,3)
plot(unix_to_datetime(section.HR_window(:,1)), section.HR_window(:,2),'LineWidth',1, 'Color', '#94d169')
ylabel("Heart rate")
set(gca,'FontSize',14)

subplot(5,1,4)
plot(unix_to_datetime(section.HRVYZ_window(:,1)), section.HRVYZ_window(:,2),'LineWidth',1, 'Color', '#94d169')
ylabel("HRV Z/Y")
set(gca,'FontSize',14)

subplot(5,1,5)
plot(unix_to_datetime(section.HRVZ_window(:,1)), section.HRVZ_window(:,2),'LineWidth',1, 'Color', '#94d169')
ylabel("HRV Z")
xlabel("Time (seconds)")
set(gca,'FontSize',14)

%%
save(strcat(file,'.mat'),'-struct','section');

%%

% Compute sliding averages. computeAverage[data,fs,windowsize(sec),stepsize(sec)]
ave.EDA = computeAverage(section.EDA_window, 15, 60, 1);
ave.TEMP = computeAverage(section.TEMP_window, 15, 60, 1);
ave.HR = computeAverage(section.HR_window, 0, 60, 1);
ave.HRVYZ = computeAverage(section.HRVYZ_window, 4, 60, 1);
ave.HRVZ = computeAverage(section.HRVZ_window, 4, 60, 1);

% Compute sliding slopes 
slopes.EDA = computeSlopes(section.EDA_window, 15, 60, 1);
slopes.TEMP = computeSlopes(section.TEMP_window, 15, 60, 1);
slopes.HR = computeSlopes(section.HR_window, 0, 60, 1);

 % Save aves and slopes into struct 
save(strcat(file,'_ave.mat'),'-struct','ave');
save(strcat(file,'_slopes.mat'),'-struct','slopes');
