function[answer_num] = analyze_page(image_answer_name, page_number, image_ref_name, downscale)

if (nargin>3)
	d = downscale;
else
	d = 1;
end
if (nargin>2)
	im_ref = load_image(image_ref_name, d);
end

th = 1.8;

% Get information for this page number
[x_centers, y_centers] = get_centers(page_number, d);

n = length(x_centers);
m = length(y_centers);

x_borders = centers2borders(x_centers);
y_borders = centers2borders(y_centers);

% Read image with answers
im_ans = load_image(image_answer_name, d);

% TODO rotate?

% Center the image to match the reference
if (nargin>2)
	im_ref(im_ref<100)=0;
	im_ans(im_ans<100)=0;
	% imshow(uint8(im_ref2/max(max(im_ref2))));
	% Debug
	% figure(1); imshow(im_ref2);
	% figure(2); imshow(im_ans2);
	[dx, dy, im_ans] = get_displacement(im_ref, im_ans);
	% Alternative to changing im_ans
	% x_borders = round(x_borders/3 + dx);
	% y_borders = round(y_borders/3 + dy);

	% im_ans = im_ans - im_ref;

	% Debug
	dx, dy
	% figure(2); imshow(im_ans2);
end

% Debug: check the position of the borders
im2 = im_ans;
im2(:,x_borders) = 100;
im2(y_borders,:) = 100;
figure(3);
imshow(im2);
% pause()

% Get weight of every region in answer
weights_ans = zeros(m,n);
for i=1:n
	for j=1:m
		weights_ans(j,i) = sum(sum(im_ans(y_borders(j):y_borders(j+1),x_borders(i):x_borders(i+1))));
		if (nargin>2)
			weights_ref(j,i) = sum(sum(im_ref(y_borders(j):y_borders(j+1),x_borders(i):x_borders(i+1))));
		else
			weights_ref(j,i) = weights_ans(j,i);
		end
	end
end

% Alternative computation of weights (using columns)
weights = median(weights_ref, 1);

% Get relative weights
% weights = ones(size(weights_ans,1), 1) * weights;
% weights_rel = weights_ans ./ weights
for j=1:m
	% The sqrt formula comes from normalizing by row and column
	weights_rel(j,:) = weights_ans(j,:)./sqrt(weights*median(weights_ref(j,:)));
	if (nargin>2)
		weights_rel(j,:) = weights_ans(j,:)./weights;
	end

end

% Debug
% round(weights_rel*100)

% Analyze answers
answer = weights_rel>th;
answer_num = zeros(1,m);
results = zeros(m,2);
for j=1:m
	[a, b] = max(weights_rel(j,:));
	results(j,:) = [a b];
	% if (sum(answer(j,:)) == 1)
	% 	%TODO this could be improved (if answers were not from 1 to whatever)
	% 	[a, b] = max(answer(j,:));
	% 	answer_num(j) = b;
	% elseif (sum(answer(j,:)) == 0)
	% 	printf('WARNING: no answer detected in file "%s" (row %d)\n', image_answer_name, j);
	% elseif (sum(answer(j,:)) == 2)
	% 	[a, b] = max(weights_rel(j,:));
	% 	weights_rel(j,b) = 0;
	% 	[a, b] = max(weights_rel(j,:));
	% 	answer_num(j) = b;
    %
	% 	printf('WARNING: multiple answers detected in file "%s" (row %d). I think the correct answer is: %d\n', image_answer_name, j, b);
	% else
	% 	printf('WARNING: unknown answer in file "%s" (row %d)\n', image_answer_name, j);
	% end
end

ink = results(:,1);
iq = quantile(ink(:),.75)-quantile(ink(:),.25);
for j=1:m
	if (results(j,1) < th)
		printf('WARNING: no answer detected in file "%s" (row %d)\n', image_answer_name, j);
		results(j,2) = 0;
	elseif (abs(results(j,1)-mean(ink)) > 1.5*iq)
		[a,b] = min(abs(mean(ink)-weights_rel(j,:)));
		if (b != results(j,2))
			results(j,2) = b;
			printf('WARNING: multiple answers detected in file "%s" (row %d). I think the correct answer is: %d\n', image_answer_name, j, b);
		else
			printf('WARNING: outlier in file "%s" (row %d). The selected answer is: %d\n', image_answer_name, j, b);
		end
	end
end

answer_num = results(:,2)';
