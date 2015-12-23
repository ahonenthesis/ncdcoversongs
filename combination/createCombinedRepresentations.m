function createCombinedRepresentations(seqList,chordDir,melodyDir,outputDir,comst)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(seqList,'%s');
%tl2=textread(melodyList,'%s');

for ix=1:length(tl)
    tl{ix}
    %foo=load(tl{ix});
    D=dir(tl{ix});
    lname=strrep(D.name,'.mat','.txt');
    %foobar=load(tl2{ix});
    for jx=0:11
        iname1=strcat(chordDir,lname,'.',num2str(jx));
        iname2=strcat(melodyDir,lname,'.',num2str(jx));
        oname=strcat(outputDir,lname,'.',num2str(jx));
        combineRepresentations(iname1,iname2,oname',comst);
    end

end

end
