function[x, y] = get_centers(page, downscale)

x = [999 1062 1122 1180 1242 1306 1368];

switch(page)
case(1)
	y = [862 952 1003 1087 1171 1299 1386 1470 1549 1602 1690 1752 1833 1915 1999];
case(2)
	y = [258 430 510 638 688 852 940 1060 1124 1206 1250 1336 1468 1548 1602 1686 1732 1816 1902 2028];
case(3)
	x = [999 1062 1122 1180 1242 1306 1368] - (999-1006);
	y = [266 350 555 644 682 782 864 950 1032 1120 1200 1250 1418 1500 1586 1638 1720 1810 1888 1976] - (266-255);
otherwise
	error('ERROR: no information available for page %d', page);
end

if (nargin>1)
	x = round(x/downscale);
	y = round(y/downscale);
end

%debug
% diff(y)
