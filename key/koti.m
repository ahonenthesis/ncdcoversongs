% Calculates k most likely optimal transposition indices
%
% input:
% chroma1 - chromagram A
% chroma2 - chromagram B (that will be transposed)
% k       - number of OTI values to be returned (default 1)
%
% output:
% otis - array of k OTI values
function [otis] = koti(chroma1,chroma2,k)
if nargin<3
    k=1;
end
g1=sum(chroma1,2)/max(sum(chroma1,2));
g2=sum(chroma2,2)/max(sum(chroma2,2));
for ix=0:11
    otis(ix+1)=dot(g1,circshift(g2,ix));
end
% FIXME this is a definitely ugly way to do things :-D
[~,koti]=sort(otis);
otis=fliplr(koti(end-(k-1):end));
otis=otis(1:k)-1;

end