% Dannie Fu November 6 2020
% This script plots a single participants boxplot of their
% ave eda and temp slopes and ave hr value across sections 
% -----------------

clear

LOAD_DIR = '/Volumes/Seagate/danslaNature/data/';
OUT_DIR = '/Volumes/Seagate/danslaNature/analysis/individual_boxplots/';

% There are only 10 participants with full data: [1,2,8,9,11,13,16,21,37,54]
plotIndBoxplots(LOAD_DIR, OUT_DIR,'2020-09-27/group2/','057'); 

%%
function plotIndBoxplots(LOAD_DIR,OUT_DIR, group,participant)

slopes_1 = load(strcat(LOAD_DIR, group, participant,'/before_forest_slopes.mat'));
slopes_2 = load(strcat(LOAD_DIR, group, participant,'/stop0_stumps_sitting_slopes.mat'));
slopes_3 = load(strcat(LOAD_DIR, group, participant,'/walking1_slopes.mat'));
slopes_4 = load(strcat(LOAD_DIR, group, participant,'/stop1_breathing_slopes.mat'));
slopes_5 = load(strcat(LOAD_DIR, group, participant,'/walking2_slopes.mat'));
slopes_6 = load(strcat(LOAD_DIR, group, participant,'/stop2_oldtree_slopes.mat'));
slopes_7 = load(strcat(LOAD_DIR, group, participant,'/walking3_barefoot_slopes.mat'));
slopes_8 = load(strcat(LOAD_DIR, group, participant,'/stop3_ferns_slopes.mat'));
slopes_9 = load(strcat(LOAD_DIR, group, participant,'/walking4_slopes.mat'));
slopes_10 = load(strcat(LOAD_DIR, group, participant,'/stop4_pinetrees_slopes.mat'));
%slopes_11 = load(strcat(LOAD_DIR, group, participant,'/stop4_nixon_slopes.mat'));
slopes_12 = load(strcat(LOAD_DIR, group, participant,'/walking5_slopes.mat'));
slopes_13 = load(strcat(LOAD_DIR, group, participant,'/after_forest_slopes.mat'));

eda = [slopes_1.EDA(:,2); slopes_2.EDA(:,2) ;slopes_3.EDA(:,2); slopes_4.EDA(:,2); slopes_5.EDA(:,2); ...
    slopes_6.EDA(:,2); slopes_7.EDA(:,2); slopes_8.EDA(:,2); slopes_9.EDA(:,2); slopes_10.EDA(:,2); ...
    slopes_12.EDA(:,2); slopes_13.EDA(:,2)];

g1 = repmat({'Before'},length(slopes_1.EDA),1);
g2 = repmat({'Stumps'},length(slopes_2.EDA),1);
g3 = repmat({'walking1'},length(slopes_3.EDA),1);
g4 = repmat({'Breathing'},length(slopes_4.EDA),1);
g5 = repmat({'walking2'},length(slopes_5.EDA),1);
g6 = repmat({'oldtree'},length(slopes_6.EDA),1);
g7 = repmat({'walking3 barefoot'},length(slopes_7.EDA),1);
g8 = repmat({'ferns'},length(slopes_8.EDA),1);
g9 = repmat({'walking4'},length(slopes_9.EDA),1);
g10 = repmat({'pinetrees'},length(slopes_10.EDA),1);
%g11 = repmat({'nixon'},length(slopes_11.eda),1);
g12 = repmat({'walking5'},length(slopes_12.EDA),1);
g13 = repmat({'After'},length(slopes_13.EDA),1);

g = [g1; g2; g3; g4; g5; g6; g7; g8; g9; g10; g12; g13];

figure
boxplot(eda,g)
set(gca,"FontSize",14)
title("EDA ave slopes across sections")
saveas(gcf,strcat(OUT_DIR,participant,'eda'));

temp = [slopes_1.TEMP(:,2); slopes_2.TEMP(:,2) ;slopes_3.TEMP(:,2); slopes_4.TEMP(:,2); slopes_5.TEMP(:,2); ...
    slopes_6.TEMP(:,2); slopes_7.TEMP(:,2); slopes_8.TEMP(:,2); slopes_9.TEMP(:,2); slopes_10.TEMP(:,2); ...
    slopes_12.TEMP(:,2); slopes_13.TEMP(:,2)];

g1 = repmat({'Before'},length(slopes_1.TEMP),1);
g2 = repmat({'Stumps'},length(slopes_2.TEMP),1);
g3 = repmat({'walking1'},length(slopes_3.TEMP),1);
g4 = repmat({'Breathing'},length(slopes_4.TEMP),1);
g5 = repmat({'walking2'},length(slopes_5.TEMP),1);
g6 = repmat({'oldtree'},length(slopes_6.TEMP),1);
g7 = repmat({'walking3 barefoot'},length(slopes_7.TEMP),1);
g8 = repmat({'ferns'},length(slopes_8.TEMP),1);
g9 = repmat({'walking4'},length(slopes_9.TEMP),1);
g10 = repmat({'pinetrees'},length(slopes_10.TEMP),1);
%g11 = repmat({'nixon'},length(slopes_11.eda),1);
g12 = repmat({'walking5'},length(slopes_12.TEMP),1);
g13 = repmat({'After'},length(slopes_13.TEMP),1);

g = [g1; g2; g3; g4; g5; g6; g7; g8; g9; g10; g12; g13];

figure
boxplot(temp,g)
set(gca,"FontSize",14)
title("TEMP ave slopes across sections")
saveas(gcf,strcat(OUT_DIR,participant,'temp'));

hr_1 = load(strcat(LOAD_DIR, group, participant,'/before_forest_ave.mat'));
hr_2 = load(strcat(LOAD_DIR, group, participant,'/stop0_stumps_sitting_ave.mat'));
hr_3 = load(strcat(LOAD_DIR, group, participant,'/walking1_ave.mat'));
hr_4 = load(strcat(LOAD_DIR, group, participant,'/stop1_breathing_ave.mat'));
hr_5 = load(strcat(LOAD_DIR, group, participant,'/walking2_ave.mat'));
hr_6 = load(strcat(LOAD_DIR, group, participant,'/stop2_oldtree_ave.mat'));
hr_7 = load(strcat(LOAD_DIR, group, participant,'/walking3_barefoot_ave.mat'));
hr_8 = load(strcat(LOAD_DIR, group, participant,'/stop3_ferns_ave.mat'));
hr_9 = load(strcat(LOAD_DIR, group, participant,'/walking4_ave.mat'));
hr_10 = load(strcat(LOAD_DIR, group, participant,'/stop4_pinetrees_ave.mat'));
%hr_11 = load(strcat(LOAD_DIR, group, participant,'/stop4_nixon_ave.mat'));
hr_12 = load(strcat(LOAD_DIR, group, participant,'/walking5_ave.mat'));
hr_13 = load(strcat(LOAD_DIR, group, participant,'/after_forest_ave.mat'));

hr = [hr_1.HR(:,2); hr_2.HR(:,2) ;hr_3.HR(:,2); hr_4.HR(:,2); hr_5.HR(:,2); ...
    hr_6.HR(:,2); hr_7.HR(:,2); hr_8.HR(:,2); hr_9.HR(:,2); hr_10.HR(:,2); ...
    hr_12.HR(:,2); hr_13.HR(:,2)];

g1 = repmat({'Before'},length(hr_1.HR),1);
g2 = repmat({'Stumps'},length(hr_2.HR),1);
g3 = repmat({'walking1'},length(hr_3.HR),1);
g4 = repmat({'Breathing'},length(hr_4.HR),1);
g5 = repmat({'walking2'},length(hr_5.HR),1);
g6 = repmat({'oldtree'},length(hr_6.HR),1);
g7 = repmat({'walking3 barefoot'},length(hr_7.HR),1);
g8 = repmat({'ferns'},length(hr_8.HR),1);
g9 = repmat({'walking4'},length(hr_9.HR),1);
g10 = repmat({'pinetrees'},length(hr_10.HR),1);
%g11 = repmat({'nixon'},length(hr_11.HR),1);
g12 = repmat({'walking5'},length(hr_12.HR),1);
g13 = repmat({'After'},length(hr_13.HR),1);

g = [g1; g2; g3; g4; g5; g6; g7; g8; g9; g10; g12; g13];

figure
boxplot(hr,g)
set(gca,"FontSize",14)
title("HR ave across sections")
saveas(gcf,strcat(OUT_DIR,participant,'hr'));

end 


