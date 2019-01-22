
% Custom variables
n_images = 30;
n_ref    = 10;
dst = 'csv';
downscale = 3;

images_ans = {};
images_ref = {};
for i=1:n_ref
	images_ans{i} = sprintf('scan/SKM_C224e19011518080_%04d.jpg', i);
end
for i=1:n_images
	images_ans{i} = sprintf('scan/SKM_C224e19011518080_%04d.jpg', i);
	images_ref{i} = sprintf('scan/reference/SKM_C224e19011619371_%04d.jpg', i);
end

filename = 'survey_';
% answers_survey = [filename];
answers_survey = [];
for i=0:n_images-1
	% if (rem(i,n_ref)+1>3)
	% 	continue;
	% end

	page = rem(i, n_ref)+1; % TODO this 1 is the starting point
	answers_page = analyze_page(images_ans{i+1}, page, images_ref{page}, downscale);
	% answers_page = [1 2 3];
	answers_survey = [answers_survey answers_page];

	if (rem(i,n_ref)+1 == n_ref)
		filename = ['survey_' num2str((i+1)/n_ref)];
		fid = fopen([dst '/' filename '.csv'], 'w');
		fprintf(fid, '%s,', filename);
		fclose(fid);
		dlmwrite([dst '/' filename '.csv'], answers_survey, '-append');
		% answers_survey = [filename];
		answers_survey = [];
	end
end


return

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







dlmwrite([image_answer_name '.csv'], answer_num, ',');


