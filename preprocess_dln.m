%% Preprocessing 

clear;

LOAD_DIR = "/Volumes/Seagate/danslaNature/2020-09-19/group2/018/";

D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

if isempty(subfolders) % If no segments 
    OUT_DIR = LOAD_DIR;
    files = dir(strcat(LOAD_DIR,'*.mat'));
    
    for i=1:length(files)
        filepath = strcat(LOAD_DIR,files(i).name);
        load(filepath);
    end
    
    preprocess;
    
else % If data is in parts
    
    for i=1:length(subfolders)
        OUT_DIR = strcat(LOAD_DIR,subfolders(i),'/');

        files = dir(strcat(LOAD_DIR, subfolders(i),'/*.mat'));

        for f=1:length(files)
            filepath = strcat(LOAD_DIR,subfolders(i),'/',files(f).name);
            load(filepath);
        end 

        preprocess;
    end
end 