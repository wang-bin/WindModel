function N = CheckWind(W)
%W: cell array. cell = {[LatDegree, LonDegree], [LatDegree2, LonDegree2], [3PointsRC], [VAngle, VValue]}
%remove angle < 90
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
tic

s = size(W,1);
N = 0;
Idx = [];
for i=1:s
     if (~isnan(W{i}{2}) & ~isnan(W{i}{4})) %numel == 1
        Lo = W{i}{2}(1,2);
        La = W{i}{2}(1,1);
        angle = W{i}{4}(1);
        v = W{i}{4}(2);
        if (isnan(angle) || isnan(v))
        else
            fprintf('(%2f, %.2f%)', Lo, La);
            %Check angle
            LL = RC2LL(W{i}{3});
            A1 = AngleS(LL(1:2,:));
            A2 = AngleS(LL(2:3,:));
            dA = abs(A2 -A1);
            if (dA > pi/2)
                fprintf('==>Angle changes too much: %.2f', rad2deg(dA));
            else
                N = N+1;
                Idx(N) = i;
            end
            fprintf('\n');
        end
     else
     end
end
fprintf('%d points found', N);
toc

save('WindIndex.mat', 'Idx');


function A = AngleS(P)
%compute the angle of the given 2 points to Lat on a sphere

dLat = P(2,1)-P(1,1);
a = acos(sin(P(1,2))*sin(P(2,2))+cos(P(1,2))*cos(P(2,2))*cos(dLat)); %(0, pi)

if (dLat<0)
    a = -a;
end

sA=sin(dLat)*cos(P(2,2))/sin(a);
%abs(sA) may a litter larger than 1, then asin is complex
if (sA > 1)
    sA = 1;
elseif (sA < -1)
    sA = -1;
end
A = asin(sA); %(-pi/2, pi/2)

dLon = P(2,2)-P(1,2);
if (dLon<0)
    if (dLat > 0)
        A = pi - A;
    else
        A = A - pi;
    end
else
    if (dLat<0)
        A = -A;
    end
end
