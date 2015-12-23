% Calculates chroma contour representations from chromagram data.
%
% input:
% chromaList - text file with a list of chromagram .mat files
% outputDir  - directory where the contour sequences will be saved
%
% output:
% seqList - file name for the list of the contour sequence files
function [seqList] = calculateChromaContourSeqs(chromaList,outputDir)

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
    data=foo.data;
    gdata=sum(data,2)/max(sum(data,2));
    seq=zeros(1,size(data,2));
    for jx=1:size(data,2)
        seq(jx)=koti(gdata,data(:,jx),1);
    end    
    save(savefile,'seq');
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);

end
