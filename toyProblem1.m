data_points = [2 10; 2 5; 8 4; 5 8; 7 5; 6 4; 1 2; 4 9];
n_samples =  size(data_points,1);
x = reshape(data_points(:,1),1,n_samples);
y = reshape(data_points(:,2),1,n_samples);

% Visualize data
hold on;
xlim([min(x)-1 max(x)+1])
ylim([min(y)-1 max(y)+1])

% Visualize data before clustering
scatter(x, y, 'filled', 'DisplayName', 'data point', ...
    'Marker', 'o',...
    'MarkerFaceColor',[0.4 0.4 0.4]);
xlim([min(x)-1 max(x)+1])
ylim([min(y)-1 max(y)+1])
title("Data points");
legend;
hold off;

% Plot unknow group and intial centroid
%Suppose that the initial seeds (centers of each cluster) are A1, A4 and A7.
centroid1 = [2 10]; % A1
centroid2 = [5 8]; %A4
centroid3 = [1 2]; %A7
centroid_points = [centroid1; centroid2; centroid3];
% Color of centroid and members
color_group1 = [0.8500 0.3250 0.0980];
color_group2 = [0.4660 0.6740 0.188];
color_group3 = [0 0.4470 0.7410];
non_group = [0.4 0.4 0.4];
member_colors = [color_group1; color_group2; color_group3];

cen1 = [1 0 0];
cen2 = [0 1 0];
cen3 = [0.3010, 0.7450, 0.9330];
centroid_colors = [cen1; cen2; cen3];


% ============= Plot initial centroids ============
figure;
axis equal;
hold on;
xlim([ min(data_points(:,1))-1  max(data_points(:,1))+1]);
ylim([ min(data_points(:,2))-1  max(data_points(:,2))+1]);
% plot unknown group member
scatter(x, y, ...
    'filled', ...
    'Marker', 'o',...
    'MarkerFaceColor', point_color);
% plot centroid
c_len = length(centroid_points);
for b = 1:c_len
    cx = centroid_points(b,1);
    cy = centroid_points(b,2);
    scatter(cx, cy, ...
        'filled', ...
        'Marker', 's',...
        'MarkerFaceColor', centroid_colors(b,:));
end


title("Initial centroids");
%legend;
hold off;


%The centers of the new clusters.


% Use the k-means algorithm and Euclidean distance to cluster
%the following 8 examples into 3 clusters:
% A1=(2,10), A2=(2,5), A3=(8,4), A4=(5,8),
% A5=(7,5), A6=(6,4), A7=(1,2), A8=(4,9).
% The distance matrix based on the Euclidean distance is given below:

clusters = zeros(1, n_samples);
k = length(centroid_idx);
cnt_epoch = 0;
is_converged = 0;

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
            
             fprintf('d((%s), (%s)) = %.2f\n', ...
                 mat2str(centroid), ...
                 mat2str(data_point), distance);
            
            % If new distance is less than current distance,
            % set target cluster to the shortest distance.
            if or((current_dist == -1),(distance < current_dist))
                current_dist = distance;
                assign_to_centroid = j;
            end
        end
        % Store group from clustering result to array.
        clusters(i) = assign_to_centroid;
        fprintf("Assign to cluster: %.0f\n", assign_to_centroid);
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
    
    plotReposition(centroid_points, centroid_colors,... 
                data_points(find(clusters==1), :), ...
                data_points(find(clusters==2), :), ...
                data_points(find(clusters==3), :), ...
                member_colors, data_points, cnt_epoch);
    
end

