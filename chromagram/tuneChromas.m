% Turns 36-bin chromagrams into 12-bin tuned version according to the
% maximum sum values of the bins.
%
% input:
% fileList  - a list of 36-bin chromagram .mat files
% outputDir - directory where the tuned chromas will be written
%
% output:
% chromaList - text file with the names of the chromagram .mat files
function [chromaList] = tuneChromas(fileList,outputDir)

if (~exist(outputDir,'dir'))
    mkdir(outputDir);
end

tl=textread(fileList,'%s');

D=dir(fileList);
lname=D.name;
chromaList=strcat(outputDir,lname);
fid=fopen(chromaList,'w');

for ix=1:length(tl)
    foo=load(tl{ix});
    D=dir(tl{ix});
    savefile=strcat(outputDir,D.name);
    if ~(exist(savefile,'file'))
        dlen = length(foo.data);
        data = zeros(12,dlen);
        [~,qq] = max(sum(foo.data,2));
        if (mod(qq,3)==1) % in "tune"
            data(1,:) = foo.data(36,:)+sum(foo.data(1:2,:));
            for jx=2:12
                jjx1 = jx*3-3;
                jjx2 = jx*3-1;
                data(jx,:)=sum(foo.data(jjx1:jjx2,:));
            end            
        elseif (mod(qq,3)==0) % "flat"            
            data(1,:) = foo.data(1,:)+sum(foo.data(35:36,:));
            for jx=2:12
                jjx1 = jx*3-4;
                jjx2 = jx*3-2;
                data(jx,:)=sum(foo.data(jjx1:jjx2,:));
            end
        else % sharp
            for jx=1:12
                jjx1 = jx*3-2;
                jjx2 = jx*3;
                data(jx,:)=sum(foo.data(jjx1:jjx2,:));
            end
        end
        for kx=1:dlen % normalize            
            data(:,kx) = data(:,kx)/max(data(:,kx));
        end
        save(savefile,'data');
    end
    fprintf(fid,'%s\n',savefile);
end

end
