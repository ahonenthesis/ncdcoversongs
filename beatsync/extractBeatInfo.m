% Calculates beat locations using beat.m from the toolkit by Ellis et al.
% The toolkit can be obtained from 
% http://labrosa.ee.columbia.edu/matlab/chroma-ansyn/
%
% input:
% filelist  - text file with the names of the audio files
% outputdir - the directory where the beat information files will be stored
% output:
% beatList  - text file with the names of the beat location .mat files
function [beatList] = extractBeatInfo(fileList,outputDir)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(fileList,'%s');
D=dir(fileList);
lname=D.name;
beatList=strcat(outputDir,lname);

fid=fopen(beatList,'w');

for ix=1:length(tl)
    tl{ix}    
    [wav,fs]=wavread(tl{ix}); % FIX check if mono
    beats=beat(wav,fs);
    savefile=strcat(outputDir,filenamehelper(tl{ix}),'mat');
    save(savefile,'beats');
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);
end