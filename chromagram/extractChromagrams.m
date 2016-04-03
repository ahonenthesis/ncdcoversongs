% Extracts chromagram data using MIRToolbox and stores them in .mat files.
%
% input:
% fileList  - text file with the names of the audio files
% outputDir - the directory where the chroma files will be stored
% flen      - chromagram frame length as seconds, default 0.3715
% hsize     - hop size, default 1 (i.e. no overlap)
% res       - chroma bin resolution, default 12
% bass      - extract bass chromagram if true, default false
%
% output:
% chromaList - text file with the names of the chromagram .mat files

function [chromaList] = extractChromagrams(fileList,outputDir,flen,hsize,res,bass)

if (nargin<2)
    disp('Parameters missing!')    
    return
elseif (nargin<3)
    flen=0.3715;
    hsize=1;
    res=12;
    bass=false;
elseif (nargin<4)
    hsize=1;
    res=12;
    bass=false;
elseif (nargin<5)
    res=12;
    bass=false;
elseif (nargin<6)
    bass=false;
end

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(fileList,'%s');
D=dir(fileList);
lname=D.name;
chromaList=strcat(outputDir,lname);

fid=fopen(chromaList,'w');

mi = 100;
ma = 5000;
if (bass)
    mi=54;    
    ma=110;
end

for ix=1:length(tl)
    tl{ix}
    savefile=strcat(outputDir,filenamehelper(tl{ix}),'mat');
    if ~(exist(savefile,'file'))
        mirc=mirchromagram(tl{ix},'Frame',flen,hsize,'Min',mi,'Max',ma,'Res',res);
        data=mirgetdata(mirc);    
        save(savefile,'data');
    end
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);
end
