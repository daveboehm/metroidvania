/// @description Attack 2
function player_uppercut() {

	set_gravity();
	set_movement();

	if _is_frame(1) {
		// create attack_collision here
		// play sound here
	}

	// Attack Combo
	if _is_frame_window(2, image_number - 2) {
		if (btn_X_pressed) {
			state_ = player.slam;	
		}
	}

	// Return to non-attack state
	if _is_frame(image_number - 1) {
		state_ = player.fall;
		// Fall
		// if (v_speed_ > 0) { state_ = player.fall; }

		// Idle
		//if (h_speed_ == 0) { state_ = player.idle; }
	
		//if (h_speed_ != 0) { state_ = player.run; }

		// Jump / Fall
		if on_ground(o_dude, solid_) && btn_A_pressed { 
			//v_speed_ = jump_height_;
			//state_ = player.jump; 
		}	
	}



}
