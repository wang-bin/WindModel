function [XY] = LL2XY(LL)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
RC = LL2RC(LL);
XY = [RC(:,2), RC(:,1)];