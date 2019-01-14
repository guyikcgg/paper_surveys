
image_name = "test1.png"

% Manually black and white
im = imread(image_name);
imshow(im)
if (size(im,3) > 1)
	im = double(im);
	im = mean(im, 3);
	im = uint8(im);
end

%TODO rotate and center

% TODO convert to blackscale and apply threshold to eliminate shadowed areas
x_centers = [300 358 419 478];

x_sizes = diff(x_centers);
x_sizes = [mean(x_sizes) x_sizes mean(x_sizes)];
x_shift = x_sizes./2;
x_borders = [(x_centers(1) - x_shift(1)), (x_centers .+ x_shift(2:end))];
x_borders = round(x_borders);
% TODO x_borders can be better calculated

im(:,x_borders) = 100;
imshow(im);
