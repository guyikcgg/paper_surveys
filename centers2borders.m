function[borders] = centers2borders(centers)
% This function computes borders based on the
% centers, in a way that the border should be
% in the midpoint between the two centers
%
% centers must be a row vector

% TODO borders can be better calculated

size_0 = median(diff(centers))/2;
borders = zeros(1, length(centers)+1);
borders(1) = centers(1)-size_0;
for i=2:length(centers)
	borders(i) = mean(centers(i-1:i));
end
borders(end) = centers(end)+size_0;
% sizes = [mean(sizes) sizes mean(sizes)];
% shift = sizes./2;
% borders = [(centers(1) - shift(1)), (centers .+ shift(2:end))];
borders = round(borders);
