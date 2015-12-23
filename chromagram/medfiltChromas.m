% Cleans up chromagram data with median filtering.
%
% input:
% chromaList - a list of chromagram files 
% outputDir  - the directory where the filtered chroma files will be stored
% mfwin      - the length of the median filter window
%
% output:
% chromaList2 - text file with the names of the filtered chromagram .mat files
function [chromaList2] = medfiltChromas(chromaList,outputDir,mfwin)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(chromaList,'%s');
D=dir(chromaList);
lname=D.name;
chromaList2=strcat(outputDir,lname);

fid=fopen(chromaList2,'w');

for ix=1:length(tl)
    foo=load(tl{ix});
    D=dir(tl{ix});
    savefile=strcat(outputDir,D.name);
    data=medfilt1(foo.data,mfwin,[],2);
    save(savefile,'data');
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);
end
