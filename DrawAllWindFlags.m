function DrawAllWindFlags(W)
%W: cell array. cell = {[LatDegree, LonDegree], [LatDegree2, LonDegree2], [3PointsRC], [VAngle, VValue]}
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
tic
fprintf('Drawing wind flags...\n');

s = size(W,1);
for i=1:s
     if (~isnan(W{i}{2}) & ~isnan(W{i}{4})) %numel == 1
        RC = W{i}{3}(1:2:3,:);
        Lo = W{i}{2}(1,2);  %
        La = W{i}{2}(1,1);  %
        angle = W{i}{4}(1);%
        v = W{i}{4}(2);
        if (isnan(angle) || isnan(v))
        else
            fprintf('(%.2f, %.2f) ==> angle: %.2f,  velocity: %.2f\n', La, Lo, rad2deg(angle), v);
            DrawWindFlag(RC, v);
        end
     else
     end
end

%TODO: p

fprintf('Wind flags finished\n');
toc
