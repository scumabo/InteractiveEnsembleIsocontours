function plotWorldMap()
% Plot the field using M_MAP.  Start with setting the map
% projection using the limits of the lat/lon data itself:
m_proj('miller','lat',[min(lat(:)) max(lat(:))],...
    'lon',[min(lon(:)) max(lon(:))])

% Next, plot the field using the M_MAP version of pcolor.
% m_pcolor(lon, lat, STD);
% shading interp;

% Add a coastline and axis values.
m_coast('line')
m_grid('box','fancy')

% Add a colorbar and title.
title('Global Ensemble Forecast System: 20161031UTC0 Temperature (KURTOSIS)');
end