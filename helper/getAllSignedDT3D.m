function signedDTs = getAllSignedDT3D(ensemble, isovalues, upsampleScale)
% Compute signedDts at level 1: original data, level 2: upsampled data
if upsampleScale > 1
    m = [1 upsampleScale];
else
    m = 1;
end

n = size(isovalues, 2);
p = size(ensemble, 4);
signedDTs = cell(size(m, 1), n, p);

[I1, I2, I3, I4] = size(ensemble);

for i = 1 : size(m, 2)
    [U1, U2, U3] = getNewDimensions3D(I1, I2, I3, m(i));
    for j = 1 : n
        for k = 1 : p
            % Extract binary image of isocontour from dividing cubes
            DF = getDensityField3D(ensemble(:,:,:,k), isovalues(j), m(i));
            DF(DF ~= 0) = 1;
            
            % Compute the distance transform of the binary image
            member = ensemble(:,:,:,k);
            member = imresize3d(member, [], [U1, U2, U3], 'linear');
            dt = bwdist(DF, 'euclidean');
            % signed DTs
            oneSide = member < isovalues(j);
            dt(oneSide) = -dt(oneSide);
            signedDTs{i, j, k} = dt;
        end
    end
    fprintf(sprintf('===========Computed 3D signed DTs for level %d of all isovalues \n', m(i)));
end

end