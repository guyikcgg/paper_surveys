function[x, y] = get_centers(page)

x = [999 1062 1122 1180 1242 1306 1368];

switch(page)
case(1)
	y = [862 952 1003 1087 1171 1299 1386 1470 1549 1602 1690 1752 1833 1915 1999];
otherwise
	error('ERROR: no information available for page %d', page);
end
