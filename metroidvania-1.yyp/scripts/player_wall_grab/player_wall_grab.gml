function player_wall_grab() {
	if (btn_A) {
		h_speed_ = 0;
		v_speed_ = 0;
	}

	if (btn_A_released) {
		alarm[4] = 6;
		state_ = player.wall_launch;
	}



	


}
