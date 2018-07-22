function [HDMap] = computeHD(Vertices, meanVertices)
    
    n = size(Vertices, 1);
    Vertices{n + 1, 1} = meanVertices;
    n = n + 1;
    
    HDMap = zeros(n);
    for i = 1 : n - 1
        for j = i + 1 : n;
            HDMap(i, j) = HausdorffDist(Vertices{i}, Vertices{j});
%             HDMap(i, j) = HausdorffDist(Vertices{i}, Vertices{j},[],'visualize');
        end
    end
    HDMap = max(HDMap, HDMap');
end