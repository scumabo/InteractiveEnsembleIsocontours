function skel = findRidge(DT)
padDT = padarray(DT, [1, 1], inf);
l = padDT(2:end-1, 1:end-2);
lu = padDT(1:end-2, 1:end-2);
u = padDT(1:end-2, 2:end-1);
ru = padDT(1:end-2, 3:end);
r = padDT(2:end-1, 3:end);
rb = padDT(3:end, 3:end);
b = padDT(3:end, 2:end-1);
lb = padDT(3:end, 1:end-2);

% [fx, fy] = gradient(DT);
% padFX = padarray(fx, [1, 1], inf);
% padFY = padarray(fy, [1, 1], inf);
% lfx = padFX(2:end-1, 1:end-2);
% rfx = padFX(2:end-1, 3:end);
% ufy = padFY(1:end-2, 2:end-1);
% bfy = padFY(3:end, 2:end-1);
% gm = sqrt(fx.^2 + fy.^2);

epslon = 0.4;
skel = zeros(size(DT));
% skel(lfx.*rfx < 0 | ufy.*bfy < 0) = 1;
% skel(abs(fx) < epslon & abs(fy) < epslon) = 1;
% skel(gm < epslon) = 1;

% skel((DT + epslon >= l) & (DT + epslon >= lu) & (DT + epslon >= u) & (DT + epslon >= ru) & (DT + epslon >= r) & (DT + epslon >= rb) & (DT + epslon >= b) & (DT + epslon >= lb)) = 1;

% skel(DT >= l & DT >= u & DT >= r & DT >= b ) = 1;
% skel(abs(DT - l) < thresh & abs(DT - lu) < thresh & abs(DT - u) < thresh  & abs(DT - ru) < thresh & abs(DT - r) < thresh & abs(DT - rb) < thresh & abs(DT - b) < thresh & abs(DT - lb) < thresh) = 1;

cnt = int8(DT >= l) + int8(DT >= lu) + int8(DT >= u) + int8(DT >= ru) + int8(DT >= r) + int8(DT >= rb) + int8(DT >= b) + int8(DT >= lb);
skel(cnt >= 7) = 1;
skel(DT == 0) = 0;