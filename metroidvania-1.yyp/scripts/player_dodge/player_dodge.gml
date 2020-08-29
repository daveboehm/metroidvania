function player_dodge() {
	set_gravity();
	set_movement();
	animating_ = true;

	h_speed_ = movement_speed_ * 2 * flipped_;

	if _is_frame(image_number - 1) {
		animating_ = false;
		h_speed_ = 1.75 * flipped_;
		if v_speed_ > 0 {
			state_ = player.fall;
		} else {
			state_ = player.idle;
		}
	}


}
