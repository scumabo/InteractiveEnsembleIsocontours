close all
clear
clc

%% Zero
% Parameters
path_name = '../voreen-src-4.4-win/data/';

data_folder = 'zeroCurv';
data_name = 'zeroCurv';
data_dir = sprintf('%s/%s/', path_name, data_folder);
raw_file_name = sprintf('%s/%s.raw', data_dir, data_name);


res = 64;

data = zeros(64, 64, 64);
for i = 1 : res
    data(i, :, :) = i;
end

% vals = unique(cCube);

% Write all the data
[I1, I2, I3] = size(data);
S1 = 1;
S2 = 1;
S3 = 1;

writeVolume(data, 'float', sprintf('%s.raw', data_name), data_dir, I1, I2, I3, S1, S2, S3);

%% Cylinder 
% Parameters
path_name = '../voreen-src-4.4-win/data/';

data_folder = 'Cylinder';
data_name = 'Cylinder';
data_dir = sprintf('%s/%s/', path_name, data_folder);
raw_file_name = sprintf('%s/%s.raw', data_dir, data_name);

res = 32;
x = linspace(-1,1,res);
y = linspace(-1,1,res);
z = linspace(-1,1,res);

[X,Y] = meshgrid(x,y);

cCube = X.^2 + Y.^2;
Cylinder = zeros(res, res, res);
for i = 1 : res
    Cylinder(:,:,i) = cCube;
end
Cylinder = Cylinder * 100;
% vals = unique(cCube);

% Write all the data
[I1, I2, I3] = size(Cylinder);
S1 = 1;
S2 = 1;
S3 = 1;

writeVolume(Cylinder, 'float', sprintf('%s_%d.raw', data_name, res), data_dir, I1, I2, I3, S1, S2, S3);

