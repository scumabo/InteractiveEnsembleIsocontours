function densityField = getDensityField(ensemble, isovalue, lvl)
[I1, I2, I3] = size(ensemble);
[U1, U2] = getNewDimensions(I1, I2, lvl);

densityField = 0;
% Generate density field of 'isovalue' for each ensemble member.
for i = 1 : I3
    member = ensemble(:, :, i);
    member = imresize(member, [U1, U2], 'bilinear');
    densityField = densityField + isoCellDensity2D(member, isovalue);
end

% Smooth and normalize the density field (Replace with kernel densitiy estimation!)
% densityField = smooth3(isoSamp, 'gaussian', 5, 2);

% densityField = densityField ./ sum(densityField(:));
end


function density = isoCellDensity2D(member, isovalue)
[I1, I2] = size(member);

% Min, max, and span for each cell
intensity_min = Inf(I1-1, I2-1);   %  Min cell member (n-1 * n-1 * n-1)
intensity_max = -Inf(I1-1, I2-1);  %  Max cell member (n-1 * n-1 * n-1)

vertex_idx = {1:I1-1, 1:I2-1; ...
    2:I1, 1:I2-1; ...
    2:I1, 2:I2; ...
    1:I1-1, 2:I2};

for ii=1:4                             % loop thru vertices of all cells
    intensity_min = min(member(vertex_idx{ii, :}), intensity_min);
    intensity_max = max(member(vertex_idx{ii, :}), intensity_max);
end

% Cell span approximate gradient
cell_span = intensity_max - intensity_min;

density = zeros(size(member));
cellDensity = zeros(size(intensity_min));

% Three intersection configurations
cross_index = find(intensity_min < isovalue & intensity_max > isovalue);
boundary_index = find((intensity_min == isovalue & intensity_max ~= isovalue) | (intensity_min ~= isovalue & intensity_max == isovalue));
Homogeneous_index = find(intensity_min == isovalue & intensity_max == isovalue);

% density(cross_index) = 1./cell_span(cross_index);
% density(boundary_index) = 0.5./cell_span(boundary_index);
cellDensity(cross_index) = 1;
cellDensity(boundary_index) = 1;
cellDensity(Homogeneous_index) = 1;

density(1:end-1, 1:end-1) = cellDensity;
end


