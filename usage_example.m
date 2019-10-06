camera1 = load('library1_camera.txt');
camera2 = load('library2_camera.txt');

matches = load('library_matches.txt');
image1 = imread('library1.jpg');
image2 = imread('library2.jpg');
[three_d_points, centers] = Three_D_Recon(matches(:,1:2), matches(:,3:4), camera1, camera2, image1, image2);
