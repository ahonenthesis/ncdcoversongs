% Normalizes chromagram data. Used with chromagram data produced with the 
% beat synchronization.
function [data] = chromagramNormalizer(data)

for inx=1:size(data,2)
    maxx = max(data(:,inx));
    minn = min(data(:,inx));
    if maxx~=minn
        data(:,inx)=data(:,inx)/maxx;
    end
end

end
