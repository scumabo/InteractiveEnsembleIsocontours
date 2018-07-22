function [scalarVolume, I1, I2, I3, S1, S2, S3] = readRawVolume(data_name, raw_file_name) 

if strcmp(data_name, 'zeroCurv')
    I1 = 64;
    I2 = 64;
    I3 = 64;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'float' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'zeroCurv')
    I1 = 64;
    I2 = 64;
    I3 = 64;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'float' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'Cylinder')
    I1 = 64;
    I2 = I1;
    I3 = I1;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'float' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'walnut')
    I1 = 100;
    I2 = 74;
    I3 = 88;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    %tmp = fread( fid, [I1*I2 I3], 'int16' );
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);

end

if strcmp(data_name, 'hydrogen')
    I1 = 128;
    I2 = 128;
    I3 = 128;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'obelix')
    I1 = 512;
    I2 = 512;
    I3 = 1559;
    
    S1 = 0.7422;
    S2 = 0.7422;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end


if strcmp(data_name, 'bonsai')
    I1 = 256;
    I2 = 256;
    I3 = 256;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'Sythesized')
    I1 = 50;
    I2 = 50;
    I3 = 20;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'neghip')
    I1 = 64;
    I2 = 64;
    I3 = 64;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end


if strcmp(data_name, 'tooth')
    I1 = 256;
    I2 = 256;
    I3 = 161;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end


if strcmp(data_name, 'Hurricane/T18')
    I1 = 500;
    I2 = 500;
    I3 = 100;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'float' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'Monkey')
    I1 = 256;
    I2 = 256;
    I3 = 62;
    
    S1 = 1;
    S2 = 1;
    S3 = 3;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'box')
    I1 = 64;
    I2 = 64;
    I3 = 64;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'sphere')
    I1 = 64;
    I2 = 64;
    I3 = 64;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'manix')
    I1 = 256;
    I2 = 256;
    I3 = 230;
    
    S1 = 0.48828125;
    S2 = 0.48828125;
    S3 = 0.66669999999999996;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end


if strcmp(data_name, 'engine')
    I1 = 128;
    I2 = 128;
    I3 = 64;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'Bunny')
    I1 = 512;
    I2 = 512;
    I3 = 361;
    
    S1 = 0.337891;
    S2 = 0.337891;
    S3 = 0.5;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint16' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end


if strcmp(data_name, 'marschnerlobb')
    I1 = 40;
    I2 = 40;
    I3 = 40;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end

if strcmp(data_name, 'nucleon')
    I1 = 41;
    I2 = 41;
    I3 = 41;
    
    S1 = 1;
    S2 = 1;
    S3 = 1;
    
    % read raw volume
    fid = fopen(raw_file_name);
    tmp = fread( fid, [I1*I2 I3], 'uint8' );
    scalarVolume = reshape( tmp, [I1 I2 I3]);
    fclose(fid);
    
end
