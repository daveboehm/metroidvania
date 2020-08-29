function player_jump() {
	set_movement();

	if v_speed_ <= 0 {
		set_gravity();
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
	
		if (btn_Y_pressed) {
			// set_grappling_hook();
		}
	
	} else {
		state_ = player.fall;
	}



}
