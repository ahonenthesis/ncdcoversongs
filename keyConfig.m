function [keyParams] = keyConfig

method       = 1; % 1 for OTI, 2 for key estimation, 0 for zero matrix (no key invariance or key invariance by representation)
outputFile   = 'oti1.mat'; % filename for the transposition index matrix
numberOfTrs  = 1; % number of most likely transpositions, only OTI supports currently more than one

keyParams = struct('method',method,'ofile',outputFile,'num',numberOfTrs);

end
