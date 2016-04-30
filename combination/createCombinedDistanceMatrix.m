% Calculates a combined distance matrix from an input list of matrices.
%
% input:
% dmatList    - list of filenames where the distance matrices are stored
% calculate   - 'mean', 'median', 'max', or 'min'
% newDMatName - the filename for the resulting new matrix
function createCombinedDistanceMatrix(dmatList,calculate,newDMatName)

bigmat = [];

for ix=1:length(dmatList)
    bigmat(:,:,ix)=load(dmatList{ix});
end

dmat = zeros(size(bigmat,1),size(bigmat,2));

if (strcmp(calculate,'mean'))
    dmat=mean(bigmat,3);
elseif (strcmp(calculate,'median'))
    dmat=median(bigmat,3);
elseif (strcmp(calculate,'max'))
    dmat=max(bigmat,[],3);
elseif (strcmp(calculate,'min'))
    dmat=min(bigmat,[],3);
else
    disp('Bogus choice for calculation!')
end

save(newDMatName,'-ascii','dmat')

end
