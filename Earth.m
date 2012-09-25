%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
classdef Earth
    properties (Constant = true)
        a = 6378136.5;
        b = 6356751.8;
        e = sqrt(1-(Earth.b/Earth.a)^2);
    end
end


