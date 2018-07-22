function plotMeanDensity(lat, lon, allDensityField, numIsos, meanObjects, meanVertices, level)
cla;
m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

[U1, U2] = size(allDensityField{level, 1});
lat = imresize(lat, [U1, 1], 'bilinear');
lon = imresize(lon, [U2, 1], 'bilinear');
levelDF = allDensityField(level, :);

% [LON, LAT] = meshgrid(lon, lat);
% [x, y] = m_ll2xy(LON, LAT);
% Plot densityField
% densityMap = flipud(jet(size(allDensityField, 1)+1));
densityMap = [1 1 1; 
    230/255, 25/255, 75/255; 
    60/255, 180/255, 75/255; 
    0/255, 130/255, 200/255; 
    245/255, 130/255, 48/255; 
    0/255, 0/255, 128/255;
    70/255, 240/255, 240/255; 
    240/255, 50/255, 230/255; 
    210/255, 245/255, 60/255; 
    250/255, 190/255, 190/255; 
    0/255, 128/255, 128/255; 
    170/255, 110/255, 40/255;
    128/255, 0/255, 0/255;
    0/255, 0/255, 128/255;];

% densityMap(1,:) = [1 1 1];
for i = 1 : size(levelDF, 2)
    
    isoDensity = levelDF{i};
    
    % Select data based on density values
%     condition = isoDensity > 0 & isoDensity <= 1;
%     isoDensity(condition) = 1;
%     isoDensity(~condition) = 0;
    
    
%     gpuDensity = gpuArray(isoDensity);
    h = m_pcolor(lon, lat, isoDensity);
    % Map to alpha : log10(levelDF{i})./log10(11)
    % Mask 1: no alpha
%     mask = zeros(size(isoDensity));
%     mask(isoDensity~=0) = 1;
    
    % Mask 2: Weight Individualy
    mask = isoDensity;
    mask = mask ./ max(mask(:));
%     mask = 1 - mask;
%     mask(isoDensity == 0) = 0;
%     mask = -1.8*mask./(-mask-0.8);
    
    set(h, 'AlphaData', mask, 'FaceAlpha', 'flat', 'FaceColor', densityMap(i+1, :), 'edgecolor', 'none')
    
    % Map to color
%     j = flipud(jet);
%     j(1,:) = [1 1 1];
%     colormap(j)
%     shading interp 
end
% colormap(densityMap)


% Plot mean
for i = 1 : numIsos
    plotIsoContour(meanObjects{i}, meanVertices{i}, '[0,0,0]', 1);
end

% Add a coastline and axis values.
hold on
m_coast('line')
% m_grid('box','fancy')
title('Mean / density fields')