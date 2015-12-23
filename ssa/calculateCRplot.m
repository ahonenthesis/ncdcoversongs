% Calculates a cross recurrence plot for two (embedded) chromagrams.
%
% input:
% chromagram1 - chromagram data (should be embedded, but no required)
% chromagram2 - chromagram data (should be embedded, but no required)
% kappa       - percentage of maximum non-zero entries on rows and columns
%
% output:
% crp - binary cross recurrence plot matrix
function [crp] = calculateCRplot(chromagram1,chromagram2,kappa)

xlen=size(chromagram1,2);
ylen=size(chromagram2,2);

% FIXME this could be done with prctile way easier
xix=floor(kappa*xlen);
xiy=floor(kappa*ylen);

normat=zeros(xlen,ylen);

bmatx=zeros(xlen,ylen);
bmaty=zeros(xlen,ylen);

%crp=zeros(xlen,ylen);

for ix=1:xlen
    for jx=1:ylen
        normat(ix,jx)=norm(chromagram1(:,ix)-chromagram2(:,jx));
    end
end

% FIXME the code blocks below could be optimized

% nonzero entries on rows
for ix=1:xlen
    [~,xx]=sort(normat(ix,:));
    bmatx(ix,xx(1:xix))=1;
end

% nonzero entries on columns
for ix=1:ylen
    [~,yy]=sort(normat(:,ix));
    bmaty(yy(1:xiy),ix)=1;
end

crp=and(bmatx,bmaty);

end