
function data = getDataCells(upSampled, isovalue)
data = 0;
[I1, I2, I3] = size(upSampled);
for i = 1 : I3
    member = upSampled(:, :, i);
    
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
    
    % Three intersection configurations
    cross_index = find(intensity_min <= isovalue & intensity_max >= isovalue);
    
    [I, J] = ind2sub(size(intensity_min),cross_index);
    newData = [J, I];
    if data == 0
        data = newData;
    else
        data = [data; newData];
    end
end
end