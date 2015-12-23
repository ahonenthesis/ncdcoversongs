function combineRepresentations(file1,file2,newName,comst)

f1=textread(file1,'%s');
f2=textread(file2,'%s');
f1=f1{:};
f2=f2{:};
toWrite='';

if (comst==1) % concatenate
    toWrite=strcat(f1,f2);
else % merge
    siz1=size(f1,2);
    siz2=size(f2,2);
    for ix=1:min(siz1,siz2)
        toWrite=strcat(toWrite,f1(ix),f2(ix));
    end    
end
    
textWriter(toWrite,newName)

end
