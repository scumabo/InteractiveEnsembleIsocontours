function [Octree_vectors, minValue, maxValue, step] = gen_similarity_iso_vector( ensembleData, cell_size )
% Author: Bo Ma    Last modified: 2/13/2017
% Generate Isosurface similarity vector for ensemble from multiple scales

minValue = min(ensembleData(:));
maxValue = max(ensembleData(:));

% minValue = 223;
% maxValue = 308;

% 256 bin for any isovalue range
step = (maxValue - minValue + 1) / 256;

Octree_vectors = {};         % Store similarity vector from multiple scales


num_iso = max(ensembleData(:));   % size of the similarity table
[I1, I2, numMember] = size(ensembleData);           % number of voxels along each direction of image
num_cells = (I1-1)*(I2-1);
 

%% Min and Max for each cell (2D ensemble case)
intensity_min = Inf(I1-1, I2-1, numMember);   %  Min cell ensembleData (n-1 * n-1)
intensity_max = -Inf(I1-1, I2-1, numMember);  %  Max cell ensembleData (n-1 * n-1)

% Compute min and max volume for all members.
for i = 1:numMember
    vertex_idx = {1:I1-1, 1:I2-1, i; ...
        2:I1, 1:I2-1, i; ...
        2:I1, 2:I2, i; ...
        1:I1-1, 2:I2, i};
    
    for ii=1:4                            % loop thru vertices of all cells
        intensity_min(:,:,i) = min(ensembleData(vertex_idx{ii, :}), intensity_min(:,:,i));
        intensity_max(:,:,i) = max(ensembleData(vertex_idx{ii, :}), intensity_max(:,:,i));
    end
end
%% Produce similarity table for each scale
% while cell_size(1) ~= 1 && cell_size(2) ~= 1 && cell_size(3) ~= 1
%     % single cell indices of hyper cells
%     hyper_cell_index = {1:cell_size(1):I1-1, 1:cell_size(2):I2-1 };
%     [X,Y] = meshgrid(hyper_cell_index{1, :});
%     ind_start = [X(:) Y(:)];
%     ind_end = [min(I1, X(:)+cell_size(1)) min(I2, Y(:)+cell_size(2))]-1;
%     
%     n_hyper_cell = size(ind_start, 1);                  % number of hyper cells
%     hyper_min = zeros(1, n_hyper_cell);        % Min hyper cell ensembleData
%     hyper_max = zeros(1, n_hyper_cell);        % Max hyper cell ensembleData
%     
%     % loop though all the hyper cells and construct Min/Max hyper cell ensembleData
%     for i = 1:n_hyper_cell
%         min_processing_hyper_cell = intensity_min(ind_start(i, 1):ind_end(i,1), ind_start(i, 2):ind_end(i,2));
%         max_processing_hyper_cell = intensity_max(ind_start(i, 1):ind_end(i,1), ind_start(i, 2):ind_end(i,2));
%         
%         hyper_min(i) = min(min_processing_hyper_cell(:));
%         hyper_max(i) = max(max_processing_hyper_cell(:));
%     end
% 
%     
%     F_hyper = zeros(n_hyper_cell, num_iso-1, 'single');
%     for i = 1:num_iso-1
%         overlap_index = find(hyper_min < i & hyper_max > i);
%         F_hyper(overlap_index,i) = 1; %#ok<*FNDSB>
%         %    F(intensity_min < i & intensity_max > i, i) = 1;
%     end
%     
%     
%     overlap_table = F_hyper'*F_hyper;
%     isosurface_ocupy_numCell = sum(F_hyper, 1);
%     clear F_hyper;
%     
%     hyper_similarity_table = bsxfun(@rdivide,overlap_table, isosurface_ocupy_numCell);
%     
%     
%     % store the table in the Octree
%     Octree_vectors = [Octree_vectors; {hyper_similarity_table}];
%     cell_size = max(ceil((cell_size)/2), 1);
% end


F = zeros(num_cells, numMember);
for i = minValue:step:maxValue
    for mem = 1:numMember
        overlap_index = find(intensity_min(:,:, mem) < i & intensity_max(:,:, mem) > i);
        F(overlap_index, mem) = 1; %#ok<*FNDSB>
    end
    overlap_table = F'*F;
    isosurface_ocupy_numCell = sum(F, 1);
    clear F;
    
    % Similarity table for isovalue i for all members
    similarity_table = bsxfun(@rdivide,overlap_table, isosurface_ocupy_numCell);
    similarity_table = min(similarity_table, similarity_table');
    
    varVector = triu(similarity_table, 1);
    sparsity_pattern = ~logical(tril(similarity_table));
    Octree_vectors = [Octree_vectors; {varVector(sparsity_pattern)}];
end

