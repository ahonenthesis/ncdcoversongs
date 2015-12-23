function [ncdist] = bzip2dist(file1,file2,tempdir)

comm='bzip2 -k';
suf='.bz2';

% first file, compress if needed
d1=dir(file1);
d1c=strcat(tdir,d1.name,suf);
if ~exist(d1c)
    com1=[comm,' ',d1c,' ',file1];
    system(com1);
end

% second file, same thing
d2=dir(file2);
d2c=strcat(tdir,d2.name,suf);
if ~exist(d2c)
    com2=[comm,' ',d2c,' ',file2];
    system(com2);
end

% concatenate files and write, if necessary
d3name=strcat(tdir,d1.name,'_',d2.name);
d3c=strcat(d3name,suf{comp});
if ~exist(d3c)
    ccom=['cat ',file1,' >> ' d3name];
    system(ccom);
    ccom=['cat ',file2,' >> ' d3name];
    system(ccom);
    %{
    data1=textread(file1,'%s','bufsize',8192);
    data2=textread(file2,'%s','bufsize',8192);
    data3=[data1{:} data2{:}];
    twrite(data3,d3name);
    %}
end
% ...and compress if needed

% FIXAILES TÄSTÄ TOTA NOIN!

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