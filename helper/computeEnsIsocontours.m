% ensemble: m x n x p. m x n: 2D data. p: number of ensemble members
% isovalue: specify the value for the isocontour to be extracted
function [ensLines, ensVertices, ensObjects] = computeEnsIsocontours(ensemble, isovalues)
    m = size(ensemble, 3);
    n = size(isovalues, 2);
    ensLines = cell(m, n);
    ensVertices = cell(m, n);
    ensObjects = cell(m, n);
    
    for i = 1 : m
        for j = 1 : n
            member = ensemble(:, :, i);
            [mensLines, mensVertices, mensObjects] = isocontour(member, isovalues(j));
            
            ensLines{i, j} = mensLines;
            ensVertices{i, j} = mensVertices;
            ensObjects{i, j} = mensObjects;
        end
    end
end