% Dannie Fu June 7 2020
% This script computes the average skin temperature for day 1 and day2,3
% participants
%
% ------------------

%%
clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/analysis/data/Journal_final_participants/';

% Get subfolders (participants)
D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D
        
aveTemps=[];

    
for i=1:length(subfolders)   
    load(strcat(LOAD_DIR,char(subfolders(i)),"/clean.mat"));
    
    aveTemp = mean(TEMP(:,2), 'omitnan');
    aveTemps(i,:) = [str2double(subfolders(i)) aveTemp];
end 
