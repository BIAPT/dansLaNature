%% Preprocessing 

clear;

LOAD_DIR = "/Volumes/Seagate/danslaNature/data/2020-09-19/group1/003/";
OUT_DIR = "/Volumes/Seagate/danslaNature/analysis/2020-09-19/group1/003/";

D = dir(LOAD_DIR);
subfolders = setdiff({D([D.isdir]).name},{'.','..'}); % list of subfolders of D

if isempty(subfolders) % If no segments 
    %OUT_DIR = LOAD_DIR;
    files = dir(strcat(LOAD_DIR,'*.mat'));
    
    for i=1:length(files)
        filepath = strcat(LOAD_DIR,files(i).name);
        load(filepath);
    end
    
    clean = preprocess(EDA,TEMP,HR,HRV);
    
    %Save cleaned data
    save(strcat(OUT_DIR,'clean.mat'),'-struct','clean');
    
else % If data is in parts
    
    clean.EDA = [];
    clean.TEMP = [];
    clean.HR = [];
    clean.HRVX = [];
    clean.HRVY = [];
    clean.HRVZ = [];
    clean.HRVYZ = [];

    for i=1:length(subfolders)
        %OUT_DIR = strcat(LOAD_DIR,subfolders(i),'/');

        files = dir(strcat(LOAD_DIR, subfolders(i),'/*.mat'));

        for f=1:length(files)
            filepath = strcat(LOAD_DIR,subfolders(i),'/',files(f).name);
            load(filepath);
        end 

        c = preprocess(EDA,TEMP,HR,HRV);
        
        nan = [NaN NaN];
        clean.EDA = [clean.EDA; nan; c.EDA];
        clean.TEMP = [clean.TEMP; nan; c.TEMP];
        clean.HR = [clean.HR; nan; c.HR];
        clean.HRVX = [clean.HRVX; nan; c.HRVX];
        clean.HRVY = [clean.HRVY; nan; c.HRVY];
        clean.HRVZ = [clean.HRVZ; nan; c.HRVZ];
        clean.HRVYZ = [clean.HRVYZ; nan; c.HRVYZ];
        
        % Save cleaned data
        save(strcat(OUT_DIR,'clean.mat'),'-struct','clean');
    end
    
end 