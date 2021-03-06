function satPos = findSatPos(brdc1,in1)
% satPos = findSatPos(brdc1,in1)
% returns satellite position in CT coord.s
% given an instance of a brdc struct and an input struct
% satPos = [x,y,z]

% constants
c=299792458;
F=-4.442807633e-10;
mu=3.986005e14;
OMEGADOTe=7.2921151467e-5;

A=brdc1.sqrtA^2;
n0=sqrt(mu/A^3);
n=n0+brdc1.nDelta;
dtsa=in1.pr/c;
tstilda=in1.tasow-dtsa;

%convert broadcast epoch (toc) to seconds of week
tocsow=seconds(brdc1.toc-dateshift(brdc1.toc,'start','week'));

% Compute Eccentric Anomaly

% compute sat. clock correction without relativistic correction
dtsL1=brdc1.af0+brdc1.af1*(tstilda-tocsow)+brdc1.af2*(tstilda-tocsow)^2;
ts=tstilda-dtsL1;
tk=ts-brdc1.toe;
Mk0=brdc1.M0+n*tk;

% Compute eccentric anomaly Ek iteratively
E0=Mk0;
E1=Mk0+brdc1.e*sin(E0);
numLin=1;
dEtrack=E1-E0;
while (abs(E1-E0)>=1e-10)
    Etemp=E1;
    E1=Mk0+brdc1.e*sin(Etemp);
    E0=Etemp;
    
    dE=E1-E0;
    dEtrack=[dEtrack dE];
    numLin=numLin+1;
end
Ek0=E1;
% plot(abs(dEtrack));

% compute sat. clock correction with relativistic correction
% then recompute Ek and Mk wiht new tk
dtr=F*brdc1.e*brdc1.sqrtA*sin(Ek0);

dtsL1=brdc1.af0+brdc1.af1*(tstilda-tocsow)+brdc1.af2*(tstilda-tocsow)^2+dtr;
ts=tstilda-dtsL1;

tk=ts-brdc1.toe;
Mk=brdc1.M0+n*tk;

% Recompute eccentric anomaly Ek iteratively
E0=Mk;
E1=Mk+brdc1.e*sin(E0);
numLin=1;
dEtrack=E1-E0;
while (abs(E1-E0)>=1e-10)
    Etemp=E1;
    E1=Mk+brdc1.e*sin(Etemp);
    E0=Etemp;
    
    dE=E1-E0;
    dEtrack=[dEtrack dE];
    numLin=numLin+1;
end
Ek=E1;
%plot(abs(dEtrack));

Vk=atan2(sqrt(1-brdc1.e^2)*sin(Ek),cos(Ek)-brdc1.e); % true anomaly
PhiK=Vk+brdc1.omega; % arg. of latitude

% Perturbation corrections
dUk=brdc1.Cus*sin(2*PhiK)+brdc1.Cuc*cos(2*PhiK);
drk=brdc1.Crs*sin(2*PhiK)+brdc1.Crc*cos(2*PhiK);
dik=brdc1.CIS*sin(2*PhiK)+brdc1.Cic*cos(2*PhiK);

Uk=PhiK+dUk; % corrected arg. of latitude
rk=A*(1-brdc1.e*cos(Ek))+drk; % corrected radius
ik=brdc1.i0+dik+brdc1.IDOT*tk; % corrected inclination

% positions in orbital plane
xkorbit=rk*cos(Uk); 
ykorbit=rk*sin(Uk);

% corrected longitude of ascending node
OMEGAk=brdc1.OMEGA+(brdc1.OMEGADOT-OMEGADOTe)*tk-OMEGADOTe*brdc1.toe;

% ECEF coordinates
xk=xkorbit*cos(OMEGAk)-ykorbit*cos(ik)*sin(OMEGAk);
yk=xkorbit*sin(OMEGAk)+ykorbit*cos(ik)*cos(OMEGAk);
zk=ykorbit*sin(ik);
satPos=[xk,yk,zk];