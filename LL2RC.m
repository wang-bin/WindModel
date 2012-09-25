%NOTE: map to (x, y): (c, r).  x value is cols, y value is rows;
function [RC] = LL2RC(LL)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
global Const_delta;
global Const_Row0;
global Const_Col0;
[AB] = LL2AB(LL);
r = Const_Row0 - round(AB(:,2)/Const_delta);
c = Const_Col0 + round(AB(:,1)/Const_delta);
RC = [r, c];