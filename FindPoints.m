
function [P] = FindPoints(M1, R, C, M0, M2)
tic
m1c = M1(R-7:R+8, C-7:C+8);
m1 = M1(R-31:R+32, C-31:C+32);
m0 = M0(R-31:R+32, C-31:C+32);
m2= M2(R-31:R+32, C-31:C+32);
%{
P(1,:) = Match_corr(m0, m1c) + [R-31, C-31];
P(2,:) = [R, C];
P(3,:) = Match_corr(m2, m1c) + [R-31, C-31];
%}
RC1 = Match_sum(abs(m0-m1));
RC2 = Match_sum(abs(m2-m1));
P(1,:) = RC1 + [R-31, C-31];
P(2,:) = [R, C];
P(3,:) = RC2 + [R-31, C-31];

toc
