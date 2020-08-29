/// @description Move and collide
function player_run() {
	set_gravity();

	set_movement();

	// Fall
	if (v_speed_ > 0) { state_ = player.fall; }

	// Idle
	if (h_speed_ == 0) { state_ = player.idle; }

	// Jump / Fall
	if on_ground(o_dude, o_solid) && btn_A_pressed { 
		v_speed_ = jump_height_;
		state_ = player.jump; 
	}	

	// Attack
	if btn_X_pressed {
		state_ = player.attack;
	}

	// Dodge
	if btn_B_pressed {
		state_ = player.dodge;
	}


}
