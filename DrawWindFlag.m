function DrawWindFlag(RC, v, Len, p)
%RC: 2x2 [Row1, Col1; Row2, Col2]. RC(1,:) is the origin
%v: value of velocity. 
%Len: Flag length
%p: for color
%
% Designed by Wang Bin, Shanghai University
% 24 Sep, 2012, Last modified by Wang Bin at 24 Sep, 2012
if (~ishold)
    hold on;
end

if (nargin < 4)
    p = 555;
    if (nargin < 3)
        Len = 64;
    end
end

if (p>850)
    color = 'b';
elseif (p>500)
    color = 'g';
else
    color = 'r';
end

LenF = Len/3; %Length of feather
width = 1;

A = AngleRC(RC);

[R, C] = FindRC(RC(1,:), A, Len);
plot([RC(1,2) C]', [RC(1,1) R]', 'color', color, 'LineWidth', width);
%draw feather
[r, c] = FindRC([R, C], A + pi/2, LenF);
plot([C c]', [R r]', 'color', color, 'LineWidth', width);


if (v > 20)
    [R, C] = FindRC(RC(1,:), A, Len*3/4);
    [r, c] = FindRC([R, C], A + pi/2, LenF);
    plot([C c]', [R r]', 'color', color, 'LineWidth', width);
    if (v>40)
        [R, C] = FindRC(RC(1,:), A, Len/2);
        [r, c] = FindRC([R, C], A + pi/2, LenF);
        plot([C c]', [R r]', 'color', color, 'LineWidth', width);
    end
end


function A = AngleRC(RC)
%A: angle
R1 = RC(1,1);
R2 = RC(2,1);
C1 = RC(1,2);
C2 = RC(2,2);
dR = R2-R1;
dC = C2-C1;
A = atan(dC/dR);

if (dR < 0)
    if (dC>0)
        A = A+pi;
    else
        A = A-pi;
    end
end

function [R, C] = FindRC(RC0, A, L)
%RC0: origin points
%A: angle
%L: length from RC0(1,:). can be nagtive

R = RC0(1,1) + L*cos(A);
C = RC0(1,2) + L*sin(A);
