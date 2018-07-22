function ensInterpolated = InterpolateZ(ensReordered, numInterpFrame)
[I1, I2, I3] = size(ensReordered);

tic
disp(sprintf('===========Starting interpolation, numFrames = %d', numInterpFrame));
ensInterpolated = imresize3d(ensReordered, [], [I1, I2, I3 + (I3 - 1) * numInterpFrame], 'linear', 'replicate');
toc

end