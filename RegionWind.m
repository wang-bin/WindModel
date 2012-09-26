%TODO: save data. not plot
function RegionWind(LatRangeDeg, LonRangeDeg, SaveFile)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
%global  aa bb cc;
LatFrom = round(LatRangeDeg(1));
LatTo = round(LatRangeDeg(2));
LonFrom = round(LonRangeDeg(1));
LonTo = round(LonRangeDeg(2));
fprintf(' Lat: %d~%d, Lon: %d~%d \n', LatFrom, LatTo, LonFrom, LonTo);

%w = cell((LonTo-LonFrom+1)*(LatTo-LatFrom+1), 1);

i = 1;
P = zeros((LonTo-LonFrom+1)*(LatTo-LatFrom+1), 2);
for La = LatFrom:LatTo
    for Lo = LonFrom:LonTo
        P(i,:) = [La, Lo];
        i = i+1;
    end
end

if (nargin < 3)
    SaveFile = 'WindPreComputedData.mat');
end
Wind(P, SaveFile);

