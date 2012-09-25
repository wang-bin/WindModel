%A: Lat, B: Lon
function [LL] = AB2LL(AB)
global Const_Lat0 Const_ab2;

kA = tan(AB(:,1));
kB = tan(AB(:,2));
kA2 = kA.^2;
%kB2 = kB.^2;
t = kB./cos(AB(:,1));
t2 = t.^2;
s = Const.Hb;

u2 = Const_ab2;
d = 1 + kA2 + t2.*u2;
Hx = s*d./((d-1)*s+realsqrt(s^2-d.*(s^2-u2))) -1;

Lat = Const_Lat0 + atan(kA.*Hx);
Lon = atan(t./realsqrt(kA2+(1./Hx).^2));
%Lon = atan(sin(Lat-Const.Lat0).*kB./sin(AB(:,1))); %A->0 ?
LL = [Lat, Lon];

%{
kA2 = tan(A)^2;
kB2 = tan(B)^2;
s2 = Const.Hb^2;
u = (s2*kB2/cos(A)^2+kA2-1);
v = (Const.Ha^2-1);
w = 2*kA2 - u*v;
s = 4*kA2 + u^2;
Lat = Const.Lat0 + asin(sqrt((w - sqrt(w^2 - s*v^2))/s));
%tan(B)/sin(A)=tan(dLon)/sin(dLat);
Lon = atan(sin(Lat - Const.Lat0)*tan(B)/sin(A));
%q2 = Const.ba^2;
d = Earth.b^2 *(1+ kA2) + t2*Earth.a^2;
x = Const.SatH - (Const.SatH*Earth.b^2 - realsqrt(Const.SatH^2*Earth.b^4-d*(Const.SatH^2 - Earth.a^2)*Earth.b^2))/d;
Lat = Const.Lat0 + atan(kA*(Const.SatH/x-1));
%}

