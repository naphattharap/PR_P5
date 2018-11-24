%======================================
%========== PRACTICE 4. ===============
%======================================

% Load image
% 256x256x3
img = imread("image.jpg");
%imshow(img);
% Reshape to N x 3 dimension
features = reshape(img, [256*256, 3]);

% Solve error from passing integer to kmeans
d_features = double(features);

k_clusters = [2, 5, 10, 50, 100];
k_len = length(k_clusters);
for k = 1:k_len
    % [clusters, centroid_points] = kMeansP3(m,10);
    [clusters, centroids] = kmeans(d_features, k_clusters(k), 'MaxIter',1000);
    
    % Create new image from RGB obtained in cluster
    new_image = zeros(256*256, 3);
    c_len = length(centroids);
    for c = 1:c_len
        % find data points for each cluster
        idx_cluster = find(clusters==c);
        for idx_c = 1:length(idx_cluster)
            new_image(idx_cluster(idx_c), :, :) = centroids(c, :);
        end
    end
    %imshow(new_image)
    new_image = reshape(new_image, [256, 256, 3]);
    figure;
    imshow(uint8(new_image))
end

