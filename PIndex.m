function PIndex(W,LLTP)
%load the index from WindIndex.mat. These are acceptable winds
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
idx = importdata('WindIndex.mat');
idx = idx';
s = size(idx,1);

tic
PIdx = zeros(s,1);
for k=1:s
    i=idx(k);
    LL = W{i}{1};
    PIdx(k,1) = T2P_PolyFit(LL,LLTP);
    fprintf('(%d, %d) ==> %.2f\r', LL(1), LL(2), PIdx(k,1));
end

save('PIndex.mat', 'PIdx');
toc