% Estimates keys to songs with MIRToolbox function mirkey.
%
% input: a list of wav files
% output: estimated (major) keys of the wav files; 1 = C major and so on
function [keylist] = estimateLikelyKeys(wavList)
tic

% if a minor key, use this to map to major
min2maj = [4,5,6,7,8,9,10,11,12,1,2,3];

ql=textread(wavList,'%s');
qlen=size(ql,1);

keylist=zeros(1,qlen);

for ix=1:qlen
    [root,qualt] = mirgetdata(mirkey(ql{ix}));
    if (isempty(root)) % estimation failed -- happens occasinally with stereo data
        root=1;
    else
        if (qualt==2) % minor chord
            root = min2maj(root);
        end
    end
    keylist(ix)=root;
end

toc
end
