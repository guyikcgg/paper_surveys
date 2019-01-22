function[dx, dy, B] = get_displacement(A, B)
% What happened to A to get B?

% For the correlation we don't need the whole page
[m,n] = size(A);
m2 = round(m/3);
n2 = round(n/3);
m3 = round(m/3*2);
n3 = round(n/3*2);
A2 = A(1:m2,n2:n3);
B2 = B(1:m2,n2:n3);

C = xcorr2(A2,B2);
[c1,d1]=max(max(C,[],2));
[c2,d2]=max(max(C,[],1));

dx=(size(C,2)+1)/2-d2;
dy=(size(C,1)+1)/2-d1;


% Debug
if (dx>0)
	d = round(dx);
	B = [B(:, d+1:end) fliplr(B(:, 1:d))];
elseif (dx<0)
	d = -round(dx);
	B = [fliplr(B(:, end-d+1:end)) B(:, 1:end-d)];
end

if (dy>0)
	d = round(dy);
	B = [B(d+1:end, :); flipud(B(1:d, :))];
elseif (dy<0)
	d = -round(dy);
	B = [flipud(B(end-d+1:end, :)); B(1:end-d, :)];
end
