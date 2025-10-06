/proc/get_dist_in_pixels(pixel_starts_x, pixel_starts_y, pixel_ends_x, pixel_ends_y)
	var/total_x = abs(pixel_starts_x-pixel_ends_x)
	var/total_y = abs(pixel_starts_y-pixel_ends_y)
	return round(sqrt(total_x*total_x + total_y*total_y))

/proc/get_angle_diff(angle_a, angle_b)
	return ((angle_b - angle_a) + 180) % 360 - 180;
