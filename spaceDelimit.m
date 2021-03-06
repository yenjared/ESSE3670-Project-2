function str = spaceDelimit(line)
% space_delimit(line)
% converts space delimited char array into string row vector
%
% line - char vector of a row of space delimited values
if isstring(line)
    line=char(line);
end
str = [];
i = 1;
str_element="";
while i <= numel(line)
    if ~strcmp(line(i)," ")
        while ~strcmp(line(i)," ")
            str_element=strcat(str_element,line(i));
            i=i+1;
            if i > numel(line)
                break
            end
        end
        str=[str str_element];
        str_element="";
    end
    i=i+1;
end