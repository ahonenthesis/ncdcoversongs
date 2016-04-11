function [evalParams] = evalConfig

dmatFile = 'results/bz_16k.csv'; % distance matrix file
rankFile = 'utils/ranks_1k.txt'; % file with correct target indices
descend  = false; % true if the matrix is a similarity matrix

evalParams = struct('dmat',dmatFile,'rankf',rankFile,'desc',descend);

end
