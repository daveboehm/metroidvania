function player_grapple() {
	exit;
	set_gravity();
	//set_movement();

	rope_angle_ = point_direction(rope_end_x_, rope_end_y_, rope_start_x_, rope_start_y_);
	rope_length_ = point_distance(rope_end_x_, rope_end_y_, rope_start_x_, rope_start_y_);

	show_message(string(rope_angle_));
	show_message(string(rope_length_));
	
	var _swing_speed = rope_length_ * .015;
	_swing_speed = clamp(_swing_speed, .5, .75);

	var _rope_angle_acceleration = -_swing_speed * dcos(rope_angle_);

	_rope_angle_acceleration += direction_ * 0.1;

	rope_angle_velocity_ += _rope_angle_acceleration;
	rope_angle_ += rope_angle_velocity_ ;
	rope_angle_velocity_ *= direction_ == 0 ? 0.95 : 1;
	
	rope_start_x_ = rope_end_x_ + lengthdir_x(rope_length_, rope_angle_);
	rope_start_y_ = rope_end_y_ + lengthdir_y(rope_length_, rope_angle_);

	h_speed_ = rope_start_x_ - x;
	v_speed_ = rope_start_y_ - y; 

	if !place_meeting(o_dude.x + h_speed_, o_dude.y + v_speed_, o_solid) {
		o_dude.x += h_speed_;
		o_dude.y += v_speed_;
	} else {
		state_ = player.fall;
	}


	if (btn_Y_released) {
		var _momentum = 2*flipped_;
	
		if (v_speed_ < .5) {	
			v_speed_ += jump_height_/1.5;
			h_speed_ += _momentum;
			state_ = player.jump;
		}

		state_ = player.fall;
	
	}



}
