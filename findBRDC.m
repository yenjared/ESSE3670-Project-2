function ind = findBRDC(brdc,prn,ta)
% ind = findBRDC(brdc,prn,ta)
% finds nearest broadcast message wrt to reception time (ta) of the
% same PRN and most recent broadcast epoch (toc)
%
% returns -1 if BRDC struct not found or 0 if there's a duplicate

ind=-1;

% finds tatoc = most recent broadcast epoch (toc) wrt reception time (ta)
[y,m,d,h,~,~]=datevec(ta);
hrs=[0:2:24]; % satellites broadcast every even hr
hrs=hrs(hrs<h); % keeps all even hours below reception time
htoc=hrs(end); % extracts most recent even hr before reception time
tatoc=datetime(y,m,d,htoc,0,0);

matchNum=0;
% checks each brdc struct entry
% if input PRN == brdc prn 
% and
% rounded broadcast epoch == most recent broadcast epoch of ta
% then return index
for i = 1:numel(brdc)
    if (brdc(i).prn==prn)&&(brdc(i).tocnear==tatoc)
        ind=i;
        matchNum=matchNum+1;
        if (matchNum>1)
            ind=0;
            break;
        end
    end
end
end