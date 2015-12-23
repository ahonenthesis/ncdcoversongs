function [ncdist] = gzipdistance(file1,file2,tempdir)

% FIX polut ja everything

suf='.gz';

%fn1=strcat(file1,suf);
fn1=strcat(tempdir,file1(8:end),suf);
if (~exist(fn1))
    copyfile(file1,strcat(tempdir,file1(8:end)));
    gzip(strcat(tempdir,file1(8:end)));
    %com1 = ['bzip2 -k',' ',file1];
    %com1 = ['bzip2 -k',' ',tempdir,file1];
    %system(com1);
end
A=dir(fn1);
len1=A.bytes;

%fn2=strcat(file2,suf);
fn2=strcat(tempdir,file2(8:end),suf);
if (~exist(fn2))
    copyfile(file2,strcat(tempdir,file2(8:end)));
    gzip(strcat(tempdir,file2(8:end)));
    %com2 = ['bzip2 -k',' ',file2];    
    %com2 = ['bzip2 -k',' ',tempdir,file2]
    %system(com2);
end
B=dir(fn2);
len2=B.bytes;

%D=dir(file1);
D=dir(fn1);
f1=D.name;
%E=dir(file2);
E=dir(fn2);
f2=E.name;

%file3=strcat(tempdir,f1,'_',f2);
file3=strcat(tempdir,file1(8:end),'_',file2(8:end));
fn3=strcat(file3,suf);
if (~exist(fn3)) % concatenation
    aa=textread(file1,'%c')';  
    %aa=textread(strcat(tempdir,file1),'%c')';
    bb=textread(file2,'%c')';
    %bb=textread(strcat(tempdir,file2),'%c')';
    aabb=[aa bb];
    twrite(aabb,file3);  
    gzip(file3);
    %com3 = ['bzip2 -k',' ',file3];
    %system(com3);
end
C=dir(fn3);
len3=C.bytes;

ncdist = (len3-min(len1,len2))/max(len1,len2);

end
