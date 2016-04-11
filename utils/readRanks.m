% Reads correct target indices from a file.
function [ranks] = readRanks(fname)

ranks = [];
celldata = textread(fname,'%s');

for ix=1:size(celldata,1)
    ranks(ix,:) = str2num(celldata{ix});
end

end
