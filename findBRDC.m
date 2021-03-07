function ind = findBRDC(brdc,prn,ta)
% ind = findBRDC(brdc,prn,ta)
% returns index of BRDC struct with the the same PRN
% or time of clock (toc) as the input PRN and time
% of reception (ta)
% returns -1 if BRDC struct not found
i=-1;
for i = 1:numel(brdc)
    if (brdc(i).prn==prn)&&(brdc(i).toc==ta)
        ind=i;
    end
end
end