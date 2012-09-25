function c = Gaussian3Fit(X, Y)
%NOT FINISHED

a = [6000000 7000 180 250 560 870 4.6e+15 -2255 400];
f = @(a,x)a(1)*exp(-((x-a(2))/a(3)).^2)+a(4)*exp(-((x-a(5))/a(6)).^2)+a(7)*exp(-((x-a(8))/a(9)).^2);
c = lsqcurvefit(f,a,X,Y);

%give y, find the 2rd least small x in (0.1, 1000)
