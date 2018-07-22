function OrderMST = getOrder(HDMap, pred)
    n = size(HDMap, 1);
    visited = false(1, n - 1);
    dist = inf(1, n - 1);
    
    popped = n;
    OrderMST = zeros(1, n - 1);
    i = 1;
    while (i <= n - 1)
        indices = find(pred == popped);
        dist(indices) = min(dist(indices), HDMap(indices, popped)');
        candidates = find(visited == false);
        [mini, minIndex] = min(dist(candidates));
        OrderMST(i) = candidates(minIndex);
        popped = candidates(minIndex);
        visited(candidates(minIndex)) = true;
        i = i + 1;
    end
end