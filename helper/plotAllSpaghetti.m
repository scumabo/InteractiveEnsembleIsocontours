function plotAllSpaghetti (lat, lon, ensemble, isovalues, ensObjects, ensVertices, meanObjects, meanVertices)
cla;
m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

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

for i = 1 : size(isovalues, 2)
    plotIsoContour(meanObjects{i}, meanVertices{i}, '[0,0,0]', 2);
end

for i = 1 : size(ensemble, 3)
    for j = 1 : size(isovalues, 2)
        if (j + 1 <= size(densityMap,1))
            plotIsoContour(ensObjects{i, j}, ensVertices{i, j}, densityMap(j + 1, :), 1);
        else
            plotIsoContour(ensObjects{i, j}, ensVertices{i, j}, '[0,0,0]', 1);
        end
%         pause(1)
%         cla;
    end
end

% Add a coastline and axis values.
m_coast('line')
m_grid('box','on')
title('Spaghetti Diagram (ALL Isovalues)')