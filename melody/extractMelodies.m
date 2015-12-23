% Extracts melody sequences with algorithm by Laaksonen (2003).
%
% N.B. Run in the main directory of the algorithm. A more global solution
% will appear one day...
%
% input:
% fileList  - text file with the names of the audio files
% outputDir - the directory where the melody .mat files will be stored
% bass      - extract bass melodies (default false)
%
% output:
% melodylist - text file with the names of the melody .mat files
function [melodyList] = extractMelodies(fileList,outputDir,bass)

if (nargin<3)
    bass=false;
end

if (bass)
    comstr='melody/getbassmelody';
else
    comstr='melody/getmelody';
end

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(fileList,'%s');
D=dir(fileList);
lname=D.name;
melodyList=strcat(outputDir,lname);

fid=fopen(melodyList,'w');

for ix=1:length(tl)
    tl{ix}
    com=[comstr,' ',tl{ix},' 1 1 30 0 0']; % FIX as global
    [~,bb]=system(com);
    seq=str2num(bb)';
    savefile=strcat(outputDir,filenamehelper(tl{ix}),'mat');
    save(savefile,'seq');
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);

end