function singleFeature(queryList,targetList,outputDirectory,scratchDirectory,resultFile)

% Set the toolbox etc. parameters if needed
if isempty(strfind(path,pwd))
    toolboxConfig;
end

% First, extract the chromagram data
chparams = chromagramConfig;
qchromas = extractChromagrams(queryList,strcat(outputDirectory,chparams.odir),chparams.wlen,chparams.hsize,chparams.cres,chparams.bass);
tchromas = extractChromagrams(targetList,strcat(outputDirectory,chparams.odir),chparams.wlen,chparams.hsize,chparams.cres,chparams.bass);

% Then, you might want to process the chromagram data (e.g. run a median
% filter or beat synchronization); that would be done here.

% ...

% Next, the quantization of the chromagram data. Here the choice is the HMM chord
% estimation.

crparams = chordConfig;
qclist = calculateChordSeqs(qchromas,strcat(outputDirectory,crparams.odir),crparams.lex);
tclist = calculateChordSeqs(tchromas,strcat(outputDirectory,crparams.odir),crparams.lex);

% As with the chromagram data, additional processing of the sequences
% (median filtering or internal duplication) would be done here

% ...

% After quantization has been produced, write the sequnces with transpositions

labelChordSeqs(qclist,strcat(outputDirectory,crparams.sdir));
labelChordSeqs(tclist,strcat(outputDirectory,crparams.sdir));

% The data is now all set. Produce a transposition matrix with some method,
% here we use OTI.
kiparams = keyConfig;
if (kiparams.method==1) % use OTI here
    calculateOTImat(qchromas,tchromas,strcat(outputDirectory,kiparams.ofile),kiparams.num);
end

% Finally, the computation of distances. Here, we use bzip2 -- this will
% more paramized in the near future.
bzip2NCD(tchromas, qchromas, strcat(outputDirectory,crparams.sdir), strcat(outputDirectory,kiparams.ofile), scratchDirectory, resultFile);

% And after the matrix is complete, we can now evaluate the performance.

% ...

end
