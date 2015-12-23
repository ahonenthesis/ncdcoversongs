% Small helper that writes the given string into the named file.
function textWriter(data,fname)
fid = fopen(fname,'w');
for x=data
    fprintf(fid, '%s',x);
end
fclose(fid);
end