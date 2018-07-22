function [HDMap, Order, ensReordered, Lines, Vertices, Objects] = isoContourStatistics(ensemble, meanVertices, isovalue, orderType)
[I1, I2, I3] = size(ensemble);
HDMap = 0;

tic
disp(sprintf('===========Extracting isocontrous for %d slices', size(ensemble, 3)))
[Lines, Vertices, Objects] = computeIsoContours(ensemble, isovalue);
toc

% Hausdorff distance map
% disp('===========Computing Hausdorff Distance Map')
tic
% HDMap = computeHD(Vertices, meanVertices);
toc

% 1. Order by member ID (default)
if strcmp(orderType, 'ID')
    Order = 1 : I3;
    ensReordered = ensemble;
end

% Write vol for voreen (Note: When writing volume => permute first 2 dimension to generate volume used for Voreen.)
% writeVolume(permute(ensReordered, [2 1 3]), 'float', sprintf('%s_%d_ID', data_name, isovalue), output_path, I2, I1, I3, 1, 1, 5);


end

% % % 1. Order by member ID (default)
% OrderID = 1 : I3;
% ensByID = ensemble;
% 
% % % 2. Order by similarity (Hausdorff)
% OrderSimple = simple(HDMap);
% ensBySimple = ensemble(:, :, OrderSimple);
% 
% % % 3. Order by MST;
% % G = graph(HDMap(1:end, 1:end), 'upper');
% % [T, pred] = minspantree(G, 'Root', I3 + 1);
% % OrderMST = getOrder(HDMap, pred);
% % ensByMST = ensemble(:, :, OrderMST);
% % writeVolume(permute(ensByMST, [2 1 3]), 'float', sprintf('%s_%d_MST', data_name, isovalue), output_path, I2, I1, I3, 1, 1, 5);

% Plot the MST
% p = plot(G, 'Layout', 'layered');
% highlight(p, T)
