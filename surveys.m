
images = ls('scan/*.jpg');

for i=1:size(images,1)
	A{i} = analyze_page(images(i,:),rem(i,10));
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


