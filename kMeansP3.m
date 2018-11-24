function [clusters, centroid_points] = kMeansP3 (data_points, K)

% check input data size
N_row = size(data_points, 1);
D_col = size(data_points, 2);

% clusters is used to store result
clusters = zeros(N_row, 1);

% centroids
centroid_points = zeros(K, D_col);
c_len = length(centroid_points);
% random first centroid from data points
rng(10);
for c = 1:c_len
    rand_idx = randi(length(data_points), 1);
    data_point = data_points(rand_idx, :);
    centroid_points(c, :) = data_point;
    fprintf("centriod %.0f = %s\n", rand_idx,  mat2str(data_point));
end

% temp centroid = random centroids
temp_mean = centroid_points;
is_first_epoch = 1;
is_converged = 0;
cnt_epoch = 0;

n_samples = N_row;

while (is_converged == 0)
    % skip finding new centroid for the first round because randomed
    % centroids are used.
    if(cnt_epoch > 0)
        % Reposition centroid by finding mean value
        new_centroid_points = [];
        for c = 1:c_len
            % find data points for each cluster
            idx = find(clusters==c);
            member = data_points(idx, :);
            new_centroid_points = [new_centroid_points; mean(member, 1)];
        end
        centroid_points = new_centroid_points;
    end
    
    
    cnt_epoch = cnt_epoch + 1;
    fprintf("=========== Epoch: "+ cnt_epoch +"================\n");
    
    % Loop through all samples
    for i = 1:n_samples
        
        % Set current distance as the lowest distance.
        current_dist = -1;
        % Flag for keeping target centroid.
        assign_to_centroid = -1;
        % Measure each data point with each centroid.
        for j = 1:c_len
            
            % Euclidean distance
            data_point = data_points(i,:);
            centroid = centroid_points(j, :);
            distance = pdist2(centroid, data_point, 'euclidean');
            
%             fprintf('d((%s), (%s)) = %.2f\n', ...
%                 mat2str(centroid), ...
%                 mat2str(data_point), distance);
            
            % If new distance is less than current distance,
            % set target cluster to the shortest distance.
            if or((current_dist == -1),(distance < current_dist))
                current_dist = distance;
                assign_to_centroid = j;
            end
        end
        % Store group from clustering result to array.
        clusters(i) = assign_to_centroid;
        % fprintf("Assign to cluster: %.0f\n", assign_to_centroid);
    end
    
    % Calculate next centroids from the mean of each group member
    next_centroid_points = [];
    for c = 1:c_len
        % find data points for each cluster
        idx = find(clusters==c);
        member = data_points(idx, :);
        next_centroid_points = [next_centroid_points; mean(member, 1)];
    end
    
    % Check if it converged for new centroid
    cnt_converged_centroid = 0;
    for chk_converged = 1:c_len
        if ismember(centroid_points(chk_converged),  next_centroid_points)
            cnt_converged_centroid = cnt_converged_centroid + 1;
        end
    end
    
    % If number of same centroids equal to number of cluster then it's
    % converged.
    if (cnt_converged_centroid == c_len)
        is_converged = 1;
    end
end
end