function RC = Match_std(LL, M0, M1, M2)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
%tic

dRad = deg2rad(0.5);
RCmin = LL2RC(LL - [dRad, -dRad]);
RCmax = LL2RC(LL + [dRad, -dRad]);
RC0 = LL2RC(LL);
r0 = RC0(1,1);
c0 = RC0(1,2);
rmin = RCmin(1,1);
cmin = RCmin(1,2);
rmax = RCmax(1,1);
cmax = RCmax(1,2);
sm = 48;
hsm = round(sm/2) - 1;
wm = 16;
hwm = round(wm/2) - 1;
r =rmax-rmin+1;
c = cmax-cmin+1;

hr = max(wm, ceil(r/2)); %half r
hc = max(wm, ceil(c/2));
%check whether cloud exists in 64x64. if not, return;
M = M0(r0-hr:r0+hr,c0-hc:c0+hc);
% Land and sea < 500.  if has cloud, then max > 500. std2?
meanM = mean2(M);
maxM = max(max(M));
stdM = std2(M);
fprintf('check cloud mean=%f, max=%d, std2=%f \n', meanM, maxM, stdM);
if ( meanM < 525 & maxM < 525 & stdM < 33 )
    RC = NaN
    return;
end

% Find the max std.
STD = zeros(r, c);
MEAN = STD;
for i = rmin - hwm:rmax - hwm
    for j = cmin - hwm:cmax - hwm
        M0s = M0(i:i+hsm-1,j:j+hsm-1);
        STD(i - rmin + hwm + 1,j - cmin + hwm + 1) = std2(M0s);
        MEAN(i - rmin + hwm + 1,j - cmin + hwm + 1) = mean2(M0s);
    end
end

%mesh(STD);
S = max(max(STD));
[r_0, c_0] = find(STD == S);
MM = MEAN(r_0, c_0);
r_0 = rmin - hwm + r_0 - 1 + hwm; %in M0. topleft of rect, so +7
c_0 = cmin - hwm + c_0 - 1 + hwm; %in M0

fprintf('std=%f, mean=%f \n', S, MM);
%{
r_0 = r0 - 7;
c_0 = c0 - 7;
S = std2(M0(r_0:r0+15,c_0:c_0+15));
MM = mean2(M0(r_0:r0+15,c_0:c_0+15));

r_0 = r0;
c_0 = c0;
%}

%find the min diff of abs(std) + abs(mean)

n = 2*hsm - wm +1; %not sm-wm+1.
STD1 = zeros(n, n);
MEAN1 = STD1;


for i = r0 -hsm: r0 + hsm  - wm
    for j = c0-hsm:c0+hsm  - wm+1
        M1s = M1(i:i+wm-1,j:j+wm-1);
        STD1(i -r0 + hsm+1, j-c0+hsm+1) = abs(std2(M1s)-S);
        MEAN1(i -r0 + hsm+1, j-c0+hsm+1) = abs(mean2(M1s)-MM);
    end
end

STD2 = zeros(n, n);
MEAN2 = STD2;
for i = r0 -hsm: r0 + hsm  - wm+ 1
    for j = c0-hsm:c0+hsm  - wm+1
        M2s = M2(i:i+wm-1,j:j+wm-1);
        STD2(i -r0 + hsm+1, j-c0+hsm+1) = abs(std2(M2s)-S);
        MEAN2(i -r0 + hsm+1, j-c0+hsm+1) = abs(mean2(M2s)-MM);
    end
end

SM1 = STD1+MEAN1;
dSM1 = min(min(SM1));
[r_1, c_1] = find(SM1 == dSM1); %topleft of rect
SM2 = STD2+MEAN2;
dSM2 = min(min(SM2));
[r_2, c_2] = find(SM2 == dSM2); %topleft of rect
%if too far, reduce search rect
%FarP = CheckFarPoint([r_1, c_1; r_0, c_0; r_2, c_2]);
%{
c = 1;
while (FarP ~= 0 & c<6)
    if (FarP(1) == 1)
        STD1(FarP(2), FarP(3)) = NaN;
        Mean1(FarP(2), FarP(3)) = NaN;
        SM1 = STD1+MEAN1;
        dSM1 = min(min(SM1));
        [r_1, c_1] = find(SM1 == dSM1); %topleft of rect
    else
        STD2(FarP(2), FarP(3)) = NaN;
        Mean2(FarP(2), FarP(3)) = NaN;
        SM2 = STD2+MEAN2;
        dSM2 = min(min(SM2));
        [r_2, c_2] = find(SM2 == dSM2); %topleft of rect
    end
    c = c+1
    FarP = CheckFarPoint([r_1, c_1; r_0, c_0; r_2, c_2])
end
%}
r_1 = r0 -hsm + r_1 - 1 + hwm;
c_1 = c0-hsm + c_1 - 1 + hwm;
r_2 = r0 -hsm + r_2 - 1 + hwm;
c_2 = c0-hsm + c_2 - 1 + hwm;


%LL=rad2deg(LL)
RC = [r_1, c_1; r_0, c_0; r_2, c_2];

%toc


function FarP = CheckFarPoint(P)

    % Check: remove the point too far.
kmax = 0.618;
kmin = 1.618;
r1 = P(2,:) - P(1,:);
r2 = P(3,:) - P(2,:);
d1 = realsqrt(r1*r1');
d2 = realsqrt(r2*r2');

k = d1/d2;
if (k < kmin)
    FarP = [2, P(3,:)];
elseif (k > kmax)
    FarP = [1, P(1,:)];
else
    FarP = 0;
end