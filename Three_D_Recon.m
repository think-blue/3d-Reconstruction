function [real_coordinates, centers] = Three_D_Recon(matchpoints1, matchpoints2, camera1, camera2, image1, image2)

matches = [matchpoints1, matchpoints2]

real_coordinates = [];

% Using SVD to solve for AX = 0
for i = 1:length(matches)
A = compute_A_matrix( matches(i,1), matches(i,2), matches(i,3), matches(i,4), camera1, camera2);
[U, S, V] = svd(A);
real_coordinate = V(:,end);
real_coordinates = [real_coordinates, real_coordinate(1:3)/real_coordinate(4)];
end

% Using SVD on Camera Matrices to calculate centers
[u1, s1, v1] = svd(camera1);
center1 = v1(:,end);
center1 = center1(1:3)/center1(4);

[u2, s2, v2] = svd(camera2);
center2 = v2(:, end);
center2 = center2(1:3)/center2(4);

centers = [center1 center2];

% Plotting the final figure
figure
scatter3(real_coordinates(1,:), real_coordinates(2,:), real_coordinates(3, :));
axis equal
hold on
scatter3(center1(1), center1(2), center1(3));
hold on
scatter3(center2(1), center2(2), center2(3));

% plotting z distance as intensity values for x, y positions
b = real_coordinates;
b(1,:) = ceil(b(1, :) - min(b(1,:)) +1 );
b(2,:) = ceil(b(2, :) - min(b(2,:)) +1 );
b(3,:) = ceil(255 * (b(3, :) - min(b(3,:)) )/( max(b(3,:)) - min(b(3,:)) ));
a = zeros(max(b(1,:)), max(b(2,:)));
for i = 1:length(b)
    x = b(1,i);
    y = b(2,i);
    intensity = b(3, i);
    a(x,y) = 255 - intensity;
end
figure;
image(a)


