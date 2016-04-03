function [chromaParams] = chromagramConfig

outputDir    = '16k_chromas/'; % directory for the .mat files
windowLength = 0.3715; % seconds
hopSize      = 1; % i.e. no overlap
resolution   = 12; % number of bins
bassChroma   = false; % true if you wish to extract bass chroma

chromaParams = struct('odir',outputDir,'wlen',windowLength,'hsize',hopSize,'cres',resolution,'bass',bassChroma);

end
