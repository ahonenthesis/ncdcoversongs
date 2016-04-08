% This will produce a n*n distance matrix from the input list of audio files.
% A more solid version for different query and target files is coming...
function exampleRun(qlist,tlist,outputdir,scratchdir,resfile)

% add MIRToolbox to the path first!
% HUOM! TÄMÄ ON "VARMISTETTU"
qclist = extractChromagrams(qlist,strcat(outputdir,'16k_chromas/'));
tclist = extractChromagrams(tlist,strcat(outputdir,'16k_chromas/'));
% add HMM Toolkit to the path first!
% HUOM! TÄTÄ EI VIELÄ "VARMISTETTU"
qslist = calculateChordSeqs(qclist,strcat(outputdir,'16k_chords/'));
tslist = calculateChordSeqs(tclist,strcat(outputdir,'16k_chords/'));
seqdir = strcat(outputdir,'16k_seqs/');
% EI "VARMISTETTU"
labelChordSeqs(qslist,seqdir);
labelChordSeqs(tslist,seqdir);
% HUOMAA ETTÄ KAIKKI PIIRTEET JA ESITYKSET PITÄÄ "VARMISTAA"
otifile=strcat(outputdir,'ex_otis.mat');
calculateOTImat(qclist,qclist,otifile,2);
bzip2NCD(qclist, qclist, seqdir, otifile, scratchdir, resfile);

end
