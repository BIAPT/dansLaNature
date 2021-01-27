% Dannie Fu October 26 2020
% This script computes the average slope of all participants for each measure across all
% sections of the dans la nature session
%
% Also computes the average slope for only the participants that didn't
% have the weird HRV oscillations
% ------------------

clear;

LOAD_DIR = '/Volumes/Seagate/danslaNature/';
OUT_DIR = '/Volumes/Seagate/danslaNature/ave_slopes_goodparticipants/';
groups = {'2020-09-19/group1/','2020-09-19/group2/','2020-09-26/group1/','2020-09-26/group2/','2020-09-27/group1/','2020-09-27/group2/'};
filename = '/walking5_slopes.mat';
section = 'walking5';

bad_participants = {'010','012','014','022','023','024','025','026','030','031','032','035','036','034','040','041','042','045','048','053','055','056'};
%bad_participants = {};

eda = [];
temp = [];
hr = [];

for i=1:length(groups)
    
    % Get subfolders (participants)
    D = dir(char(strcat(LOAD_DIR,groups(i))));
    subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

    for j=1:length(subfolders)
        
        try
            if any(strcmp(bad_participants,subfolders(j)))
                continue
            end 
                
            load(char(strcat(LOAD_DIR,groups(i),subfolders(j),filename)));
            
        catch
            continue
        end 
        
        % Take the mean and then add to array eda
        if ~isempty(EDA)
            meanEDA = mean(EDA(:,2),'omitnan');
        end 
        
        if ~isempty(TEMP)
            meanTEMP = mean(TEMP(:,2),'omitnan');
        end 
        
        if ~isempty(HR)
            meanHR = mean(HR(:,2),'omitnan');
        end 
        
        % Vertically concat the data 
        eda = [eda; meanEDA];
        temp = [temp; meanTEMP];
        hr = [hr; meanHR];
        
    end 
end 

save(strcat(OUT_DIR,'eda_',section,'_aveSlopes.mat'), 'eda');
save(strcat(OUT_DIR,'temp_',section,'_aveSlopes.mat'), 'temp');
save(strcat(OUT_DIR,'hr_',section,'_aveSlopes.mat'), 'hr');


