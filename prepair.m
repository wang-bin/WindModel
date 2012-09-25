%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012

GlobalConst

global CL;

Fig = figure;
colormap('bone');
hold on;
imagesc(aa);
imagesc(bb);
imagesc(cc);
fprintf('Computing coast line...\n');
CL = CoastLine();
fprintf('Drawing coast line...\n');
scatter(CL(:,1), CL(:,2), 1, 'k');
%fprintf('Saving coast line ==> "spic.jpg"...\n');
%saveas(gcf, 'spic.jpg');

