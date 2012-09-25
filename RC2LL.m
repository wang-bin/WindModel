function [LL] = RC2LL(RC)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
B = (Const.Row0 - RC(:,1))*Const.delta;
A = (RC(:,2) - Const.Col0)*Const.delta;
LL = AB2LL([A, B]);