function V = VelocityE(P, a, b)
%VELOCITY  Compute the velocity with given 3 points(Lat, Lon) on a Ellipsoid. Assume the a is const
% V = VELOCITY(Points, a, b)
% return the velocity with angle and value
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012

global Const_ba2 Earth_b;
dt = 30*60; %TODO: global const
dt2 = dt^2;

%Use the 2rd Longitude
r = Earth_b/realsqrt(tan(P(2,2)^2+Const_ba2));
x1 = r*(P(2,1)-P(1,1));
x2 = r*(P(3,1)-P(1,1));
y1 = 
y2 =

ax = (x2-2*x1)/dt2;
v0x = (4*x1-x2)/(2*dt);
v1x = v0x + ax*dt;

ay = (y2-2*y1)/dt2;
v0y = (4*y1-y2)/(2*dt);
v1y = v0y + ay*dt;

v1 = realsqrt(v1x^2+v1y^2);
A1 = atan(v1x/v1y);
V = [A1, v1];


