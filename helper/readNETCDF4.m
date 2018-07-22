function [data, lat, lon] = readNETCDF4(nc_file_path, variableName)

nc = ncgeodataset(sprintf('%s.nc', nc_file_path));

varNames = nc.variables

dirvar = nc.geovariable(variableName);

data = permute(squeeze(dirvar(1, :, 2, :, :, :)), [2, 3, 1]);

lat=nc{'lat'}(:);
lon=nc{'lon'}(:);

% Convert to double precison
data = double(data);
lat = double(lat);
lon = double(lon);
    
    
    
  