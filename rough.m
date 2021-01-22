% Dannie Fu Sept 24 2020
% Script with some rough work
% Each section should be run seperately
% -----------

%% Unpad ending of full data

clean.EDA = unpadEnd(EDA,0, 15);
clean.TEMP = unpadEnd(TEMP, 0, 15);
clean.HR = unpadEnd(HR, 0, 1);
clean.HRVX = unpadEnd(HRVX,60, 4);
clean.HRVY = unpadEnd(HRVY,60, 4);
clean.HRVZ = unpadEnd(HRVZ,60, 4);
clean.HRVYZ = unpadEnd(HRVYZ,60, 4);

save(strcat('/Volumes/Seagate/danslaNature/analysis/2020-09-19/group1/008/','clean.mat'),'-struct','clean');

%% Unpad ending of section 

after_forest.EDA_window = unpadEnd(EDA_window,60, 15);
after_forest.TEMP_window = unpadEnd(TEMP_window, 60, 15);
after_forest.HR_window = unpadEnd(HR_window, 60, 1);
after_forest.HRVZ_window = unpadEnd(HRVZ_window,60, 4);
after_forest.HRVYZ_window = unpadEnd(HRVYZ_window,60, 4);

save(strcat('/Volumes/Seagate/danslaNature/analysis/2020-09-19/group2/013/','before_forest.mat'),'-struct','before_forest');

%% Unpad beginning of section


walking3_barefoot.EDA_window = unpadBeginning(EDA_window,60, 15);
walking3_barefoot.TEMP_window = unpadBeginning(TEMP_window, 60, 15);
walking3_barefoot.HR_window = unpadBeginning(HR_window, 60, 1);
walking3_barefoot.HRVZ_window = unpadBeginning(HRVZ_window,60, 4);
walking3_barefoot.HRVYZ_window = unpadBeginning(HRVYZ_window,60, 4);

save(strcat('/Volumes/Seagate/danslaNature/analysis/2020-09-19/group2/011/','walking3_barefoot.mat'),'-struct','walking3_barefoot');
%% Concat data 
clear;
LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/final_participants/011/';
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
    full.HRVX = vertcat(full.HRVZY, nan, seg.HRVX);
    full.HRVY = vertcat(full.HRVZY, nan, seg.HRVY);
    full.HRVY = vertcat(full.HRVZY, nan, seg.HRVZ);
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

%% Temperature Analysis 
clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/final_participants/';
sections = {'before_forest','stop0_stumps_sitting','stop1_breathing','stop2_oldtree','walking3_barefoot','stop3_ferns','stop4_pinetrees','after_forest'};

% Get subfolders (participants)
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D
        
T19_1 = [];
T19_2 = [];
T26_1 = [];
T27_1 = [];
T27_2 = [];
sept19_group1_temps = [];
sept19_group2_temps = [];
sept26_group1_temps = [];
sept27_group1_temps = [];
sept27_group2_temps = [];

for j=1:length(sections)
    
    for i=1:length(subfolders)   
        load(strcat(LOAD_DIR,char(subfolders(i)),"/",char(sections(j)), ".mat"));

        % Sept 19 group 1 
        if subfolders(i) == "001" || subfolders(i) == "002" || subfolders(i) == "008" || subfolders(i) == "009"        
            sept19_group1_temps = [sept19_group1_temps; TEMP_window(:,2)];
        
        % Sept 19 group 2   
        elseif subfolders(i) == "011" || subfolders(i) == "013" || subfolders(i) == "016"
            sept19_group2_temps = [sept19_group2_temps; TEMP_window(:,2)];
        
         % Sept 26 group 1   
        elseif subfolders(i) == "021"
            sept26_group1_temps = [sept26_group1_temps; TEMP_window(:,2)];
            
        % Sept 27 group 1   
        elseif subfolders(i) == "047"
            sept27_group1_temps = [sept27_group1_temps; TEMP_window(:,2)];
            
        % Sept 27 group 1   
        elseif subfolders(i) == "050"
            sept27_group2_temps = [sept27_group2_temps; TEMP_window(:,2)];
        
        end
        
        sept19_group1_temp_aves = mean(sept19_group1_temps,"omitnan");
        sept19_group2_temp_aves = mean(sept19_group2_temps,"omitnan");
        sept26_group1_temp_aves = mean(sept26_group1_temps,"omitnan");
        sept27_group1_temp_aves = mean(sept27_group1_temps,"omitnan");
        sept27_group2_temp_aves = mean(sept27_group2_temps,"omitnan");

    end 
    
    T19_1 = [T19_1,sept19_group1_temp_aves];
    T19_2 = [T19_2,sept19_group2_temp_aves]; 
    T26_1 = [T26_1,sept26_group1_temp_aves]; 
    T27_1 = [T27_1,sept27_group1_temp_aves]; 
    T27_2 = [T27_2,sept27_group2_temp_aves]; 
end 

plot(T19_1); hold on; plot(T19_2); hold on;  plot(T26_1); hold on;  plot(T27_1);hold on;  plot(T27_2);
set(gca,'FontSize',14);
title("Ave TEMP across sections");
legend("19_1", "19_2","26_1","27_1","27_2");
%% Compute average slopes across sections for  sept 26, sept 27 groups together and sept 19 
clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/final_participants/';
sections = {'before_forest','stop0_stumps_sitting','stop1_breathing','stop2_oldtree','walking3_barefoot','stop3_ferns','stop4_pinetrees','after_forest'};

% Get subfolders (participants)
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

temp_slopes_19 = [];
temp_slopes_2627 = [];
T_19 = [];
T_26_27 = [];

for j=1:length(sections)
    
    for i=1:length(subfolders)  
        load(strcat(LOAD_DIR,char(subfolders(i)),"/",char(sections(j)), "_slopes.mat"));
        
         if subfolders(i) == "021" || subfolders(i) == "047" || subfolders(i) == "050" 
            temp_slopes_2627 = [temp_slopes_2627; TEMP(:,2)];
            
         else 
             temp_slopes_19 = [temp_slopes_19; TEMP(:,2)];

         end 
         
         ave_temp_slopes_2627 = mean(temp_slopes_2627,"omitnan");
         ave_temp_slopes_19 = mean(temp_slopes_19,"omitnan");

    end 
    
    T_26_27 = [T_26_27,ave_temp_slopes_2627];
    T_19 = [T_19,ave_temp_slopes_19];

end 

plot(T_19); hold on; plot(T_26_27);
set(gca,'FontSize',14);
title("Ave TEMP slopes across sections");
legend("Sept 19", "Sept 26, Sept 27");




