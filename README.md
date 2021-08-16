# dansLaNature

About the project:

This project is in collaboration with L'Universite dans la nature. This project aims to extract relevant physiological features indicative of sympathetic and parasympathetic nervous system activity during a forest bathing activity. 

### Code Structure:

- 0_preliminary_analysis: Initial look into some features of the data to get a better idea of what to anlayse.
- 1_preprocess: First step in the pipeline is to clean the data. This script takes a single participant and cleans the EDA, HR, HRV, and TEMP signals. The script checks if the data is segmented in different parts (different folders for each part) as some participants' devices intermittently disconnected. Prior to running, if a participant has several parts in their session, each part should have its own folder (e.g. part1, part2..)
- 2_extract_features: danslaNature_pipeline.m is the main script that computes features from the physiological signals for each segment in the forest bathing activity. The timestamps file for each group need to loaded. dln_trimdata.m is a script used when the start and/or end of the data for a specific forest segment is unclean. The data for that forest segment needs to be loaded, the amount to cut from the beginning and end need to be chosen, and then the features are extracted and saved for that segment. computeParticipantsAveTemp.m computes the average skin temperature for day 1 and day 2, 3 participants.
- 3_format_final_table: These scripts format the features into tables (long and wide format) for statistical analysis in JASP / SAS.
- helper_functions: These functions are called in some of the scripts in the previous steps in the pipeline.
- rough_work: Scripts that are not part of the overall pipeline, just for doing some rough work. 
