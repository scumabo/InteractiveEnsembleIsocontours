% Return the coordinate in lat and lon
function [Lines, Vertices, Objects] = isocontourLL(data, isovalue, LON, LAT)
    [Lines, Vertices, Objects] = isocontour(data, isovalue);
    X = Vertices(:, 1);
    Y = Vertices(:, 2);
    lX = max(round(min(X(:))), floor(X));
    rX = min(round(max(X(:))), ceil(X));
    bY = max(round(min(Y(:))), floor(Y));
    uY = min(round(max(Y(:))), ceil(Y));
    lbLON = LON(sub2ind(size(LON),lX,bY));
    luLON = LON(sub2ind(size(LON),lX,uY)); 
    rbLON = LON(sub2ind(size(LON),rX,bY));
    ruLON = LON(sub2ind(size(LON),rX,uY));
    
    lbLAT = LAT(sub2ind(size(LAT),lX,bY));
    luLAT = LAT(sub2ind(size(LAT),lX,uY)); 
    rbLAT = LAT(sub2ind(size(LAT),rX,bY));
    ruLAT = LAT(sub2ind(size(LAT),rX,uY));
    
    wlu = zeros(size(X, 1), 1);
    wlb = zeros(size(X, 1), 1);
    wru = zeros(size(X, 1), 1);
    wrb = zeros(size(X, 1), 1);
    
    iXY = find(uY == bY  & rX == lX);
    iY = find(uY ~= bY  & rX == lX);
    iX = find(uY == bY  & rX ~= lX);
    iO = find(uY ~= bY  & rX ~= lX);
    
    
    wlu(iXY) = 1;
    wlb(iXY) = 0;
    wru(iXY) = 0;
    wrb(iXY) = 0;
    
    wlu(iX) = (rX(iX) - X(iX)) ./ (rX(iX) - lX(iX));
    wlb(iX) = 0;
    wru(iX) = (X(iX) - lX(iX)) ./ (rX(iX) - lX(iX));
    wrb(iX) = 0;
    
    wlu(iY) = (Y(iY) - bY(iY)) ./ (uY(iY) - bY(iY));
    wlb(iY) = 0;
    wru(iY) = 0;
    wrb(iY) = (uY(iY) - Y(iY)) ./ (uY(iY) - bY(iY));
    
    wlu(iO) = ((rX(iO) - X(iO)) .* (Y(iO) - bY(iO))) ./ ((rX(iO) - lX(iO)) .* (uY(iO) - bY(iO)));
    wlb(iO) = ((rX(iO) - X(iO)) .* (uY(iO) - Y(iO))) ./ ((rX(iO) - lX(iO)) .* (uY(iO) - bY(iO)));
    wru(iO) = ((X(iO) - lX(iO)) .* (Y(iO) - bY(iO))) ./ ((rX(iO) - lX(iO)) .* (uY(iO) - bY(iO)));
    wrb(iO) = ((X(iO) - lX(iO)) .* (uY(iO) - Y(iO))) ./ ((rX(iO) - lX(iO)) .* (uY(iO) - bY(iO)));
    
    xLON = wlu.*luLON + wlb.*lbLON + wru.*ruLON + wrb.*rbLON;
    xLAT = wlu.*luLAT + wlb.*lbLAT + wru.*ruLAT + wrb.*rbLAT;
    
    Vertices(:, 1) = xLAT;
    Vertices(:, 2) = xLON;
    
end