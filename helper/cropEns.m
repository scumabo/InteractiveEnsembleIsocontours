function [ensemble, lat, lon, I1, I2, I3] = cropEns(ensemble, lat, lon, ROI)
    ensemble = ensemble(ROI);
    lat = lat(ROI);
    lon = lon(ROI);
    [I1, I2, I3] = size(ensemble);
end