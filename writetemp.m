function writetemp(filename,data)
    fid=fopen(filename,'w+');
    for ii=1:length(data)
        fprintf(fid,'%s\n',data(ii,:)); % Ð´×Ö·û´®
    end
end