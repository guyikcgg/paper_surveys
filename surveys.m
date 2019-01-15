
image_name = ''
image_answer_name = 'scan/SKM_C224e19011518080_0001.jpg'
th = 1.8;

[x_centers, y_centers] = get_centers(1);

n = length(x_centers);
m = length(y_centers);

x_borders = centers2borders(x_centers);
y_borders = centers2borders(y_centers);

if (length(image_name))
	im = load_image(image_name);
	%TODO rotate and center

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
end






% Read answers
im_ans = load_image(image_answer_name);
% TODO rotate and center

% Debug: check the position of the borders
% im2 = im_ans;
% im2(:,x_borders) = 100;
% im2(y_borders,:) = 100;
% imshow(im2);

% Get weight of every region in answer
weights_ans = zeros(m,n);
for i=1:n
	for j=1:m
		weights_ans(j,i) = sum(sum(im_ans(y_borders(j):y_borders(j+1),x_borders(i):x_borders(i+1))));
	end
end

% Alternative computation of weights
if (length(image_name) == 0)
	weights = median(weights_ans);
end

% Get relative weights
weights = ones(size(weights_ans,1), 1) * weights;
weights_rel = weights_ans ./ theones;
return
answer = weights_rel>th;
answer_num = zeros(1,m);
for j=1:m
	if (sum(answer(j,:)) == 1)
		%TODO this could be improved (if answers were not from 1 to whatever)
		[a, b] = max(answer(j,:));
		answer_num(j) = b;
	elseif (sum(answer(j,:)) == 0)
		printf('WARNING: no answer detected in file "%s" (row %d)\n', image_answer_name, j);
	elseif (sum(answer(j,:)) == 2)
		[a, b] = max(answer(j,:));
		answer(j,b) = 0;
		[a, b] = max(answer(j,:));
		answer_num(j) = b;

		printf('WARNING: multiple answers detected in file "%s" (row %d). I think the correct answer is: %d\n', image_answer_name, j, b);
	else
		printf('WARNING: unknown answer in file "%s" (row %d)\n', image_answer_name, j);
	end
end

dlmwrite([image_answer_name '.csv'], answer_num, ',');


