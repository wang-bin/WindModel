%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012

fprintf('Prepairing global const vars\n');

global aa bb cc;
global TestP TestPRad;
global cl;
global Earth_a;
global Earth_b;
global Earth_e;
global Earth_R;
global Const_SatH;
global Const_Ha;
global Const_Hb;
global Const_ab;
global Const_ab2;
global Const_ba;
global Const_ba2;
global Const_delta;
global Const_Row0;
global Const_Col0;
global Const_Lat0;
global Const_Lon0;

global Cloud_mean Cloud_std;
global SearchN WindowN;
global Const_dt;

%global LLTP;
global KT;
global Pressure;

%importdata: get struct. 
%load: load var
%aa=importdata('IR1_2030.mat');
%bb=importdata('IR1_2100.mat');
%cc=importdata('IR1_2130.mat');
%Data = importdata('Data.mat');
%TestP= Data.TestP; %importdata('TestP.mat');
%cl =Data.cl; %importdata('cl.mat');
%KT = Data.KT; 
%Pressure = Data.Pressure; %importdata('Pressure.mat');
%LLTP = importdata('temp3.mat');
load('IR1_2030.mat');
load('IR1_2100.mat');
load('IR1_2130.mat');
load('Data.mat');
TestPRad=deg2rad(TestP);

%{ 
%importdata('k_temp.txt', ' ', 3);
%KT = KT.data';
%KT = KT(:);
%}

Earth_a = 6378136.5;
Earth_b = 6356751.8;
Earth_e = sqrt(1-(Earth_b/Earth_a)^2);
Earth_R = (Earth_a+Earth_b)/2;
Const_SatH = 42164000;
Const_Ha = Const_SatH/Earth_a;
Const_Hb = Const_SatH/Earth_b;
Const_ab = Earth_a/Earth_b;
Const_ab2 = Const_ab^2;
Const_ba = Earth_b/Earth_a;
Const_ba2 = Const_ba^2;
Const_delta = 0.00014;
Const_Row0 = 1145;
Const_Col0 = 1145;
Const_Lat0 = deg2rad(86.5);
Const_Lon0 = 0;

Cloud_mean = 512;
Cloud_std = 32;
SearchN = 64;
WindowN = 16;
Const_dt = 30*60; %s
