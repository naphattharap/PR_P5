function [] = plotReposition(centroid_points, centroid_colors, g1_members, ...
               g2_members, g3_members, member_colors, data_points, cnt_epoch)
            
% plot centroids
% plot members
figure;
axis equal;
hold on;
xlim([ min(data_points(:,1))-1  max(data_points(:,1))+1]);
ylim([ min(data_points(:,2))-1  max(data_points(:,2))+1]);
% plot centroids
   
% group 1
g1_len = length(g1_members);
% g1_x = reshape(g1_members(:,1),1,g1_len);
% g1_y = reshape(g1_members(:,2),1,g1_len);
scatter(g1_members(:,1), g1_members(:,2), ...
            'filled', ...
            'Marker', 'o',...
            'MarkerFaceColor', member_colors(1,:));

scatter(g2_members(:,1), g2_members(:,2), ...
            'filled', ...
            'Marker', 'o',...
            'MarkerFaceColor', member_colors(2,:)); 
        
scatter(g3_members(:,1), g3_members(:,2), ...
            'filled', ...
            'Marker', 'o',...
            'MarkerFaceColor', member_colors(3,:)); 

c_len = length(centroid_points);
for b = 1:c_len
    cx = centroid_points(b,1);
    cy = centroid_points(b,2);
    scatter(cx, cy, ...
            'filled', ...
            'Marker', 's',...
            'MarkerFaceColor', centroid_colors(b,:));
end
title("centroids = "+ mat2str(centroid_points));
%legend;
hold off;

end

