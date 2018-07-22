function plotIndividual(lat, lon, data, id)
cla;
m_proj('Miller Cylindrical','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

% Next, plot the field using the M_MAP version of pcolor.
m_pcolor(lon, lat, data);
shading interp;
stdMap = parula(10);
% stdMap(1,:) = [1 1 1];
colormap(stdMap)
colorbar

% Add a coastline and axis values.
m_coast('line')
m_grid('box','fancy')
title(sprintf('Member %d', id))