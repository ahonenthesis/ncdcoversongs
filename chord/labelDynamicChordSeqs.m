% Labels the chord sequences as a representation of subsequent chord
% transpositions. Designed for the 24 chord lexicon.
%
% input:
% seqList   - a list of chord sequences
% outputDir - directory where the sequence representations will be saved
function labelDynamicChordSeqs(seqList,outputDir)

% on table indices, 1 is c major, 2 c minor, 3 c sharp major, and so forth
%
% the cell values: positive number means that there is no change in the
% chord quality, whereas negative indicates a change. The amount of the
% number is the semitone difference between root nodes plus one (as we have
% no separate +0 and -0 values).
symboltable = [ 
    1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7,8,-8,9,-9,10,-10,11,-11,12,-12; % c maj
    -1,1,-2,2,-3,3,-4,4,-5,5,-6,6,-7,7,-8,8,-9,9,-10,10,-11,11,-12,12; % c min
    12,-12,1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7,8,-8,9,-9,10,-10,11,-11; % c# maj
    -12,12,-1,1,-2,2,-3,3,-4,4,-5,5,-6,6,-7,7,-8,8,-9,9,-10,10,-11,11; % c# min 
    11,-11,12,-12,1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7,8,-8,9,-9,10,-10; % d maj
    -11,11,-12,12,-1,1,-2,2,-3,3,-4,4,-5,5,-6,6,-7,7,-8,8,-9,9,-10,10; % d min
    10,-10,11,-11,12,-12,1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7,8,-8,9,-9; 
    -10,10,-11,11,-12,12,-1,1,-2,2,-3,3,-4,4,-5,5,-6,6,-7,7,-8,8,-9,9;
    9,-9,10,-10,11,-11,12,-12,1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7,8,-8;
    -9,9,-10,10,-11,11,-12,12,-1,1,-2,2,-3,3,-4,4,-5,5,-6,6,-7,7,-8,8;
    8,-8,9,-9,10,-10,11,-11,12,-12,1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7;
    -8,8,-9,9,-10,10,-11,11,-12,12,-1,1,-2,2,-3,3,-4,4,-5,5,-6,6,-7,7;
    7,-7,8,-8,9,-9,10,-10,11,-11,12,-12,1,-1,2,-2,3,-3,4,-4,5,-5,6,-6;
    -7,7,-8,8,-9,9,-10,10,-11,11,-12,12,-1,1,-2,2,-3,3,-4,4,-5,5,-6,6;
    6,-6,7,-7,8,-8,9,-9,10,-10,11,-11,12,-12,1,-1,2,-2,3,-3,4,-4,5,-5;
    -6,6,-7,7,-8,8,-9,9,-10,10,-11,11,-12,12,-1,1,-2,2,-3,3,-4,4,-5,5;
    5,-5,6,-6,7,-7,8,-8,9,-9,10,-10,11,-11,12,-12,1,-1,2,-2,3,-3,4,-4;
    -5,5,-6,6,-7,7,-8,8,-9,9,-10,10,-11,11,-12,12,-1,1,-2,2,-3,3,-4,4;
    4,-4,5,-5,6,-6,7,-7,8,-8,9,-9,10,-10,11,-11,12,-12,1,-1,2,-2,3,-3;
    -4,4,-5,5,-6,6,-7,7,-8,8,-9,9,-10,10,-11,11,-12,12,-1,1,-2,2,-3,3;
    3,-3,4,-4,5,-5,6,-6,7,-7,8,-8,9,-9,10,-10,11,-11,12,-12,1,-1,2,-2;
    -3,3,-4,4,-5,5,-6,6,-7,7,-8,8,-9,9,-10,10,-11,11,-12,12,-1,1,-2,2;
    2,-2,3,-3,4,-4,5,-5,6,-6,7,-7,8,-8,9,-9,10,-10,11,-11,12,-12,1,-1;
    -2,2,-3,3,-4,4,-5,5,-6,6,-7,7,-8,8,-9,9,-10,10,-11,11,-12,12,-1,1;
];

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(seqList,'%s');

for ix=1:length(tl)
    D=dir(tl{ix});
    lname=strrep(D.name,'.mat','.txt.0');
    if ~(exist(strcat(outputDir,lname),'file'))
        foo=load(tl{ix});
        seq=zeros(length(foo.seq))-1;
        for jx=1:length(foo.seq)-1
            seq(jx)= symboltable(foo.seq(jx),foo.seq(jx+1));
        end
        seq = seq+65; % this just makes the output a tad more readable
        textWriter(char(seq),strcat(outputDir,lname));
    end
end

end
