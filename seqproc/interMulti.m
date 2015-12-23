% Multiplicates data internally. The purpose of m and tau are analoguous to
% those in time series embedding.
%
% input:
% data - data to be multiplicated
% m    - length of the multiplication window
% tau  - delay (use 1)
function [imdata] = interMulti(data,m,tau)
% TODO m and tau check
imdata=[];

for ix=1:length(data)-(m-1)*tau
    imdata(:,end+1:end+m)=data(:,ix:ix+(m-1)*tau);    
end

end
