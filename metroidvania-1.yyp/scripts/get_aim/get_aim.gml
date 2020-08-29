function get_aim() {

	aim_ = point_direction(0, 0, direction_, (move_down - move_up));

	if (instance_exists(o_dude)) {
		

		while !place_meeting(aim_x, aim_y, o_solid) && (aim_distance < max_aim_distance)  {	
			aim_x += direction_;
			aim_y += (move_down - move_up);
			aim_distance = point_distance(abs(base_aim_x), abs(base_aim_y), abs(aim_x), abs(aim_y));
			show_debug_message(string(aim_distance));
		}

		draw_set_color(c_red);
		draw_circle(aim_x, (aim_y - 10), 2, false);
	}

}
