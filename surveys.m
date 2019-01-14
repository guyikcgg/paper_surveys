
image_name = 'test1.png'
image_answer_name = 'test1_ans.png'
th = 1.8;

% Manually black and white
im = imread(image_name);
imshow(im)
if (size(im,3) > 1)
	im = double(im);
	im = mean(im, 3);
	im = uint8(im);
end

% Black to white
im = 255-im;

%TODO rotate and center

% TODO convert to blackscale and apply threshold to eliminate shadowed areas
x_centers = [300 358 419 478];

n = length(x_centers);

x_sizes = diff(x_centers);
x_sizes = [mean(x_sizes) x_sizes mean(x_sizes)];
x_shift = x_sizes./2;
x_borders = [(x_centers(1) - x_shift(1)), (x_centers .+ x_shift(2:end))];
x_borders = round(x_borders);
% TODO x_borders can be better calculated

im2 = im;
im2(:,x_borders) = 100;
imshow(im2);

% Get usual weight of every region
weights = zeros(1,n);
for i=1:n
	weights(1,i) = sum(sum(im(:,x_borders(i):x_borders(i+1))));
end






% Read answers
im_ans = imread(image_answer_name);

% Manually black and white
imshow(im_ans)
if (size(im_ans,3) > 1)
	im_ans = double(im_ans);
	im_ans = mean(im_ans, 3);
	im_ans = uint8(im_ans);
end

% Black to white
im_ans = 255-im_ans;


% Get weight of every region in answer
weights_ans = zeros(1,n);
for i=1:n
	weights_ans(1,i) = sum(sum(im_ans(:,x_borders(i):x_borders(i+1))));
end

weights_rel = weights_ans ./ weights;
answer = weights_rel>th;
if (sum(answer) != 1)
	printf('WARNING: unknown result for survey: %s', image_answer_name);
	answer_num = 0;
else
	[a, answer_num] = max(answer);
end

dlmwrite([image_answer_name '.csv'], answer_num, ',');


