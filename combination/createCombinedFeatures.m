function createCombinedFeatures(chordList,melodyList,outputDir,comst)

% FIX kaikenlaista, eh heh

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(chordList,'%s');
tl2=textread(melodyList,'%s');

offset=30;

for ix=1:length(tl)
    foo=load(tl{ix});
    D=dir(tl{ix});
    lname=strrep(D.name,'.mat','.txt');
    foobar=load(tl2{ix});
    % transpositions
    for jx=0:11
        tseq=mod(foo.seq+2*jx,24);
        tseq(find(tseq==0))=24; % FIX tästä eroon -> sekut alkamaan luvusta 0!
        tseq2=foobar.seq;
        tseq2=tseq2+jx;
        comseq=combineFeatures(tseq,tseq2,comst); 
        textWriter(char(comseq+offset),strcat(outputDir,lname,'.',num2str(jx)));
    end
    %}    
end

end