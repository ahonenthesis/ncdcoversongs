% Chromagram embedding as in Serra et. al 2009.
%
% Input:
% data - chromagram data
% m    - embed dimension
% tau  - step
%
% Output:
% edata - embedded chromagram
function [edata] = embedChromagram(data,m,tau)

cdim=size(data,1); % chroma dimension
clen=size(data,2); % chromagram length

edim=cdim*m; % embedded vector length
elen=clen-(m-1)*tau; % embed chromagram length

edata=zeros(edim,elen);

for ix=1:elen        
    for jx=1:cdim
        edata(jx*m-(m-1):jx*m,ix)=data(jx,ix:tau:(ix-1)+m);
    end
end

end
