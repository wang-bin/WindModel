%TODO: angle, window rect
function RC = Match_corr(LL, M0, M1, M2) %M, C)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
%tic
global SearchN WindowN;
%WindowN = 16;
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



r =rmax-rmin+1;
c = cmax-cmin+1;

hr = max(WindowN, ceil(r/2)); %half r
hc = max(WindowN, ceil(c/2));
%check whether cloud exists in 64x64. if not, return;
M = M0(r0-hr:r0+hr,c0-hc:c0+hc);
% Land and sea < 500.  if has cloud, then max > 500. std2?
meanM = mean2(M);
maxM = max(max(M));
stdM = std2(M);

fprintf('Check {mean:%f, max:%d, std2:%f} ', meanM, maxM, stdM);
if ( meanM < 512 & maxM < 512 & stdM < 32 )
    RC = NaN;
    return;
end


%SearchN = 48;
hsm = round(SearchN/2) - 1;

hwm = round(WindowN/2) - 1;
% Find the max std.
STD = zeros(r, c);
%MEAN = STD;
for i = rmin - hwm:rmax - hwm
    for j = cmin - hwm:cmax - hwm
        M0s = M0(i:i+hsm-1,j:j+hsm-1);
        STD(i - rmin + hwm + 1,j - cmin + hwm + 1) = std2(M0s);
        %MEAN(i - rmin + hwm + 1,j - cmin + hwm + 1) = mean2(M0s);
    end
end

%mesh(STD);
S = max(max(STD));
[r_0, c_0] = find(STD == S);
%MM = MEAN(r_0, c_0);

r_0 = rmin - hwm + r_0 - 1 + hwm; %in M0. topleft of rect, so +7
c_0 = cmin - hwm + c_0 - 1 + hwm; %in M0

C = M0(r_0-hwm:r_0+hwm,c_0-hwm:c_0+hwm);

n = 2*hsm - WindowN +1; %not sm-wm+1.
cc1 = zeros(n, n);
for i = r0 -hsm: r0 + hsm  - WindowN
    for j = c0-hsm:c0+hsm  - WindowN+1
        M1s = M1(i:i+2*hwm,j:j+2*hwm);
        cc1(i -r0 + hsm+1, j-c0+hsm+1) = abs(corr(M1s(:),C(:)));
    end
end

cc2 = zeros(n, n);
for i = r0 -hsm: r0 + hsm  - WindowN
    for j = c0-hsm:c0+hsm  - WindowN+1
        M2s = M2(i:i+2*hwm,j:j+2*hwm);
        cc2(i -r0 + hsm+1, j-c0+hsm+1) = abs(corr(M2s(:),C(:)));
    end
end

cc1m = max(max(cc1));
cc2m = max(max(cc2));

[r_1, c_1] = find(cc1 == cc1m); %topleft of rect
[r_2, c_2] = find(cc2 == cc2m); %topleft of rect

r_1 = r0 -hsm + r_1 - 1 + hwm;
c_1 = c0-hsm + c_1 - 1 + hwm;
r_2 = r0 -hsm + r_2 - 1 + hwm;
c_2 = c0-hsm + c_2 - 1 + hwm;

RC = [r_1, c_1; r_0, c_0; r_2, c_2];

%toc
%{
%C = M(25:40, 25:40);
n = 63 - 16 + 1;
cc = zeros(n, n);
for i = 1:n
    for j = 1:n
        D = M(i:i+15,j:j+15);
        cc(i, j) = corr(C(:), D(:));
    end
end
m = max(max(cc));
[r, c] = find(cc == m);
RC = [r, c] + [7, 7];
%mesh(cc)
%}