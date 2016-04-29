% Produces an internal duplication to the sequences with parameters
% similarly as in time series embedding.
% input:
% seqList    - text file with a list of chord sequences .mat files
% outputDir  - directory where the binary chromagrams will be saved
% m          - multiplication window length
% tau        - delay (use 1)
%
% output:
% seqList2 - file name for the list of the multiplicated chord sequences
function [seqList2] = multiplicateSequences(seqList,outputDir,m,tau)

% TODO default parameter values for m and tau

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(seqList,'%s');
D=dir(seqList);
lname=D.name;
seqList2=strcat(outputDir,lname);

fid=fopen(seqList2,'w');

for ix=1:length(tl)    
    D=dir(tl{ix});
    savefile=strcat(outputDir,D.name);
    if ~(exist(savefile,'file'))
        foo=load(tl{ix});
        seq=interMulti(foo.seq,m,tau);
        save(savefile,'seq');
    end
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);

end