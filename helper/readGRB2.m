function [tempData, lat, lon] = readGRB2(nc_file_path, variableName, data_name, level)

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
            tempData = squeeze(dirvar.data(1,1, level,:,:));
        else
            tempData = cat(3, tempData, squeeze(dirvar.data(1,1,level, :,:)));
        end
        
        lat=nc{'lat'}(:);
        lon=nc{'lon'}(:);
        
    end
    
    % Convert to double precison
    tempData = double(tempData);
    lat = double(lat);
    lon = double(lon);
    
    % Crop data to particular region
    r_lat12 = [82, 12];
    r_lon12 = [180, 315];
%      r_lat12 = [65, 20];
%     r_lon12 = [210, 320];
    
    tempData = tempData((91-r_lat12(1)): (91-r_lat12(2)), r_lon12(1):r_lon12(2), :);
    lat = r_lat12(1):-1:r_lat12(2)';
    lon = r_lon12(1):r_lon12(2)';
    
   [lon, lat] = meshgrid(lon, lat);