% Calculates melody sequences from chromagram data. These sequences can 
% then be labeled with e.g. chord labeler for 12 chord lexicon.
%
% input:
% chromaList - text file with a list of chromagram .mat files
% outputDir  - directory where the melody sequences will be saved
%
% output:
% seqList    - file name for the list of the melody sequence files
function [seqList] = extractChromaMelodies(chromaList,outputDir)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl = textread(chromaList,'%s');
D=dir(chromaList);
lname=D.name;
seqList=strcat(outputDir,lname);

fid=fopen(seqList,'w');

for ix=1:length(tl)
    foo=load(tl{ix});
    D=dir(tl{ix});
    savefile=strcat(outputDir,D.name);
    if ~(exist(savefile,'file'))
        [~,seq] = max(foo.data);
        save(savefile,'seq');
    end
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);

end
