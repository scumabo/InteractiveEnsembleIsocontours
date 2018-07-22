function samplePoints = getSamplePoints(ensemble, isovalues, h_level)

[I1, I2, I3] = size(ensemble);
% numHierarchyLvls = 1;
[U1, U2] = getNewDimensions(I1, I2, h_level);

upSampled = zeros(U1, U2, I3);

for i = 1 : I3
    upSampled(:, :, i) = imresize(ensemble(:, :, i), [U1, U2], 'bilinear');
end

n = size(isovalues, 2);
samplePoints = cell(1, n);

for i = 1 : n
    samplePoints{i} = getDataCells(upSampled, isovalues(i));
end

end