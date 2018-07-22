function plotDensityAlpha(lat, lon, allDensityField, numIsos, meanObjects, meanVertices, level)
cla;
m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

[U1, U2] = size(allDensityField{level, 1});
lat = imresize(lat, [U1, U2], 'bilinear');
lon = imresize(lon, [U1, U2], 'bilinear');
levelDF = allDensityField(level, :);
finestDF = allDensityField(size(allDensityField, 1), :);

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
    finestIsoDensity = finestDF{i};
    
    % Tresholding
%     condition = isoDensity >= 1.2e-5;
%     isoDensity(condition) = 1;
%     isoDensity(~condition) = 0;
%     
%     isoDensity(isoDensity ~= 1) = finestIsoDensity(isoDensity ~= 1);
%     isoDensity(isoDensity ~=0 ) = 1;

    % No opacity
    binary = zeros(size(isoDensity));
    binary(isoDensity > 0) = 1;
    
    h = m_pcolor(lon, lat, isoDensity);
   
    set(h, 'AlphaData', binary, 'FaceAlpha', 'interp', 'FaceColor', densityMap(i+1, :), 'edgecolor', 'none')
    hold on;
    % With opacity
%     h = m_pcolor(lon, lat, isoDensity);
%    
%     set(h, 'AlphaData', isoDensity, 'FaceAlpha', 'interp', 'FaceColor', densityMap(i+1, :), 'edgecolor', 'none')
end

% colormap(densityMap)

% Plot mean
% for i = 1 : numIsos
%     plotIsoContour(meanObjects{i}, meanVertices{i}, '[0,0,0]', 1);
% end

% Add a coastline and axis values.
hold on
m_coast('line')
m_grid('box','on')
% title('Mean / density fields')