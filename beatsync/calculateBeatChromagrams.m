% Calculates beat-synchronous chromagrams using extracted chromagram data
% and beat location information. Uses beatavg.m from the toolkit by Ellis et al.
% The toolkit can be obtained from 
% http://labrosa.ee.columbia.edu/matlab/chroma-ansyn/
%
% NB: This version is hard-coded to use only 16K chromas.
% 
% input: 
% chromaList - a list of chromagram files 
% beatlist   - a list of beat location files
% outputDir  - the directory where the beat-sync chroma files will be stored
%
% output:
% beatChromaList - text file with the names of the beat-sync chromagram .mat files
function [beatChromaList] = calculateBeatChromagrams(chromaList,beatList,outputDir)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl = textread(chromaList,'%s');
D=dir(chromaList);
lname=D.name;
beatChromaList=strcat(outputDir,lname);
bl = textread(beatList,'%s');

fid=fopen(beatChromaList,'w');

for ix=1:length(tl)
    tl{ix}
    foo=load(tl{ix});
    D=dir(tl{ix});
    savefile=strcat(outputDir,D.name);
    if ~(exist(savefile,'file'))
        baz=load(bl{ix});
        data=beatavg(foo.data,baz.beats*2); % FIXME hard coded!
        data=chromagramNormalizer(data);
        save(savefile,'data');
    end
    fprintf(fid,'%s\n',savefile);
end

fclose(fid);

end
