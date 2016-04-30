% Writes sequence data to ASCII files. Utilized with vector quantization,
% binary quantization, and chroma contour representations.
%
% input:
% seqList   - list of sequences
% outputDir - directory where the labeled files will be written
% qtype     - quantization type; either 'vq', 'bc', or 'cc'
% qsize     - used only with vq; this is either 12, 24, 36, 48, or 60
%
% No parameter checking is currently implemented, use carefully.
function labelQuantizedSeqs(seqList, outputDir, qtype, size)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(seqList,'%s');

if (qtype=='vq')
    bpo = size/12; % quantization depth
    for ix=1:length(tl)
        D=dir(tl{ix});
        lname=strrep(D.name,'.mat','.txt');
        if ~(exist(strcat(outputDir,lname,'.',num2str(0)),'file'))
            foo=load(tl{ix});
            for jx=0:11 % 12 transpositions
                tseq=mod(foo.seq+bpo*jx,bpo*12);
                tseq(find(tseq==0))=bpo*12;
                textWriter(char(tseq)',strcat(outputDir,lname,'.',num2str(jx)));
            end
        end
    end    
elseif (qtype=='bc')
    for ix=1:length(tl)        
        D=dir(tl{ix});
        lname=strrep(D.name,'.mat','.txt');
        if ~(exist(strcat(outputDir,lname,'.',num2str(0)),'file'))
            foo=load(tl{ix});
            for jx=0:11 % 12 transpositions
                tseq=mod(foo.seq+jx,12);
                tseq(find(tseq==0))=12;
                textWriter(char(tseq)',strcat(outputDir,lname,'.',num2str(jx)));
            end
        end
    end    
elseif (qtype=='cc') % key invariant, no transpositions needed
    for ix=1:length(tl)        
        D=dir(tl{ix});
        lname=strrep(D.name,'.mat','.txt.0');
        if ~(exist(strcat(outputDir,lname),'file'))
            foo=load(tl{ix});
            textWriter(char(foo.seq+65)',strcat(outputDir,lname));
        end
    end
else
    disp('Unknown parameters!')
end


end
