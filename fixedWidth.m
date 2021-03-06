function str = fixedWidth(line,width)
% fixed_width(line,width)
% converts line of fixed width separated
% values into string row vector 
%
% line  - a char vector containing fixed 
%         width separated values
% width - fixed width separating values

str = [];
if isstring(line)
    line=char(line);
end
if rem(numel(line),width)==0
    startInd = 1:width:numel(line);
    endInd = startInd + width - 1;
else
    startInd = 1:width:numel(line);
    startInd = startInd(1:end-1);
    endInd = startInd + width - 1;
end
for i = 1:numel(startInd)
    str=[str string(line(startInd(i):endInd(i)))];
end
end