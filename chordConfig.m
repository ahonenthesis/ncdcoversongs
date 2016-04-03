function [chordParams] = chordConfig

outputDir    = '16k_chords/'; % directory for the .mat files
lexicon      = 24; % number of chords; 24 or 12
outputDir2   = '16k_seqs/'; % directory for the ascii seq files

chordParams = struct('odir',outputDir,'lex',lexicon,'sdir',outputDir2);

end
