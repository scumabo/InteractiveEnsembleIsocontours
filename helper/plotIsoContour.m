function h = plotIsoContour(mObjects, mVertices, color, lw)
for j=1:length(mObjects)
    mPoints=mObjects{j};
    x = mVertices(mPoints, 2);
    y = mVertices(mPoints, 1);
    hold on
    h = m_plot(x, y, 'Color', color, 'LineWidth', lw);
end
end