% This is a small helper file that converts the file name into a more 
% suitable representation. The audio files used were named with a format of 
%
%     ~/coversongs/songtitle/performer.wav
%
% and this turns the string to 
%
%     songtitle_performer.
%
% where a 'mat' suffix will be added in the chromagram extraction.
% Modify this for your needs.

function [newName] = filenamehelper(fname)

foo=strfind(fname,filesep);
newName=strrep(fname(foo(end-1)+1:end-3),filesep,'_');

end
