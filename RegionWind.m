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
        %{
        fprintf('\n(%d, %d)==> ', La, Lo);
        RC = Match_corr(deg2rad([La, Lo]), bb, aa, cc);
        V = NaN;
        if (isnan(RC))
            fprintf('*****NO CLOUD!!!!!!');     
        else
            LL = RC2LL(RC(1:2:3,:)); %first and last point
            %plot(RC(:,2), RC(:,1), 'b', 'LineWidth', 1);
            V = VelocityS(LL)
        end
        w{i} = {[La, Lo], RC, V};
        %}
        i = i+1;
    end
end

if (nargin < 3)
    Wind(P, 'WindPreComputedData.mat');
else
    Wind(P, SaveFile);
end
