function[im] = load_image(image_name)


im = imread(image_name);
% Manually black and white
if (size(im,3) > 1)
	im = double(im);
	% im = im(:,:,1)*0.25 + im(:,:,2)*0.25 + im(:,:,3)*0.5;
	% im = mean(im, 3);
	% im = im(:,:,1);
	im = im(:,:,1)*2-im(:,:,3)*1;
	% im = uint8(im);
end

% Custom image processing TODO should be elsewhere
b = 127;
a = 110;
m = 1.5;
c = b-m*a;
im = m*im+c;
% im = im*1.5;
im = uint8(im);
% im(im>180) = 255;
% im(im<80) = 0;
% im = im.*1.2;

% Invert colors
im = 255-im;
