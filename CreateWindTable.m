function CreateWindTable(W, SaveFile)
%W: cell array. cell = {[LatDegree, LonDegree], [LatDegree2, LonDegree2], [3PointsRC], [VAngle, VValue]}
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
tic

if (nargin == 1)
    SaveFile = 'winsh.txt';
end

f = fopen(SaveFile, 'w');
fprintf(f, '纬度    经度    角度(北顺)  速度(米/秒)\n');
s = size(W,1);
for i=1:s
     if (~isnan(W{i}{2}) & ~isnan(W{i}{4})) %numel == 1
        Lo = W{i}{2}(1,2);
        La = W{i}{2}(1,1);
        angle = W{i}{4}(1);
        v = W{i}{4}(2);
        if (isnan(angle) || isnan(v))
        else
            fprintf(f, '%-8.2f%-8.2f%-12.2f%-10.2f\n', Lo, La, rad2deg(angle), v);
        end
     else
     end
end

%TODO: p

fclose(f);

fprintf('Create wind table finished\n');
toc