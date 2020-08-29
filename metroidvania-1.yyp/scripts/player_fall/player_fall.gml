function player_fall() {
	set_movement();
	set_gravity();

	// if (btn_A && v_speed_ < 1.8 && collide_x_ != 0) {
	//	alarm[4] = 6;
	//	state_ = player.wall_grab;
	//} else 

	if (v_speed_ <= 2.8) {
		if btn_A_pressed {
			v_speed_ = jump_height_;
			state_ = player.double_jump;
		}
	}

	if (btn_Y_pressed) {
		// set_grappling_hook();
	}
	
	if (v_speed_ == 0) {
		state_ = player.idle;
	}


}
