% This will produce a n*n distance matrix from the input list of audio files.
% A more solid version for different query and target files is coming...
function exampleRun(flist,outputdir,scratchdir,resfile)

% add MIRToolbox to the path first!
clist = extractChromagrams(flist,strcat(outputdir,'16k_chromas/'));
% add HMM Toolkit to the path first!
slist = calculateChordSeqs(clist,strcat(outputdir,'16k_chords/'));
seqdir = strcat(outputdir,'16k_seqs/');
labelChordSeqs(slist,seqdir);
otifile=strcat(outputdir,'ex_otis.mat');
calculateOTImat(clist,clist,otifile,2);
bzip2NCD(clist, clist, seqdir, otifile, scratchdir, resfile)

end
