% The qmax distance, calculated from a cross recurrence plot as in Serra et
% al. 2009
%
% input:
% crp    - the cross recurrence plot
% gammao - the disruption onset penalty
% gammae - the disruption extention penalty
%
% output:
% qmax - the qmax distance (actually, similarity) value
% qmat - the cumalative matrix used in calculation

function [qmax,qmat] = qmaxdist(crp,gammao,gammae)

[xlen,ylen]=size(crp);

qmat=zeros(xlen,ylen);

for ix=3:xlen
    for jx=3:ylen
        if (crp(ix,jx)==1)
            qmat(ix,jx)=max([qmat(ix-1,jx-1),qmat(ix-2,jx-1),qmat(ix-1,jx-2)])+1;
        else
            qmat(ix,jx)=max([0,...
                qmat(ix-1,jx-1)-gammaf(crp(ix-1,jx-1)),...
                qmat(ix-2,jx-1)-gammaf(crp(ix-2,jx-1)),...
                qmat(ix-1,jx-2)-gammaf(crp(ix-1,jx-2))]);
        end
    end
end


qmax=max(max(qmat));

    function [pen] = gammaf(bvalue)
        if (bvalue)
            pen=gammao;
        else
            pen=gammae;
        end
    end

end