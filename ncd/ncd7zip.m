% 7zip-based NCD calculator, mainly for ppm but supports bzip2 and gzip
% too. More detailed instructions to appear one day...
function [ncd] = ncd7zip(file1,file2,tdir,comp)

comm={
    '7z a -bd -t7z -m0=lzma',... % -m here redundant
    '7z a -t7z -m0=bzip2',...
    '7z a -t7z -m0=ppmd'
    };
    
suf={'.gz','.bz2','.ppm'};

% first file, compress if needed
d1=dir(file1);
d1c=strcat(tdir,d1.name,suf{comp});
if ~exist(d1c)
    com1=[comm{comp},' ',d1c,' ',file1,' ','>/dev/null'];
    system(com1);
end

% second file, same thing
d2=dir(file2);
d2c=strcat(tdir,d2.name,suf{comp});
if ~exist(d2c)
    com2=[comm{comp},' ',d2c,' ',file2,' ','>/dev/null'];
    system(com2);
end

% concatenate files and write, if necessary
d3name=strcat(tdir,d1.name,'_',d2.name);
if ~exist(d3name)
    ccom=['cat ',file1,' >> ' d3name];
    system(ccom);
    ccom=['cat ',file2,' >> ' d3name];
    system(ccom);    
end

% ...and compress if needed

d3c=strcat(d3name,suf{comp});

if ~exist(d3c)
    com3=[comm{comp},' ',d3c,' ',d3name,' ','>/dev/null'];
    system(com3);
end

f1c=dir(d1c);
f2c=dir(d2c);
f3c=dir(d3c);

xy=f3c.bytes;
x=min(f1c.bytes,f2c.bytes);
y=max(f1c.bytes,f2c.bytes);

ncd=(xy-x)/y;

end
