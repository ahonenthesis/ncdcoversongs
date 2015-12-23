% Produces binarized version from chromagram data according to a provided
% threshold value.
% input:
% chromaList - text file with a list of chromagram .mat files
% outputDir  - directory where the binary chromagrams will be saved
%
% output:
% seqList - file name for the list of the binary chroma sequence files
function [seqList] = calculateBinChromas(chromaList,outputDir,thre)

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
    data=double(foo.data>thre);
    %data=bin2dec(num2str(data')); % this is done in seq labeling now
    save(savefile,'data');
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);

end
