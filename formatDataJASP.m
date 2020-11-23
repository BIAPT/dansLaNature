% Dannie Fu Novemeber 23 2020
%
% This script formats the danslanature data so that it can be input into
% JASP and saves it as a csv file. 
%
% Table format:
% Participant | section | stdEDA | medianTEMP | medianHR 
%      1      | before  | 0.13 . |  32        |   75 
% ------------------

% Good participants: 1,2,8,9,11,13,16,21,37,54
clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/data/final_participants/';
OUT_DIR = '/Volumes/Seagate/danslaNature/data/';
sections = {'before_forest','after_forest','stop0_stumps_sitting','stop1_breathing','stop2_oldtree','stop3_ferns','stop4_pinetrees','walking3_barefoot'};
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

% Columns of JASP table
Participants = [];
Section = [];
stdEDA = [];
medianTEMP = [];
medianHR = [];

% Loop through each participant 
for k=1:length(subfolders)
    
    % Load all sections except for the walking sections for this
    % participant
    for i=1:length(sections)

        % Load the slopes for EDA, HR, TEMP in that window
        load(strcat(LOAD_DIR,char(subfolders(k)),'/',char(sections(i)),'_slopes.mat')); 

        % Compute the standard deviation of the EDA slopes and add to
        % column
        stdEDA = [stdEDA;std(EDA(:,2))];

        % Compute the median of the HR and TEMP slopes and add to
        % column
        medianHR = [medianHR; median(HR(:,2))];
        medianTEMP = [medianTEMP; median(TEMP(:,2))];

        Participants = [Participants; (subfolders(k))];
        Section = [Section; sections(i)];
    end
end 

% Create table that will be saved as csv and loaded into JASP
JASPtable = table(Participants,Section,stdEDA,medianTEMP,medianHR);

% Save as csv file
writetable(JASPtable,strcat(OUT_DIR,'JASPtable.csv'));