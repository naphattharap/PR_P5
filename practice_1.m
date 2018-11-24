%======================================
%========== PRACTICE 1. ===============
%======================================

data = load('data.mat');
data_points = data.X;
% Plot data points before clustering.
scatter(data_points(:,1), data_points(:,2), 'filled'); 

% Run different cluster
K_cluster = [2,4,5,10,20];
len_k = length(K_cluster);
for k = 1:len_k
    [clusters, centroids] = kMeansP3(data_points, K_cluster(k));
    fprintf("%s", mat2str(clusters));
    fprintf("%s", mat2str(centroids));

    % Loop through all clusters which is the same number as centroids.
    len_centroid = length(centroids);

    groups = unique(clusters);
    figure;
    gscatter(data_points(:,1), data_points(:,2), clusters); 
end

% Testing seed for random range.
K_cluster = [5, 5, 5];
len_k = length(K_cluster);
for k = 1:len_k
    [clusters, centroids] = kMeansP3(data_points, K_cluster(k));
    fprintf("%s", mat2str(clusters));
    fprintf("%s", mat2str(centroids));

    % Loop through all clusters which is the same number as centroids.
    len_centroid = length(centroids);

    groups = unique(clusters);
    figure;
    gscatter(data_points(:,1), data_points(:,2), clusters); 
end

