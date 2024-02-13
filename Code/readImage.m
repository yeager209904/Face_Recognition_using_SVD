function img = readImage(img_path)

img = imread(img_path);
img = imresize(img, 0.5);   
if size(img,3)==3
img=rgb2gray(img);
end
img=double(img);
