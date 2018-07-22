function plotBoxPlot(allDensityField)
    numCols = size(allDensityField, 1);
    numRows = size(allDensityField{1}, 1) * size(allDensityField{1}, 2);
    data = zeros(numRows, numCols);
    for i = 1 : numCols
        data(:, i) = allDensityField{i}(:)';
    end
    data = data / 11;
    data(data == 0) = NaN;
    boxplot(data);
end