function player_double_jump() {
	set_movement();
	set_gravity();

	if v_speed_ <= 0 {
	
		//if (collide_x_ != 0 && btn_A) {
		//	alarm[4] = 6;
		//	state_ = player.wall_grab;
		//}
		if btn_A_pressed {
			v_speed_ = jump_height_;
		}
		if btn_A_released {
			v_speed_ = 0;
		}
	}

	if (btn_Y_pressed) {
		// set_grappling_hook();
	}

	if (_is_frame(image_number - 1)) || place_meeting(x, y + abs(jump_height_), o_solid) {
		state_ = player.fall;
	}
	
	if (place_meeting(x, y+1, o_solid)) {
		state_ = player.idle;
	}



}
