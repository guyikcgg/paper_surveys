function[im] = load_image(image_name, downscale)


im = imread(image_name);
% Custom image processing TODO should be elsewhere

% Manually black and white (with some processing)
if (size(im,3) > 1)
	im = double(im);

	R = im(:,:,1);
	G = im(:,:,2);
	B = im(:,:,3);

	% Darkest colors are not that relevant
	% im(im<50) = 60;
	R(R<50) = 60;

	% mean of RGB channels
	% im = mean(im, 3);

	% just red channel
	% im = R;

	% R-B (since normally blue pens are used)
	im = 2*R-B;

end

% Downsample
if (nargin>1)
	im = downsample(im, downscale);
	im = downsample(im', downscale)';
end
imshow(im/max(max(im)))

% Bright blue might be darkest than black
% im = im-min(min(im));

% Increment the bright, saturation is good
a = 120;
b = 127;
m = 1.6;
c = b-m*a;
im = m*im+c;

% Back to image format
im = uint8(im);

% Invert colors
im = 255-im;
