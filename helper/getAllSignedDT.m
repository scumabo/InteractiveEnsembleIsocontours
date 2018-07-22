function signedDTs = getAllSignedDT(ensemble, isovalues, upsampleScale)
m = 1;
scales = 1;
if upsampleScale > 1
    scales = [scales upsampleScale];
    m = 2;
end
n = size(isovalues, 2);
p = size(ensemble, 3);
signedDTs = cell(m, n, p);

[I1, I2, I3] = size(ensemble);

for i = 1 : m
    [U1, U2] = getNewDimensions(I1, I2, scales(i));
    for j = 1 : n
        for k = 1 : p
            % Extract binary image of isocontour from dividing cubes
            DF = getDensityField(ensemble(:,:,k), isovalues(j), scales(i));
            DF(DF ~= 0) = 1;
            
            % Compute the distance transform of the binary image
            member = ensemble(:,:,k);
            member = imresize(member, [U1, U2], 'bilinear');
            dt = bwdist(DF, 'euclidean');
            
            % Add sign to DTs
            oneSide = member < isovalues(j);
            dt(oneSide) = -dt(oneSide);
            signedDTs{i, j, k} = dt;
        end
    end
    fprintf(sprintf('===========Computed the signed DTs for level %d of all isovalues \n', scales(i)));
end

end