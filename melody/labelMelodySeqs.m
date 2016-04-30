% Writes melody sequences to files according to the chosen representation.
%
% input:
% meloList  - list of melody .mat files
% outputDir - directory where to write the files
% repres    - chosen representation: absolute values ('abs'),
% octave-transposed ('oct'), octave folded ('fol'), or contour ('con')
function labelMelodySeqs(meloList, outputDir, repres)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(meloList,'%s');

if (repres=='abs') % absolute values
    for ix=1:length(tl)
        D=dir(tl{ix});
        lname=strrep(D.name,'.mat','.txt');
        if ~(exist(strcat(outputDir,lname,'.',num2str(0)),'file'))
            foo=load(tl{ix});
             % key transpositions
             for jx=0:11
                 tseq=foo.seq+jx;
                 textWriter(char(tseq),strcat(outputDir,lname,'.',num2str(jx)));
             end
        end        
    end
elseif (repres=='oct')
    for ix=1:length(tl)
        D=dir(tl{ix});
        lname=strrep(D.name,'.mat','.txt');
        if ~(exist(strcat(outputDir,lname,'.',num2str(0)),'file'))
            foo=load(tl{ix});
            % key transpositions
            for jx=0:11
                tseq=foo.seq+jx;
                looper=true;
                while looper
                    mm = mode(tseq);
                    if (mm<48)
                        tseq=tseq+12;
                    elseif (mm>59)
                        tseq=tseq-12;
                    else
                        looper=false;
                    end
                end
                textWriter(char(tseq),strcat(outputDir,lname,'.',num2str(jx)));
             end
        end
    end
elseif (repres=='fol')
    for ix=1:length(tl)
        D=dir(tl{ix});
        lname=strrep(D.name,'.mat','.txt');
        if ~(exist(strcat(outputDir,lname,'.',num2str(0)),'file'))
            foo=load(tl{ix});
            % key transpositions
            for jx=0:11
                tseq=foo.seq+jx;
                tseq=mod(tseq,12)+1;
                textWriter(char(tseq+64),strcat(outputDir,lname,'.',num2str(jx))); % readable form
            end
        end
    end
else
    for ix=1:length(tl)
        D=dir(tl{ix});
        lname=strrep(D.name,'.mat','.txt');
        if ~(exist(strcat(outputDir,lname,'.',num2str(0)),'file'))
            foo=load(tl{ix});
            tseq=diff(foo.seq);
            textWriter(char(tseq+65),strcat(outputDir,lname,'.',num2str(0))); % readable form
        end
    end
end

end
