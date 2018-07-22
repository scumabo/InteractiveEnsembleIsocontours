function plotSegments(lat, lon, labeledData, numIsos, meanObjects, meanVertices)
cla;
m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

[U1, U2] = size(labeledData);
lat = imresize(lat, [U1, 1], 'bilinear');
lon = imresize(lon, [U2, 1], 'bilinear');

j = flipud(jet(double(max(labeledData(:)+1))));
j(1,:) = [1 1 1];

h = m_pcolor(lon, lat, labeledData);
shading flat;
colormap(j)
colorbar


% Plot mean
for i = 1 : numIsos
    plotIsoContour(meanObjects{i}, meanVertices{i}, '[0,0,0]', 1);
end

% Add a coastline and axis values.
hold on
m_coast('line')
% m_grid('box','fancy')
title('Mean / density fields')