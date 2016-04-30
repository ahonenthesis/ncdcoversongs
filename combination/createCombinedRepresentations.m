% Creates combined representations from chord and melody data.
%
% input:
% seqList   - a list of pieces to be combined
% chordDir  - the directory of the chord .txt files
% melodyDir - the directory of the melody .txt files
% outputDir - the directory where to write the combined representations 
% comst     - concatenation (1) or merge (other), no default value 
function createCombinedRepresentations(seqList,chordDir,melodyDir,outputDir,comst)
% FIXME input sanity check required

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(seqList,'%s');

for ix=1:length(tl)    
    D=dir(tl{ix});
    lname=strrep(D.name,'.mat','.txt');
    if ~(exist(strcat(outputDir,lname,'.',num2str(0))))
        % transpositions
        for jx=0:11
            iname1=strcat(chordDir,lname,'.',num2str(jx));
            iname2=strcat(melodyDir,lname,'.',num2str(jx));
            oname=strcat(outputDir,lname,'.',num2str(jx));
            combineRepresentations(iname1,iname2,oname',comst);
        end
    end
end

end
