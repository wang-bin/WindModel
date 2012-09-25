%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
function jwd()
tic

delta = Const.delta;
M = 50;
N = 50;
%D = cell(M, N);
f = fopen('jwd.txt', 'w');
for i = 1:M;
    for j = 1:N
        LL = RC2LL([450+i, 450+j]);
        fprintf(f, '(%f, %f) ', rad2deg(LL(1)), rad2deg(LL(2)));
    end
    fprintf(f, '\n');
end
fclose(f);

toc