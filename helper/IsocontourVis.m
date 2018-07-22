clc
clear
close all

%****** Various ensemble isocontour visualization methods: spaghetti plot,
%****** animation.
addpath('./nctoolbox')
setup_nctoolbox

path_name = '../../Data/';
data_folder = 'GEFS/gens_3_2017081000_10';
data_name = 'gens-a_3_20170810_0000_018';

% File structure (hard code)
data_dir = sprintf('%s/%s/', path_name, data_folder);
nc_file_path = sprintf('%s/%s', data_dir, data_name);
output_path = '../voreen-src-4.4-win/data/GEFS/new';

% Prepare data: read and crop
[ensemble, lat, lon] = readGRB2_Elevation(nc_file_path, 'Temperature_isobaric'); echo off

% TODO: Crop
% a = ensemble();
% ROI = meshgrid(10:I1/2, 1:I2, 1:I3);
% [ensemble, lat, lon, I1, I2, I3] = cropEns(ensemble, lat, lon, ROI);


%% Isocontour configuration
isovalue = 230;
numInterpFrame = 5;
orderType = 'ID';

% Statistics of the Raw data
STD = std(ensemble, 0, 3);
ensembleMean = mean(ensemble, 3);
densityField = getDensityField(ensemble, isovalue);

tic
disp('===========Extracting mean isocontour');
[meanLines,meanVertices,meanObjects] = isocontour(ensembleMean, isovalue);
toc

% Reorder the slices along z (for animation)
[HDMap, Order, ensReordered, rawLines, rawVertices, rawObjects] = isoContourStatistics(ensemble, meanVertices, isovalue, orderType);
tic

% disp('===========Extracting stacked 3D isosurface');
% isosurface(ensReordered, isovalue);
% hold on;
% slice(ensReordered, 0, 0, 1);
%  T = [1 0 0 0;0 1 0 0;0 0 1 0]
% h3 = slice3i(ensReordered,T,3,1);
% view(30,45); 
% toc

% Upsampling along z (more frames)
ensInterpolated = InterpolateZ(ensReordered, numInterpFrame);

tic
disp(sprintf('===========Extracting isocontrous for %d slices', size(ensInterpolated, 3)));
[itpLines, itpVertices, itpObjects] = computeIsoContours(ensInterpolated, isovalue);
toc

%% Visualization
% Surface plot
% figure
% elevatedDensity = densityField + 40;
% surf(elevatedDensity);
% hold on
% imagesc(elevatedDensity)
% colorbar

% Spaghetti plot (No interpolation)
[I1, I2, I3] = size(ensReordered);
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1)
hold on
cmap = colormap(jet(I3));
for i = 1 : I3
    plotIsoContour(rawObjects{i, 1}, rawVertices{i, 1}, cmap(i, :), 1);
end

% Mean contour
plotIsoContour(meanObjects, meanVertices, '[0 0 0]', 2);
colorbar
xl = xlim;
yl = ylim;

% Animation
duration = 0;
[I1, I2, I3] = size(ensInterpolated);
cmap = colormap(jet(I3));

ax = subplot(2,1,2);
hold on
for i = 1 : I3
    cla(ax)
    % Plot densityField
    j = flipud(jet);
    j(1,:) = [1 1 1];
    im = imagesc(densityField);
    im.AlphaData = .5;
    colormap(j)
    colorbar

    % Mean contour
%     plotIsoContour(meanObjects, meanVertices, '[0 0 0]', 2); 
    plotIsoContour(itpObjects{i, 1}, itpVertices{i, 1}, '[0 0 0]', 2);
    xlim(xl)
    ylim(yl)
    pause(duration/I3);
end