function DrawGoodWindFlags(W)
%load the index from WindIndex.mat. These are acceptable winds
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
idx = importdata('WindIndex.mat');
idx = idx';
PIdx = importdata('PIndex.mat');
s = size(idx,1);

tic

for k=1:s
    i=idx(k);
    if (~isnan(W{i}{2}) & ~isnan(W{i}{4})) %numel == 1
        RC = W{i}{3}(1:2:3,:);
        Lo = W{i}{2}(1,2);  %
        La = W{i}{2}(1,1);  %
        angle = W{i}{4}(1);%
        v = W{i}{4}(2);
        if (isnan(angle) || isnan(v))
        else
            fprintf('(%.2f, %.2f) ==> angle: %.2f,  velocity: %.2f, pressure: %.2f\n', La, Lo, rad2deg(angle), v, PIdx(k));
            DrawWindFlag(RC, v, 64, PIdx(k));
        end
     else
     end
end

toc