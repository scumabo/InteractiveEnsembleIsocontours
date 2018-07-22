function writeVolume(scalarVolume, precision, vol_data_name, data_dir, I1, I2, I3, S1, S2, S3)
path = fullfile(data_dir, vol_data_name);
fid = fopen(path, 'w');
for z = 1:1:I3
    for y = 1:1:I2
        fwrite(fid, scalarVolume(:,y,z), precision);
    end
end
fclose(fid);
writeDat(data_dir, vol_data_name, I1, I2, I3, precision, S1, S2, S3);