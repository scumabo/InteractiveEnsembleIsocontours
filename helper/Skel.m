clc
clear
close all

addpath('./nctoolbox')
setup_nctoolbox

path_name = '../../Data/';
data_folder = 'Historical/';
data_name = 'hgt_pres_latlon_all_20011119_20011122_scumVBeTwL';

% File structure (hard code)
data_dir = sprintf('%s/%s/', path_name, data_folder);
nc_file_path = sprintf('%s/%s', data_dir, data_name);
output_path = '../voreen-src-4.4-win/data/GEFS/new'; % pre-processed data for Voreen

% Prepare data: read and crop
[ensemble, lat, lon] = readNETCDF4(nc_file_path, 'Geopotential_height'); echo off
[LON, LAT] = meshgrid(lon, lat);

% upsample image
scale = 10;
upEnsemble = zeros(size(ensemble, 1)*scale, size(ensemble, 2)*scale, size(ensemble, 3));
for i = 1 : size(ensemble, 3)
    upEnsemble(:, :, i) = imresize(ensemble(:, :, i), scale);
end
ensemble = upEnsemble;
ensemble = ensemble(:, :, [1, 9, 11]);

% Extract mean
ensMean = mean(ensemble, 3);

%% Isocontour (Plot)
% isovalue = 5640;
% 
% [ensLines, ensVertices, ensObjects] = computeEnsIsocontours(ensemble, isovalue);
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% for i = 1 : size(ensemble, 3)
%     for j = 1 : size(isovalue, 2)
%         mObjects = ensObjects{i, j};
%         mVertices =  ensVertices{i, j};
%         for k=1:length(mObjects)
%             mPoints=mObjects{k};
%             x = mVertices(mPoints, 2);
%             y = mVertices(mPoints, 1);
%             hold on
%             plot(x, y, 'Color', '[0 0 0]', 'LineWidth', 2);
%             xlim([1 size(ensemble, 2)])
%             ylim([1 size(ensemble, 1)])
%             axis off
%         end
%     end
% end
% f=getframe(gcf);
% cdata=f.cdata;
% % cdata = print(gcf, '-RGBImage', 'r200');
% allContourBinary = ~im2bw(cdata, 0);

%% Density contours
isovalue = 5640;
% isovalue = 5200;

meanField = getDensityField(ensMean, isovalue);

% Density field of all curves
densityField = getDensityField(ensemble, isovalue);
allContourBinary = densityField;
allContourBinary(allContourBinary ~= 0) = 1;

%% Skeletonlization of the binary image
DT = bwdist(allContourBinary, 'euclidean');

% Density field of individual curves
ensDT = cell(1, size(ensemble, 3));
DF = cell(1, size(ensemble, 3));
for i = 1 : size(ensemble, 3)
    df = getDensityField(ensemble(:,:,i), isovalue);
    df(df ~= 0) = 1;
    DF{i} = df;
end
% temp1 = DF{1};
% temp2 = DF{2};
% res1 = temp1;
% res2 = temp2;
% res1(temp1 == temp2) = 0;
% res2(temp1 == temp2) = 0;
% DF{1} = res1;
% DF{2} = res2;
for i = 1 : size(ensemble, 3)
    ensDT{i} = bwdist(DF{i}, 'euclidean');
end


% DT = imgaussfilt(DT);
% skel = ridgeDetector(DT, ensDT, 'gradient magnitude');
skel = ridgeDetector(DT, ensDT, 'ridge');

% skel = findRidge(DT);
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% rgbImage = cat(3, meanField, DF{1}, zeros(size(meanField)));
% imshow(rgbImage);

figure('units','normalized','outerposition',[0 0 1 1])
% subplot(1, 2, 1)
imshow(allContourBinary); title('Upsampled')
figure
% subplot(1, 2, 2)
% rgbImage = cat(3, meanField, skel, zeros(size(meanField)));
imshow(skel); title('Medial axis')
% figure
% imshow(DT, []); colormap(jet);colorbar

%% Synthetic exp
% Line
% synIm = zeros(800, 800);
% synIm(200, 200:600) = 1;
% synIm(600, 200:600) = 1;

res = 800;
x = linspace(-1,1,res);
y = linspace(-1,1,res);

[X, Y] = meshgrid(x, y);
% synIm = ((X.^2 + Y.^2 <= 0.21 & X.^2 + Y.^2 >= 0.2) | (X.^2 + Y.^2 <= 0.81 & X.^2 + Y.^2 >= 0.8));
synIm = (X.^2 + Y.^2 >= 0.2 & X.^2 + Y.^2 <= 0.8);


DT = bwdist(~synIm,'euclidean');
% DT = imgaussfilt(DT, 5);
% BW3 = bwmorph(synIm,'skel',Inf);

% Density field of individual curves
ensDT = {};

skel = ridgeDetector(DT, ensDT, 'gradient magnitude');
% skel = ridgeDetector(DT, ensDT, 'ridge');
% skel = imregionalmax(DT);

figure('units','normalized','outerposition',[0 0 1 1])
subplot(1, 2, 1)
imshow(DT, []);
subplot(1, 2, 2)
imshow(skel);

