function P = T2P_PolyFit(LLDeg, LLTP)
%read WindIndex.mat, get LLDeg, compute RC, get T.
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
global  Pressure KT  bb;
dDeg = 0.28125; %degree
%rc = round(LLDeg/dDeg) + [320, 640];
r = round(LLDeg(1,2)/dDeg) + 320; %rc(1,1)
c = round(LLDeg(1,1)/dDeg);
if (c<1)
    c = c + 640;
end

LL = deg2rad(LLDeg);
RC = LL2RC(LL);
T = KT(bb(RC(1,1), RC(1,2)));

tt=LLTP(r, c, :);
tt = tt(:)';
p = polyfit(Pressure, tt, 3);
%t = polyval(p, T);
q = p - [0 0 0 T];
rs = roots(q);

k = 1;
for i=1:3
    if (~isreal(rs(i)))
    else
        r(k) = rs(i);
        k = k+1;
    end
end

s = size(r',1);
r = sort(r);
if (s == 1)
    P = r(1);
else
    P = r(2);
end
if (~isreal(P) || P<0)
    fprintf('Not real pressure\n');
    P = 555;
end



