% calculates MAP and MRR from distance matrix
% needs a lot of cleaning, but works
function [meanOfAveP,meanRecRank]=calculateResults(data,corrects,descend)

if (nargin<3)
    descend=false;
end

if (descend)
    [~,bb]=sort(data,2,'descend');
else
    [~,bb]=sort(data,2);
end


avep=zeros(1,size(corrects,1));
first=zeros(1,size(corrects,1));

for ix=1:size(corrects,1) 
    found=zeros(1,size(corrects,2));
    for jx=1:size(corrects,2)
        loc=find(bb(ix,:)==corrects(ix,jx));
        found(jx)=loc-1; % Ignores self-similarity (assumed to be always first)
    end
    found=sort(found);
    if (found(1)==0)
        found=found+1;
    end
    first(ix)=1/found(1);
    summm=0;
    for kx=1:size(found,2)        
        summm=summm+kx/(found(kx)+eps);        
    end
    avep(ix)=summm/(size(found,2)+eps); % eps just in case...
end

meanOfAveP=mean(avep);
meanRecRank=mean(first);

end