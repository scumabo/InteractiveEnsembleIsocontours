function plotCompareTwoIsocontours (lat, lon, truthObjects, truthVertices, meanObjects, meanVertices)
cla;
m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])


h1 = plotIsoContour(truthObjects{1}, truthVertices{1}, '[0,0,0]', 1);
h2 = plotIsoContour(meanObjects{1}, meanVertices{1}, '[1,0,0]', 1);
alpha(.5)
% Add a coastline and axis values.
m_coast('line')
% m_grid('box','fancy')
legend([h1, h2],'Ground Truth','Observation Mean', 'Location','best')