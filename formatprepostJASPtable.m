% Format pre-post JASP table from all sections JASP table

OUT_DIR = '/Volumes/Seagate/danslaNature/JASP_analysis/pre-post/final/';
T = readtable('/Volumes/Seagate/danslaNature/JASP_analysis/allsection/final/JASPtable2.csv');

% Columns of new table 
Participants = [];
Section = [];
stdEDAslopes = [];
medTEMPslopes = [];
medHRslopes = [];
aveHR = [];
aveHRVYZ = [];
aveHRVZ = [];

% Init table with empty columns
newT = table(Participants,Section,stdEDAslopes,medTEMPslopes,medHRslopes,aveHR,aveHRVYZ,aveHRVZ);

%For each participant
for i=1:size(T,1)
    
    tableRow_before = [T.Participants(i),{'before_forest'},T.stdEDAslopes_before(i), T.medTEMPslopes_before(i),T.medHRslopes_before(i),T.aveHR_before(i),T.aveHRVYZ_before(i),T.aveHRVZ_before(i)];
    tableRow_after = [T.Participants(i),{'after_forest'},T.stdEDAslopes_after(i), T.medTEMPslopes_after(i),T.medHRslopes_after(i),T.aveHR_after(i),T.aveHRVYZ_after(i),T.aveHRVZ_after(i)];

    tableRow = [tableRow_before;tableRow_after];
    newT = [newT; tableRow];
end 

% Save as csv file
writetable(newT,strcat(OUT_DIR,'JASPtable_prepost.csv'));