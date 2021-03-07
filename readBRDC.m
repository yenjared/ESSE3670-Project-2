function brdc = readBRDC(dataRecord)
% brdc = readBRDC(dataRecord)
% returns brdc struct with broadcast fields from a 
% dataRecord from the broadcast ephemeris file

% line 1
prnE=str2double(spaceDelimit(dataRecord{1}(1:22)));
brdc.prn=prnE(1);
prnE(2)=2000+prnE(2);
brdc.toc=datetime(prnE(2:end));
svc=str2double(fixedWidth(dataRecord{1}(23:end),19));
brdc.af0=svc(1);brdc.af1=svc(2);brdc.af2=svc(3);

% line 2
temp=str2double(fixedWidth(dataRecord{2}(4:end),19));
brdc.Crs=temp(2);
brdc.nDelta=temp(3);
brdc.M0=temp(4);

% line 3
temp=str2double(fixedWidth(dataRecord{3}(4:end),19));
brdc.Cuc=temp(1);
brdc.e=temp(2);
brdc.Cus=temp(3);
brdc.sqrtA=temp(4);

% line 4
temp=str2double(fixedWidth(dataRecord{4}(4:end),19));
brdc.toe=temp(1);
brdc.Cic=temp(2);
brdc.OMEGA=temp(3);
brdc.CIS=temp(4);

% line 5
temp=str2double(fixedWidth(dataRecord{5}(4:end),19));
brdc.i0=temp(1);
brdc.Crc=temp(2);
brdc.omega=temp(3);
brdc.OMEGADOT=temp(4);

%line 6
% line 6
temp=str2double(fixedWidth(dataRecord{6}(4:end),19));
brdc.IDOT=temp(1);
