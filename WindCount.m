function N = WindCount(LatRangeDeg, LonRangeDeg)
%TODO: V=NaN. Not the final result. just check the 2rd picture.
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
tic
LatFrom = round(LatRangeDeg(1));
LatTo = round(LatRangeDeg(2));
LonFrom = round(LonRangeDeg(1));
LonTo = round(LonRangeDeg(2));
fprintf(' Lat: %d~%d, Lon: %d~%d \n', LatFrom, LatTo, LonFrom, LonTo);

N = 0;
for La = LatFrom:LatTo
    for Lo = LonFrom:LonTo
        fprintf('\n(%d, %d) ', La, Lo);
        r= hasCloud(deg2rad([La, Lo]));
        if (r)
            N = N+1;
        else
            fprintf('==>NO CLOUD!!!\n');
        end
    end
end

fprintf('Wind: %d, Non-wind: %d\n', N, (LatTo-LatFrom+1)*(LonTo-LonFrom+1)-N);
toc




function result = hasCloud(LL)
global bb;
global Cloud_mean Cloud_std;
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
wm = 16;
r =rmax-rmin+1;
c = cmax-cmin+1;

hr = max(wm, ceil(r/2)); %half r
hc = max(wm, ceil(c/2));
%check whether cloud exists in 64x64. if not, return;
M = bb(r0-hr:r0+hr,c0-hc:c0+hc);
% Land and sea < 500.  if has cloud, then max > 500. std2?
meanM = mean2(M);
maxM = max(max(M));
stdM = std2(M);

fprintf('Check {mean:%f, max:%d, std2:%f} ', meanM, maxM, stdM);
if ( meanM < Cloud_mean & maxM < Cloud_mean & stdM < Cloud_std )
    result = 0;
    return;
end

result = 1;