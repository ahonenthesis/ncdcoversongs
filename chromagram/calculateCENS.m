% Calculates CENS features from chromagram data. Does not downsample the
% chromagrams, as CENS representation should.
%
% input:
% chromaList - a list of chromagram files
% outputDir  - a directory for the CENS files
%
% output:
% censList - text file with the names of the CENS .mat files
function [censList] = calculateCENS(chromaList,outputDir)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(chromaList,'%s');
D=dir(chromaList);
lname=D.name;
censList=strcat(outputDir,lname);

fid=fopen(censList,'w');

for ix=1:length(tl)
    foo=load(tl{ix});
    D=dir(tl{ix});
    savefile=strcat(outputDir,D.name);
    data=chroma2CENS(foo.data);
    save(savefile,'data');
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);
end