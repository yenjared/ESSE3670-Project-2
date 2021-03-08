function ind = findBRDC(brdc,prn,ta)
% ind = findBRDC(brdc,prn,ta)
% returns index of BRDC struct with the the same PRN
% or time of clock (toc) as the input PRN and receiver time (ta)
% returns -1 if BRDC struct not found or 0 if there's a duplicate
ind=-1;

% finds nearest broadcast epoch 
% corresponding to reception time
[y,m,d,h,~,~]=datevec(ta);
hrs=[0:2:24]; % satellites broadcast every even hr
hrs=hrs(hrs<h); % removes all satellite hours above reception time
htoc=hrs(end); % extracts closest even hr before reception time
tatoc=datetime(y,m,d,htoc,0,0);

matchNum=0;
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