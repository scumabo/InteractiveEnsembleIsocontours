function plotMeanSpread(lat, lon, STD, meanObjects, meanVertices, numSamples)
cla;
m_proj('lambert','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

% Next, plot the field using the M_MAP version of pcolor.
m_pcolor(lon, lat, STD);
shading interp;
stdMap = parula(10);
% stdMap(1,:) = [1 1 1];
colormap(stdMap)
colorbar

for i = 1 : numSamples
    plotIsoContour(meanObjects{i}, meanVertices{i}, '[0,0,0]', 2);
end
% Add a coastline and axis values.
m_coast('line')
m_grid('box','fancy')
title('Mean / Spread Diagram')