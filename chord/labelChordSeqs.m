% Labels the chord sequences and creates all 12 different key transposition
% representations.
%
% input:
% seqList   - a list of chord sequences
% outputDir - directory where the sequence representations will be saved
% lex       - chord lexicon size, i.e. 12 or 24 chords (default 24)
function labelChordSeqs(seqList,outputDir,lex)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(seqList,'%s');

if (nargin<3)
    lex=24;
end
% TODO handle incorrect lex sizes

% uppercase=major, lowercase=minor
% U=C#,V=D#,X=F#,Y=G#,Z=A#
if (lex==12)
    chordNames={'C','U','D','V','E','F','X','G','Y','A','Z','B'};
else
    chordNames={...
        'C','c','U','u','D','d','V','v','E','e','F','f',...
        'X','x','G','g','Y','y','A','a','Z','z','B','b'};
end

for ix=1:length(tl)
    foo=load(tl{ix});
    D=dir(tl{ix});
    lname=strrep(D.name,'.mat','.txt');    
    % key transpositions
    for jx=0:11
        if (lex==24)
            tseq=mod(foo.seq+2*jx,24);
            tseq(find(tseq==0))=24;
        else
            tseq=mod(foo.seq+jx,12);
            tseq(find(tseq==0))=12;
        end
        textWriter(char(chordNames(tseq))',strcat(outputDir,lname,'.',num2str(jx)));
    end
end

end
