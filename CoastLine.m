function [CL] = CoastLine()
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
tic
%cl = deg2rad(importdata('cl.txt'));
global cl;
cl_rad = deg2rad(cl);
RC = LL2RC(cl_rad);
CL= [RC(:,2), RC(:,1)];

toc
%scatter(CL(:,1), CL(:,2), 1, 'w');

 