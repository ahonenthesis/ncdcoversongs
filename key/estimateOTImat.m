% Produces an OTI matrix, but instead of OTI, uses key estimation to
% determine the most likely transposition value.
%
% input:
% qlist      - list of m query wav files
% tlist      - list of n target wav files
% outputfile - where the m*n OTI matrix will be stored
function estimateOTImat(qlist,tlist,outputfile)

% OTI map values, not the most elegant way to do this, but...
otimap = [
    0,11,10,9,8,7,6,5,4,3,2,1;
    1,0,11,10,9,8,7,6,5,4,3,2;
    2,1,0,11,10,9,8,7,6,5,4,3;
    3,2,1,0,11,10,9,8,7,6,5,4;
    4,3,2,1,0,11,10,9,8,7,6,5;
    5,4,3,2,1,0,11,10,9,8,7,6;
    6,5,4,3,2,1,0,11,10,9,8,7;
    7,6,5,4,3,2,1,0,11,10,9,8;
    8,7,6,5,4,3,2,1,0,11,10,9;
    9,8,7,6,5,4,3,2,1,0,11,10;
    10,9,8,7,6,5,4,3,2,1,0,11;
    11,10,9,8,7,6,5,4,3,2,1,0;
    ];

if ~(exist(outputfile,'file'))
    
    qkeys = estimateLikelyKeys(qlist);
    tkeys = estimateLikelyKeys(tlist);
    
    tposes = zeros(length(qkeys),length(tkeys));
    
    for ix=1:length(qkeys)
        for jx=1:length(tkeys)
            tposes(ix,jx)=otimap(qkeys(ix),tkeys(jx));
        end
    end
    
    save(outputfile,'tposes');
end
    
end
