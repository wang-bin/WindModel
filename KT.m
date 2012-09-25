%KT
function [T] = KT(m, kt)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012

[M, N] = size(m);
T = zeros(M, N);
for i = 1:M
    for j = 1:N
        if (m(i, j) == -1)
            T(i, j) = 0;
        else
            T(i, j) = kt(m(i, j));
        end
    end
end

