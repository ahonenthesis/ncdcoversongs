% Similar to bzip2distance. These should be merged...
function [ncdist] = gzipdistance(file1,file2,tdir)

suf='.gz';


% first file, compress if needed
d1=dir(file1);
d1c=strcat(tdir,d1.name,suf);
if ~exist(d1c)
    copyfile(file1,tdir);
    gzip(strcat(tdir,d1.name));
end

% second file, same thing
d2=dir(file2);
d2c=strcat(tdir,d2.name,suf);
if ~exist(d2c)
    copyfile(file2,tdir);
    gzip(strcat(tdir,d2.name));
end

% concatenate files and write, if necessary
d3name=strcat(tdir,d1.name,'_',d2.name);
d3c=strcat(d3name,suf);
if ~exist(d3c)
    ccom=['cat ',file1,' >> ' d3name];
    system(ccom);
    ccom=['cat ',file2,' >> ' d3name];
    system(ccom);
end
% ...and compress if needed
if ~exist(d3c)
    gzip(d3name);
end

f1c=dir(d1c);
f2c=dir(d2c);
f3c=dir(d3c);

xy=f3c.bytes;
x=min(f1c.bytes,f2c.bytes);
y=max(f1c.bytes,f2c.bytes);

ncdist=(xy-x)/y;

end
