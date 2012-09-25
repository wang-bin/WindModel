% M: 64x64, abs(M2-M1)
function [RC] = Match_sum(M)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
C = M(31-7:31+8, 31-7:31+8);
sumC = sum(sum(C.^2));
n = 63 - 16 + 1 -1; %remove 31,31
cc = zeros(n, n);
for i = 1:n
    for j = 1:n
        if (i == 31-7 && j == 31-7) %
            cc(i, j) = 1000000;
        else
            D = M(i:i+15,j:j+15);
            cc(i, j) = abs(sum(sum(D.^2)) - sumC);
        end
    end
end
m = min(min(cc))
[r, c] = find(cc == m);
RC = [r, c] + 7;
%mesh(cc)
