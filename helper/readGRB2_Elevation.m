function [tempData, lat, lon] = readGRB2_Elevation(nc_file_path, variableName)

%if(strcmp(data_name, 'gens-a_2_20161031_0000_000'))
tempData = 0;
%     variableName = 'Temperature_height_above_ground';
for i = 0:20
    if i < 10
        nc = ncgeodataset(sprintf('%s_0%d.grb2', nc_file_path, i));
    elseif i >= 10
        nc = ncgeodataset(sprintf('%s_%d.grb2', nc_file_path, i));
    end
    varNames = nc.variables
    
    %         for tmpI = 1:size(varNames, 1)
    %             varName = varNames(tmpI)
    %             dirvar = nc.geovariable(varName);
    %             tmp = dirvar.data(1,1,:,:);
    %             size(tmp)
    %         end
    dirvar = nc.geovariable(variableName);
    if tempData == 0
        tempData = squeeze(dirvar.data(1, 1, 5, :,:));
    else
        tempData = cat(3, tempData, squeeze(dirvar.data(1, 1, 5, :,:)));
    end
    
    lat=nc{'lat'}(:);
    lon=nc{'lon'}(:);
    
end

% Convert to double precison
tempData = double(tempData);
lat = double(lat);
lon = double(lon);



%     g = dirvar.grid_interop(1,:,:);
%
%     pcolorjw(g.lon, g.lat, dir);
%     title(datestr(g.time))
%     timeData  = ncread(nc_file_path,'time');
%     intTimeData  = ncread(nc_file_path,'intTime');
%     latData  = ncread(nc_file_path,'lat');
%     lonData  = ncread(nc_file_path,'lon');
%     ensData  = ncread(nc_file_path,'ens');
%     tempData  = ncread(nc_file_path,'Temperature_surface');

% figure
% subplot(2,2,1)
% surf(double(tempData(:,:,1)))
% subplot(2,2,2)
% surf(double(tempData(:,:,2)))
% subplot(2,2,3)
% surf(double(tempData(:,:,3)))
% subplot(2,2,4)
% surf(double(tempData(:,:,4)))
end

