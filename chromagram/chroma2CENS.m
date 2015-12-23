% Turns chromagram to a CENS representation (without downsampling). Based 
% on Meinard Müller's work as in 
% https://www.audiolabs-erlangen.de/resources/MIR/chromatoolbox/
%
% N.B. This is a very quick and dirty implementation and includes an awful
% amount of hard-coded stuff. It works, but should be rewritten.
function [cens] = chroma2CENS(data)

cens=zeros(size(data));
censhelp=zeros(size(data));

energies = [40 20 10 5] / 100;
weights = [1 1 1 1]/4;

for kx=1:size(data,2)
    data(:,kx)=data(:,kx)/sum(data(:,kx));
end

for ix=1:4 
    censhelp=censhelp+(data>energies(ix))*weights(ix);
end

unitvec=ones(12,1)/norm(ones(12,1));

for jx=1:size(data,2);
    n = norm(censhelp(:,jx));
    if n==0
        cens(:,jx) = unitvec;
    else
        cens(:,jx) = censhelp(:,jx)/n;        
    end

end

end