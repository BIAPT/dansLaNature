%% Boxplots of EDA

LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/aves_goodparticipants/';

eda_1 = load(strcat(LOAD_DIR, 'eda_beforeforest_aves.mat'));
eda_2 = load(strcat(LOAD_DIR, 'eda_stop0stumps_aves.mat'));
eda_3 = load(strcat(LOAD_DIR, 'eda_walking1_aves.mat'));
eda_4 = load(strcat(LOAD_DIR, 'eda_stop1breathing_aves.mat'));
eda_5 = load(strcat(LOAD_DIR, 'eda_walking2_aves.mat'));
eda_6 = load(strcat(LOAD_DIR, 'eda_stop2oldtree_aves.mat'));
eda_7 = load(strcat(LOAD_DIR, 'eda_walking3barefoot_aves.mat'));
eda_8 = load(strcat(LOAD_DIR, 'eda_stop3ferns_aves.mat'));
eda_9 = load(strcat(LOAD_DIR, 'eda_walking4_aves.mat'));
eda_10 = load(strcat(LOAD_DIR, 'eda_stop4pinetrees_aves.mat'));
eda_11 = load(strcat(LOAD_DIR, 'eda_stop4nixon_aves.mat'));
eda_12 = load(strcat(LOAD_DIR, 'eda_walking5_aves.mat'));
eda_13 = load(strcat(LOAD_DIR, 'eda_afterforest_aves.mat'));

eda = [eda_1.eda; eda_2.eda ;eda_3.eda; eda_4.eda; eda_5.eda; ...
    eda_6.eda; eda_7.eda; eda_8.eda; eda_9.eda; eda_10.eda; ...
    eda_11.eda; eda_12.eda; eda_13.eda];

g1 = repmat({'Before'},length(eda_1.eda),1);
g2 = repmat({'Stumps'},length(eda_2.eda),1);
g3 = repmat({'walking1'},length(eda_3.eda),1);
g4 = repmat({'Breathing'},length(eda_4.eda),1);
g5 = repmat({'walking2'},length(eda_5.eda),1);
g6 = repmat({'oldtree'},length(eda_6.eda),1);
g7 = repmat({'walking3 barefoot'},length(eda_7.eda),1);
g8 = repmat({'ferns'},length(eda_8.eda),1);
g9 = repmat({'walking4'},length(eda_9.eda),1);
g10 = repmat({'pinetrees'},length(eda_10.eda),1);
g11 = repmat({'nixon'},length(eda_11.eda),1);
g12 = repmat({'walking5'},length(eda_12.eda),1);
g13 = repmat({'After'},length(eda_13.eda),1);

g = [g1; g2; g3; g4; g5; g6; g7; g8; g9; g10; g11; g12; g13];

boxplot(eda,g)
set(gca,"FontSize",14)
title("EDA aves across sections")

%% Box plot temp

LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/aves_goodparticipants/';

t_1 = load(strcat(LOAD_DIR,'temp_beforeforest_aves.mat'));
t_2 = load(strcat(LOAD_DIR,'temp_stop0stumps_aves.mat'));
t_3 = load(strcat(LOAD_DIR,'temp_walking1_aves.mat'));
t_4 = load(strcat(LOAD_DIR,'temp_stop1breathing_aves.mat'));
t_5 = load(strcat(LOAD_DIR,'temp_walking2_aves.mat'));
t_6 = load(strcat(LOAD_DIR,'temp_stop2oldtree_aves.mat'));
t_7 = load(strcat(LOAD_DIR,'temp_walking3barefoot_aves.mat'));
t_8 = load(strcat(LOAD_DIR,'temp_stop3ferns_aves.mat'));
t_9 = load(strcat(LOAD_DIR,'temp_walking4_aves.mat'));
t_10 = load(strcat(LOAD_DIR,'temp_stop4pinetrees_aves.mat'));
t_11 = load(strcat(LOAD_DIR,'temp_stop4nixon_aves.mat'));
t_12 = load(strcat(LOAD_DIR,'temp_walking5_aves.mat'));
t_13 = load(strcat(LOAD_DIR,'temp_afterforest_aves.mat'));

temp = [t_1.temp;t_2.temp;t_3.temp;t_4.temp;t_5.temp; ...
    t_6.temp;t_7.temp;t_8.temp;t_9.temp;t_10.temp; ...
    t_11.temp;t_12.temp;t_13.temp];

g1 = repmat({'Before'},length(t_1.temp),1);
g2 = repmat({'Stumps'},length(t_2.temp),1);
g3 = repmat({'walking1'},length(t_3.temp),1);
g4 = repmat({'Breathing'},length(t_4.temp),1);
g5 = repmat({'walking2'},length(t_5.temp),1);
g6 = repmat({'oldtree'},length(t_6.temp),1);
g7 = repmat({'walking3 barefoot'},length(t_7.temp),1);
g8 = repmat({'ferns'},length(t_8.temp),1);
g9 = repmat({'walking4'},length(t_9.temp),1);
g10 = repmat({'pinetrees'},length(t_10.temp),1);
g11 = repmat({'nixon'},length(t_11.temp),1);
g12 = repmat({'walking5'},length(t_12.temp),1);
g13 = repmat({'After'},length(t_13.temp),1);

g = [g1; g2; g3; g4; g5; g6; g7; g8; g9; g10; g11; g12; g13];

boxplot(temp,g)
set(gca,"FontSize",14)
title("TEMP ave across sections")

%% Box plot ave slopes hr

LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/aves_goodparticipants/';

hr_1 = load(strcat(LOAD_DIR,'hr_beforeforest_aves.mat'));
hr_2 = load(strcat(LOAD_DIR,'hr_stop0stumps_aves.mat'));
hr_3 = load(strcat(LOAD_DIR,'hr_walking1_aves.mat'));
hr_4 = load(strcat(LOAD_DIR,'hr_stop1breathing_aves.mat'));
hr_5 = load(strcat(LOAD_DIR,'hr_walking2_aves.mat'));
hr_6 = load(strcat(LOAD_DIR,'hr_stop2oldtree_aves.mat'));
hr_7 = load(strcat(LOAD_DIR,'hr_walking3barefoot_aves.mat'));
hr_8 = load(strcat(LOAD_DIR,'hr_stop3ferns_aves.mat'));
hr_9 = load(strcat(LOAD_DIR,'hr_walking4_aves.mat'));
hr_10 = load(strcat(LOAD_DIR,'hr_stop4pinetrees_aves.mat'));
hr_11 = load(strcat(LOAD_DIR,'hr_stop4nixon_aves.mat'));
hr_12 = load(strcat(LOAD_DIR,'hr_walking5_aves.mat'));
hr_13 = load(strcat(LOAD_DIR,'hr_afterforest_aves.mat'));

hr = [hr_1.hr; hr_2.hr ;hr_3.hr; hr_4.hr; hr_5.hr; ...
    hr_6.hr; hr_7.hr; hr_8.hr; hr_9.hr; hr_10.hr; ...
    hr_11.hr; hr_12.hr; hr_13.hr];

g1 = repmat({'Before'},length(hr_1.hr),1);
g2 = repmat({'Stumps'},length(hr_2.hr),1);
g3 = repmat({'walking1'},length(hr_3.hr),1);
g4 = repmat({'Breathing'},length(hr_4.hr),1);
g5 = repmat({'walking2'},length(hr_5.hr),1);
g6 = repmat({'oldtree'},length(hr_6.hr),1);
g7 = repmat({'walking3 barefoot'},length(hr_7.hr),1);
g8 = repmat({'ferns'},length(hr_8.hr),1);
g9 = repmat({'walking4'},length(hr_9.hr),1);
g10 = repmat({'pinetrees'},length(hr_10.hr),1);
g11 = repmat({'nixon'},length(hr_11.hr),1);
g12 = repmat({'walking5'},length(hr_12.hr),1);
g13 = repmat({'After'},length(hr_13.hr),1);

g = [g1; g2; g3; g4; g5; g6; g7; g8; g9; g10; g11; g12; g13];

boxplot(hr,g)
set(gca,"FontSize",14)
title("HR ave across sections")
