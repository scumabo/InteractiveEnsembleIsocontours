% ensemble: m x n x p. m x n: 2D data. p: number of ensemble members
% isovalue: specify the value for the isocontour to be extracted
function [Lines, Vertices, Objects] = computeIsoContours(ensemble, isovalue)
    n = size(ensemble, 3);
    Lines = cell(n, 1);
    Vertices = cell(n, 1);
    Objects = cell(n, 1);
    
    for i = 1 : size(ensemble, 3)
        member = ensemble(:, :, i);
        [mLines, mVertices, mObjects] = isocontour(member, isovalue);
        
        Lines{i, 1} = mLines;
        Vertices{i, 1} = mVertices;
        Objects{i, 1} = mObjects;
    end
end