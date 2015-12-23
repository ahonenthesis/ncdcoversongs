% Runs a median filter on estimated chord sequences.
%
% input:
% seqList    - text file with a list of chord sequences .mat files
% outputDir  - directory where the binary chromagrams will be saved
% mfvalue    - the length of the median filter window
%
% output:
% seqList2 - file name for the list of the filtered chord sequences
function [seqList2] = medianFilterSequnces(seqList,outputDir,mfvalue)

% TODO default mfvalue

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(seqList,'%s');
D=dir(seqList);
lname=D.name;
seqList2=strcat(outputDir,lname);

fid=fopen(seqList2,'w');

for ix=1:length(tl)
    foo=load(tl{ix});
    D=dir(tl{ix});
    savefile=strcat(outputDir,D.name);
    seq=medfilt1(foo.seq,mfvalue);
    save(savefile,'seq');
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);

end