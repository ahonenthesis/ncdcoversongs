% gzip-based pairwise distance matrix calculation.
% 
% input:
% targetList   - a list of target chromagram .mat files
% queryList    - a list of query chromagram .mat files
% seqdir       - location of the files that will be compressed
% otimat       - .mat file describing the OTI transpositions
% tdir         - directory for temporary files
% outputFile   - file name for the distance matrix
%
function gzipNCD(targetList, queryList, seqdir, otimat, tdir, outputFile)

tic
tl = textread(targetList,'%s');
ql = textread(queryList,'%s');

tlen=length(tl);
qlen=length(ql);

dmat = zeros(qlen,tlen);

load(otimat)

for ix=1:qlen
    disp(['Query ' num2str(ix)])
    foo=load(ql{ix});
    D=dir(ql{ix});
    qname=strcat(seqdir,strrep(D.name,'.mat','.txt.0'));
    for jx=1:tlen
        if (mod(jx,100)==0)
            disp(['  Target ' num2str(jx)])
        end
        baz=load(tl{jx});
        E=dir(tl{jx});
        dval = 1;
        for kx=1:size(tposes,3)
            otivalue=tposes(ix,jx,kx);
            tname=strcat(seqdir,strrep(E.name,'.mat','.txt.'),num2str(otivalue));            
            nval = gzipdistance(qname,tname,tdir);
            if (nval<dval)
                dval=nval;
            end
        end
        dmat(ix,jx)=dval;
    end
    java.lang.System.gc();
end
save(outputFile,'-ascii','dmat')
toc   
end
