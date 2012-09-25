function V = VelocityS(P)
%VELOCITYS  Compute the velocity by 2 given points(Lat, Lon) on a Sphere.
% V = VELOCITYS(Points 2x2)
% return the velocity with angle and value
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012

global Earth_R Const_dt;
dLat = P(2,1)-P(1,1);
a = acos(sin(P(1,2))*sin(P(2,2))+cos(P(1,2))*cos(P(2,2))*cos(dLat)); %(0, pi)

if (dLat<0)
    a = -a;
end


d = Earth_R*a;
v = abs(d/(2*Const_dt));
sA=sin(dLat)*cos(P(2,2))/sin(a);
%abs(sA) may a litter larger than 1, then asin is complex
if (sA > 1)
    sA = 1;
elseif (sA < -1)
    sA = -1;
end
A = asin(sA); %(-pi/2, pi/2)

dLon = P(2,2)-P(1,2);
if (dLon<0)
    if (dLat > 0)
        A = pi - A;
    else
        A = A - pi;
    end
else
    if (dLat<0)
        A = -A;
    end
end

V = [A, v];
