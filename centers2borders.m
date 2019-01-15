function[borders] = centers2borders(centers)
% This function computes borders based on the
% centers, in a way that the border should be
% in the midpoint between the two centers
%
% centers must be a row vector

% TODO borders can be better calculated

sizes = diff(centers);
sizes = [mean(sizes) sizes mean(sizes)];
shift = sizes./2;
borders = [(centers(1) - shift(1)), (centers .+ shift(2:end))];
borders = round(borders);
