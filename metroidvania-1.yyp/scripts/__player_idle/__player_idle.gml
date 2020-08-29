function player_idle() {
	// Idle State
	set_gravity();
	set_movement();
	get_aim();

	// Run
	if h_speed_ != 0 { 
		state_ = player.run;
	}

	// Jump
	if on_ground(o_dude, solid_) && btn_A_pressed {
		v_speed_ = jump_height_;
		state_ = player.jump;
	}

	// Attack
	if btn_X_pressed {
		//state_ = player.shoot;	
		state_ = player.attack;	
	}

	// Dodge
	if btn_B_pressed {
		state_ = player.dodge;
	}
	// Shoot



	// Climb

	// Interact

	// Take Damage



	if (btn_Y_pressed) {
		// set_grappling_hook();
	}


}
