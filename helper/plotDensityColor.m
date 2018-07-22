function plotDensityColor(lat, lon, allDensityField, numIsos, meanObjects, meanVertices, level)
cla;
m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

[U1, U2] = size(allDensityField{level, 1});
lat = imresize(lat, [U1, 1], 'bilinear');
lon = imresize(lon, [U2, 1], 'bilinear');
levelDF = allDensityField(level, :);
finestDF = allDensityField(size(allDensityField, 1), :);


j = flipud(jet);
j(1,:) = [1 1 1];

for i = 1 : size(levelDF, 2)
    isoDensity = levelDF{i};
    finestIsoDensity = finestDF{i};
    
    % Tresholding
%     condition = isoDensity >= 1.2e-5;
%     isoDensity(condition) = 1;
%     isoDensity(~condition) = 0;
%     
%     isoDensity(isoDensity ~= 1) = finestIsoDensity(isoDensity ~= 1);
%     isoDensity(isoDensity ~=0 ) = 1;
    
    h = m_pcolor(lon, lat, isoDensity);
    shading interp;
    colormap(j)
    colorbar
end


% Plot mean
for i = 1 : numIsos
    plotIsoContour(meanObjects{i}, meanVertices{i}, '[0,0,0]', 1);
end

% Add a coastline and axis values.
hold on
m_coast('line')
% m_grid('box','fancy')
title('Mean / density fields')