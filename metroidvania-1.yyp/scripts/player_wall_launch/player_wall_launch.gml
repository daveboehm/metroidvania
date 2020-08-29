function player_wall_launch() {
	set_gravity();

	animating_ = true;

	h_speed_ = -movement_speed_ * 1.5 * collide_x_;
	v_speed_ = jump_height_/2;

	x += h_speed_;
	y += v_speed_;

	if (v_speed_ >= 0) {
		state_ = player.fall;
	}




}
