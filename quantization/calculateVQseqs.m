% Produces a vector quantization for the chromagram data.
%
% input:
% chromaList - text file with a list of chromagram .mat files
% outputDir  - directory where the vq sequences will be saved
% vq         - '12a', '12b', '24', '36', '48' or '60', as in the thesis
%
% output:
% seqList - file name for the list of the vq sequence files
function [seqList] = calculateVQseqs(chromaList,outputDir,vq)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl = textread(chromaList,'%s');
D=dir(chromaList);
lname=D.name;
seqList=strcat(outputDir,lname);

load(strcat('vq',vq,'.mat')); % this loads the variable vqcents

fid=fopen(seqList,'w');

vqdim=size(vqcents,1);

for ix=1:length(tl)
    foo=load(tl{ix});
    D=dir(tl{ix});
    savefile=strcat(outputDir,D.name);
    seq=kmeans(foo.data',vqdim,'Start',vqcents,'MaxIter',1);
    save(savefile,'seq');
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);

end
