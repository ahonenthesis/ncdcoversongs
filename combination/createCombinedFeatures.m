% Creates combined feature representations from chord and melody data.
%
% input:
% chordList  - the directory of the chord .mat files
% melodyList - the directory of the melody .mat files
% outputDir  - the directory where to write the combined features 
% comst      - the tuple choice, a value from 1 to 4 (see thesis)
function createCombinedFeatures(chordList,melodyList,outputDir,comst)


if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(chordList,'%s');
tl2=textread(melodyList,'%s');

offset=30; % just to make the output data a bit more readable

for ix=1:length(tl)
    foo=load(tl{ix});
    D=dir(tl{ix});
    lname=strrep(D.name,'.mat','.txt');
    foobar=load(tl2{ix});
    if ~(exist(strcat(outputDir,lname,'.',num2str(0)),'file'))
        % transpositions
        for jx=0:11
            tseq=mod(foo.seq+2*jx,24);
            tseq(find(tseq==0))=24;
            tseq2=foobar.seq;
            tseq2=tseq2+jx;
            comseq=combineFeatures(tseq,tseq2,comst); 
            textWriter(char(comseq+offset),strcat(outputDir,lname,'.',num2str(jx)));
        end
    end
end

end