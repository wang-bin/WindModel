function E = CLError(cl)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
tic
cl = deg2rad(cl);
AB = LL2AB(cl);
LL = AB2LL(AB);
E =  cl - LL;
toc
