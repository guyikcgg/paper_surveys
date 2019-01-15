function[im] = load_image(image_name)


im = imread(image_name);
% Manually black and white
if (size(im,3) > 1)
	im = double(im);
	im = mean(im, 3);
	im = uint8(im);
end

% Custom image processing TODO should be elsewhere
im(im>128) = 255;
% im = im.*2;

% Invert colors
im = 255-im;
