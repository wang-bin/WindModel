%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
classdef Const
    properties (Constant = true)
        SatH = 42164000;
        Ha = Const.SatH/Earth.a;
        Hb = Const.SatH/Earth.b;
        ab = Earth.a/Earth.b;
        ab2 = Const.ab^2;
        ba = Earth.b/Earth.a;
        ba2 = Const.ba^2;
        delta = 0.00014;
        Row0 = 1145;
        Col0 = 1145;
        Lat0 = deg2rad(86.5);
        Lon0 = 0;
    end
end