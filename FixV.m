function FixV(W)
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
tic

s = size(W,1);
for i=1:s
    RC = W{i}{3};
    if (~isnan(RC))
        LL = RC2LL(RC(1:2:3,:)); %first(1:2:3,:) and last point
        V = VelocityS(LL);
        W{i}{4} = V;
    end
end

toc

save 'WindFixed.mat' W;