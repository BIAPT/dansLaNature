% Dannie Fu Sept 24 2020
% Script with some rough work
% Each section should be run seperately
% -----------

%% Unpad ending 

full.EDA = unpadEnd(EDA,540, 15);
full.TEMP = unpadEnd(TEMP, 540, 15);
full.HR = unpadEnd(HR, 540, 1);
full.HRVZY = unpadEnd(HRVZY,540, 4);

save(strcat('/Volumes/Seagate/danslaNature/2020-09-19/group2/017/','full.mat'),'-struct','full');

%% Concat data 
clear;
LOAD_DIR = '/Volumes/Seagate/danslaNature/2020-09-19/group2/018/';
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

full.EDA = [];
full.TEMP = [];
full.HR = [];
full.HRVZY = [];
nan = [NaN, NaN];

for i=1:length(subfolders)
    seg = load(strcat(LOAD_DIR, subfolders(i), "/clean.mat")); % Load preprocessed data (e.g. clean.mat) which has EDA, TEMP, HRVZY, HR 
    full.EDA = vertcat(full.EDA, nan, seg.EDA);
    full.TEMP = vertcat(full.TEMP, nan, seg.TEMP);
    full.HR = vertcat(full.HR, nan, seg.HR);
    full.HRVZY = vertcat(full.HRVZY, nan, seg.HRVZY);
end  

save(strcat(LOAD_DIR,'full.mat'),'-struct','full');

%% Plot full

clear
LOAD_DIR = "/Volumes/Seagate/danslaNature/2020-09-26/group2/";
filename1 = "/stop0_stumps_sitting_ave.mat";
filename2 = "/stop0_stumps_sitting_slopes.mat";
savename1= "sept26_group2_stop0stumps_ave.fig";
savename2= "sept26_group2_stop0stumps_slopes.fig";
PLT_TITLE_1 = "Sept 26 Group 2 Averages - stop 0 stumps";
PLT_TITLE_2 = "Sept 26 Group 2 Slopes - stop 0 stumps";

% Get subfolders (participants)
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

% Setup the plot for averages 
t1 = tiledlayout(4,1);

ax1 = nexttile;
title(PLT_TITLE_1)
ylabel("EDA (us)")
set(gca,"FontSize",14)

ax2 = nexttile;
ylabel("Temp (C)")
set(gca,"FontSize",14)

ax3 = nexttile;
ylabel("HR (bpm)")
set(gca,"FontSize",14)

ax4 = nexttile;
ylabel("HRV Z/Y (psd)")
xlabel("Time (seconds)")
set(gca,"FontSize",14)

hold(ax1,'on')
hold(ax2,'on')
hold(ax3,'on')
hold(ax4,'on')

% Setup the plot for slopes
figure
t2 = tiledlayout(3,1);

ax5 = nexttile;
title(PLT_TITLE_2)
ylabel("EDA (us)")
set(gca,"FontSize",14)

ax6 = nexttile;
ylabel("Temp (C)")
set(gca,"FontSize",14)

ax7 = nexttile;
ylabel("HR (bpm)")
set(gca,"FontSize",14)

hold(ax5,'on')
hold(ax6,'on')
hold(ax7,'on')

k=1;
% Loop through each participant folder 
for i=1:length(subfolders)     
    try
        load(strcat(LOAD_DIR, subfolders(i), filename1));
        
        if(isempty(EDA) || isempty(TEMP) || isempty(HR) || isempty(HRVZY))
            continue
        end 
        
    catch
        continue
    end
    
    legendInfo{k} = char(subfolders(i)); 
    k= k+1;

    %Plot averages
    plot(ax1, unix_to_datetime(EDA(:,1)),EDA(:,2),'LineWidth',1)
    hold(ax1,'on')
    plot(ax2,unix_to_datetime(TEMP(:,1)),TEMP(:,2),'LineWidth',1)
    hold(ax2,'on')
    plot(ax3,unix_to_datetime(HR(:,1)), HR(:,2),'LineWidth',1)
    hold(ax3,'on')
    plot(ax4,unix_to_datetime(HRVZY(:,1)), HRVZY(:,2),'LineWidth',1)
    hold(ax4,'on')
    
    %Plot slopes 
    load(strcat(LOAD_DIR, subfolders(i), filename2));
    plot(ax4, unix_to_datetime(EDA(:,1)),EDA(:,2),'LineWidth',1)
    hold(ax4,'on')
    plot(ax5,unix_to_datetime(TEMP(:,1)),TEMP(:,2),'LineWidth',1)
    hold(ax5,'on')
    plot(ax6,unix_to_datetime(HR(:,1)), HR(:,2),'LineWidth',1)
    hold(ax6,'on')
    plot(ax7,unix_to_datetime(HRVZY(:,1)), HRVZY(:,2),'LineWidth',1)
    hold(ax7,'on')
    
end 

legend(ax1,legendInfo);
legend(ax5,legendInfo);

saveas(t1,savename1);
saveas(t2,savename2);

%% Plot window
clear
LOAD_DIR = '/Volumes/Seagate/danslaNature/2020-09-26/group2/';
filename = "/stop0_stumps_sitting.mat";
savename = "sept26_group2_stop0stumps.fig";
PLT_TITLE = "Sept 26 Group 2 Stop 0: Stumps";

% Get subfolders (participants)
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

% Setup the plot
t = tiledlayout(4,1);

ax1 = nexttile;
title(PLT_TITLE)
ylabel("EDA (us)")
set(gca,"FontSize",14)

ax2 = nexttile;
ylabel("Temp (C)")
set(gca,"FontSize",14)

ax3 = nexttile;
ylabel("HR (bpm)")
set(gca,"FontSize",14)

ax4 = nexttile;
ylabel("HRV Z/Y (psd)")
xlabel("Time (seconds)")
set(gca,"FontSize",14)

hold(ax1,'on')
hold(ax2,'on')
hold(ax3,'on')
hold(ax4,'on')

k=1;
% Loop through each participant folder 
for i=1:length(subfolders)
    
    try
        load(strcat(LOAD_DIR, subfolders(i), filename));
    catch
        continue
    end
    
    legendInfo{k} = [char(subfolders(i))]; 
    k = k+1;
    
    plot(ax1, unix_to_datetime(EDA_window(:,1)),EDA_window(:,2),'LineWidth',1)
    hold(ax1,'on')
    plot(ax2,unix_to_datetime(TEMP_window(:,1)),TEMP_window(:,2),'LineWidth',1)
    hold(ax2,'on')
    plot(ax3,unix_to_datetime(HR_window(:,1)), HR_window(:,2),'LineWidth',1)
    hold(ax3,'on')
    plot(ax4,unix_to_datetime(HRVZY_window(:,1)), HRVZY_window(:,2),'LineWidth',1)
    hold(ax4,'on')
end 

legend(ax1,legendInfo);
saveas(t,savename);

