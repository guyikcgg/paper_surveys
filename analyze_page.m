function[answer_num] = analyze_page(image_answer_name, page_number)

th = 1.6;

% Get information for this page number
[x_centers, y_centers] = get_centers(page_number);

n = length(x_centers);
m = length(y_centers);

x_borders = centers2borders(x_centers);
y_borders = centers2borders(y_centers);

% Read image with answers
im_ans = load_image(image_answer_name);
% TODO rotate and center

% Debug: check the position of the borders
im2 = im_ans;
im2(:,x_borders) = 100;
im2(y_borders,:) = 100;
imshow(im2);
% pause()

% Get weight of every region in answer
weights_ans = zeros(m,n);
for i=1:n
	for j=1:m
		weights_ans(j,i) = sum(sum(im_ans(y_borders(j):y_borders(j+1),x_borders(i):x_borders(i+1))));
	end
end

% Alternative computation of weights (using columns)
weights = median(weights_ans, 1);

% Get relative weights
% weights = ones(size(weights_ans,1), 1) * weights;
% weights_rel = weights_ans ./ weights
for j=1:m
	% The sqrt formula comes from normalizing by row and column
	weights_rel(j,:) = weights_ans(j,:)./sqrt(weights*median(weights_ans(j,:)));
end
round(weights_rel*100)

% Analyze answers
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
		[a, b] = max(weights_rel(j,:));
		weights_rel(j,b) = 0;
		[a, b] = max(weights_rel(j,:));
		answer_num(j) = b;

		printf('WARNING: multiple answers detected in file "%s" (row %d). I think the correct answer is: %d\n', image_answer_name, j, b);
	else
		printf('WARNING: unknown answer in file "%s" (row %d)\n', image_answer_name, j);
	end
end

