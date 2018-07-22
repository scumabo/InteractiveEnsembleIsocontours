function plotMeanConditionDensity(lat, lon, allDensityField, numSamples, meanObjects, meanVertices, lower, upper)
m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

[LON, LAT] = meshgrid(lon, lat);
[x, y] = m_ll2xy(LON, LAT);
% Plot densityField
% densityMap = flipud(jet(size(allDensityField, 1)+1));
densityMap = [1 1 1; 
    230/255, 25/255, 75/255; 
    60/255, 180/255, 75/255; 
    0/255, 130/255, 200/255; 
    245/255, 130/255, 48/255; 
    245/255, 130/255, 48/255; 
    70/255, 240/255, 240/255; 
    240/255, 50/255, 230/255; 
    210/255, 245/255, 60/255; 
    250/255, 190/255, 190/255; 
    0/255, 128/255, 128/255; 
    170/255, 110/255, 40/255;
    128/255, 0/255, 0/255;
    0/255, 0/255, 128/255;];
% densityMap(1,:) = [1 1 1];
for i = 1 : size(allDensityField, 1)
    h = m_pcolor(lon, lat, allDensityField{i});
    temp = allDensityField{i} ./ 11;
    condition = temp > lower & temp <= upper;
    temp(condition) = 1;
    temp(~condition) = 0;
    % Map to alpha
    set(h, 'AlphaData', temp, 'facealpha', 'interp','FaceColor', densityMap(i+1, :), 'edgecolor', 'none')

    % Map to color
%     colormap(densityMap)
%     shading interp
    
end
% colormap(densityMap)


% Plot mean
for i = 1 : numSamples
    plotIsoContour(meanObjects{i}, meanVertices{i}, '[0,0,0]', 2);
end

% Add a coastline and axis values.
m_coast('line')
m_grid('box','fancy')
title('Mean / density fields')