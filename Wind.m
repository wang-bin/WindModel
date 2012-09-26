function W = Wind(P, SaveFile)
%P: [Lat, Lon], deg
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
tic
global  aa bb cc;

s = size(P, 1);
W = cell(s, 1);
PRad = deg2rad(P);
%{
parcalc = false;
if (s>40)
    parcalc = true;
end
if (parcalc)
    fprintf('Enabling parallel computing...Wait for open the worker pool');
    matlabpool open;
end
%}
for i = 1:s
    fprintf('\n(%d, %d)==> ', P(i,1), P(i,2));
	RC = Match_corr(PRad(i,:), bb, aa, cc);
	V = NaN;
    CP = NaN;
	if (isnan(RC))
        fprintf('*****NO CLOUD!!!!!!');     
    else
        LL = RC2LL(RC); %first and last point
        CP = LL(2,:);
            %plot(RC(:,2), RC(:,1), 'b', 'LineWidth', 1);
        V = VelocityS(LL(1:2:3,:));
	end
	W{i} = {P(i,:), rad2deg(CP), RC, V};
end
fprintf('\n');
%{
if (parcalc)
    fprintf('Closing worker pool...');
    matlabpool close;
end
%}
toc

if (nargin == 2)
    fprintf('Saving to file==>%s\n', SaveFile);
    save(SaveFile, 'W'); %?? http://blog.sina.com.cn/s/blog_63106cd80100zonv.html
end