function [] = plotDataPoints(data_points, cluster, centroid_idx,centroid_color, member_color, cnt_epoch)
figure;
axis equal;
hold on;
n_samples =  size(data_points,1);
xlim([ min(data_points(:,1))-1  max(data_points(:,1))+1]);
ylim([ min(data_points(:,2))-1  max(data_points(:,2))+1]);
% for each data points in samples
for d = 1:n_samples
    % if it is centroid, get color from centroid color other get color from
    % member
    if ismember(d, centroid_idx)
        % get centroid's color index from array.
        point_color = centroid_color(find(centroid_idx==d), :);
        marker = 's';
    else
        point_color = member_color(find(centroid_idx==cluster(d)), :);
        marker = 'o';
    end
    scatter(data_points(d, 1), data_points(d, 2), ...
        'filled', ...
        'Marker', marker,...
        'MarkerFaceColor', point_color);
    
end
% title("K-mean at epoch = "+cnt_epoch);
%legend;

hold off;

end

