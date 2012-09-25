function [AB] = LL2AB(LL)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
global Const_Lat0 Const_ba2;

Lat = LL(:,1);
Lon = LL(:,2);
dLat = Lat - Const_Lat0;
dLon = Lon;
k = tan(dLon);
q = realsqrt(k.^2 + Const_ba2);
s = Const.Hb*q;
p = realsqrt(1 + s.^2 - 2*s.*cos(dLat));
B = atan(k./p);
A = asin(sin(dLat)./p);
AB = [A, B];