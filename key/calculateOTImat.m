% Calculates k most likely optimal transpose index values for each pair of
% chromagrams 
%
% input:
% qlist      - list of m query chromagram files
% tlist      - list of n target chromagram files
% outputfile - where the m*n*k OTI matrix will be stored
% k          - number of most likely OTI values to be calculated (default 1)
function calculateOTImat(qlist,tlist,outputfile,k)
tic
ql=textread(qlist,'%s');
tl=textread(tlist,'%s');

qlen=size(ql,1);
tlen=size(tl,1);

tposes=zeros(qlen,tlen,k);

for ix=1:qlen
    foo=load(ql{ix});
    qdata=foo.data;
    for jx=1:tlen
        foobar=load(tl{jx});
        tdata=foobar.data;
        kotis=koti(qdata,tdata,k);
        for kx=1:k
            tposes(ix,jx,kx)=kotis(kx);
        end
    end
end

save(outputfile,'tposes');
toc
end
