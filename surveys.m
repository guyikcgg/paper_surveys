
image_name = 'test1.png'
image_answer_name = 'test2_ans.png'
th = 1.8;

im = load_image(image_name);

%TODO rotate and center

x_centers = [300 358 419 478];
y_centers = [224 260];

n = length(x_centers);
m = length(y_centers);

x_borders = centers2borders(x_centers);
y_borders = centers2borders(y_centers);

% Debug: check the position of the borders
im2 = im;
im2(:,x_borders) = 100;
im2(y_borders,:) = 100;
imshow(im2);

% Get usual weight of every region
% TODO this might not be possible (though it should)
weights = zeros(m,n);
for i=1:n
	for j=1:m
		weights(m,i) = sum(sum(im(y_borders(j):y_borders(j+1),x_borders(i):x_borders(i+1))));
	end
end






% Read answers
im_ans = load_image(image_answer_name);

% Debug: check the position of the borders
im2 = im_ans;
im2(:,x_borders) = 100;
im2(y_borders,:) = 100;
imshow(im2);

% Get weight of every region in answer
weights_ans = zeros(m,n);
for i=1:n
	for j=1:m
		weights_ans(j,i) = sum(sum(im_ans(y_borders(j):y_borders(j+1),x_borders(i):x_borders(i+1))));
	end
end

% Alternative computation of weights
weights = median(weights_ans);

% Get relative weights
weights_rel = weights_ans ./ weights;
answer = weights_rel>th
% if (sum(answer) != 1)
% 	printf('WARNING: unknown result for survey: %s', image_answer_name);
% 	answer_num = 0;
% else
% 	[a, answer_num] = max(answer);
% end

% dlmwrite([image_answer_name '.csv'], answer_num, ',');


