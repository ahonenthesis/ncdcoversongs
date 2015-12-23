% Okely dokely.
% 
% input:
% targetList   -
% queryList    -
% tdir         - directory for temporary files
% outputFile   - file name for the distance matrix
function bzip2NCD(targetList, queryList, seqdir, tdir, outputFile)
% FIX parametritsekki ja vaikka viddu mitä...
tic
tl = textread(targetList,'%s');
ql = textread(queryList,'%s');

tlen=length(tl);
qlen=length(ql);

dmat = zeros(qlen,tlen);

for ix=1:qlen
    disp(['Query ' num2str(ix)])
    foo=load(ql{ix});
    D=dir(ql{ix});
    qname=strcat(seqdir,strrep(D.name,'.mat','.txt.0'));
    %%{
    for jx=1:tlen
        if (mod(jx,100)==0)
            disp(['  Target ' num2str(jx)])
        end
        baz=load(tl{jx});
        E=dir(tl{jx});
        otivalue=koti(foo.data,baz.data,1);
        tname=strcat(seqdir,strrep(E.name,'.mat','.txt.'),num2str(otivalue));                
        dmat(ix,jx)=ncd7zip(qname,tname,tdir,2);        
    end
    java.lang.System.gc();
    %}
end
save(outputFile,'-ascii','dmat')
toc   
end
