function Order = simple(HDMap)
    m = size(HDMap, 1);
    [B,I] = sort(HDMap(m, :),'ascend');
    Order = I(2:end);
end