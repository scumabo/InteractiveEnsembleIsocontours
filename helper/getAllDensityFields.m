function allDensityField = getAllDensityFields(ensemble, isovalues, numHierarchyLvls)
m = numHierarchyLvls;
n = size(isovalues, 2);
allDensityField = cell(m, n);

for i = 1 : m
    for j = 1 : n
        allDensityField{i, j} = getDensityField(ensemble, isovalues(j), i);
    end
    fprintf(sprintf('===========Processing done for level %d \n', i));
end

end
