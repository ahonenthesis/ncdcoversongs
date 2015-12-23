% Calculates chord sequences using HMM toolkit.
%
% input:
% chromaList - text file with a list of chromagram .mat files
% outputDir  - directory where the chord sequences will be saved
% lex        - the chord lexicon, i.e. 24 or 12 chords (default 24)
%
% output:
% seqList    - file name for the list of the chord sequence files
function [seqList] = calculateChordSeqs(chromaList,outputDir,lex)

% FIX parametritsekki; 12 vs. 24 samaan?

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl = textread(chromaList,'%s');
D=dir(chromaList);
lname=D.name;
seqList=strcat(outputDir,lname);

fid=fopen(seqList,'w');

if (nargin<3)
    lex=24;
end

% The code below could be a little more sophisticated...

if (lex==24)
    load prior24
    load trans24
    load mu24
    load Sigma24
    for ix=1:length(tl)
        foo=load(tl{ix});
        D=dir(tl{ix});
        savefile=strcat(outputDir,D.name);
        seq=hmmChords(foo.data,prior24,trans24,mu24,Sigma24);
        save(savefile,'seq');
        fprintf(fid,'%s\n',savefile);
    end
elseif (lex==12)
    load prior12
    load trans12
    load mu12
    load Sigma12
    for ix=1:length(tl)
        foo=load(tl{ix});
        D=dir(tl{ix});
        savefile=strcat(outputDir,D.name);
        seq=hmmChords(foo.data,prior12,trans12,mu12,Sigma12);
        save(savefile,'seq');
        fprintf(fid,'%s\n',savefile);
    end
else
    disp('Incorrect chord lexicon size')
end

fclose(fid);

end