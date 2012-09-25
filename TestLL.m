function TestLL(La, Lo)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
[A, B] = LL2AB(deg2rad(La), deg2rad(Lo));
[Lat, Lon] = AB2LL(A, B);
rad2deg([A, B])
[La, Lo] - rad2deg([Lat, Lon])
