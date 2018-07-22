function KDEDFs = getKDEDF(ensemble, isovalues, numHierarchyLvls)
[I1, I2, I3] = size(ensemble);
% numHierarchyLvls = 1;
[U1, U2] = getNewDimensions(I1, I2, numHierarchyLvls);

upSampled = zeros(U1, U2, I3);

for i = 1 : I3
    upSampled(:, :, i) = imresize(ensemble(:, :, i), [U1, U2], 'bilinear');
end

m = 4;
n = size(isovalues, 2);
data = cell(1, n);
[X, Y] = meshgrid(1:U2-1, 1:U1-1);
pts = [X(:) Y(:)];

for i = 1 : n
    data{i} = getDataCells(upSampled, isovalues(i));
end

KDEDFs = cell(m, n);
xi = cell(m, n);
bw = cell(m, n);

for i = 1 : m
    tic
    for j = 1 : n
        bandwidth = [6, 4, 2, 0.5];
        [pdf, xi, bw] = ksdensity(data{j}, pts, 'Bandwidth', bandwidth(i));
        
        KDEDFs{i, j} = reshape(pdf, [U1-1 U2-1]);
        fprintf(sprintf('===========Level %d, isovalue = %d\n', i, isovalues(j)));
%         test = reshape(KDEDFs{1,1}, [U1-1 U2-1]);
%         figure;imshow(test, []); colorbar
    end
    toc
end

end

