function ts=transmitTime(in,brdc)
% computes system transmission time given input (in) struct and
% corresponding broadcast (brc) struct
c=299792458;
F=-4.442807633e-10
dtsa=in.pr/c;
tstilda=in.ta-dtsa;
dtr=F*brdc.e*brdc.sqrtA*sin(brdc.Ek);
clockcorr=brdc.af0+brdc.af1*(tstilda-brdc.toc)+brdc.af2*(tstilda-brdc.toc)^2+dtr
ts=tstilda-clockcorr;

end